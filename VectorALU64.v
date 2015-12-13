`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:06:09 11/18/2011 
// Design Name: 
// Module Name:    VectorALU64 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VectorALU64(R, S, ALU_Op, Y);

input [63:0] R, S;
input [4:0] ALU_Op;
output [63:0] Y;
reg [63:0] Y;

reg [127:0] Product_Register;
reg [63:0] Multiplicand;


always @(R or S or ALU_Op)
begin
	case (ALU_Op)
	5'b00000:
		Y = R + S;
	5'b00001: 
		Y = S;
	5'b00010:
		Y = R - S;
	5'b00011:
		Y = R & S;
	5'b00100:
		Y = R | S;
	5'b00101:
		Y = R ^ S;
	5'b00110:
	begin
	//	Y = R + S;
		if (R[63] == 1'b0 && S[63] == 1'b0 && (R + S >= 64'h8000000000000000))				// Packed Add, Signed Saturated
		begin
			Y = 64'h7FFFFFFFFFFFFFFF;
		end
		else if (R[63] == 1'b1 && S[63] == 1'b1 && (R + S <= 64'h7FFFFFFFFFFFFFFF))
		begin
			Y = 64'h8000000000000000; 
		end
		else
			Y = R + S;
			
	end
	5'b00111:																			// Packed Subtract, signed Saturated
	begin
		if (R[63] == 1'b0 && S[63] == 1'b1 && (R + S >= 64'h8000000000000000))
			Y = 64'h7FFFFFFFFFFFFFFF;
		else if (R[63] == 1'b1 && S[63] == 1'b0 && (R + S <= 64'h7FFFFFFFFFFFFFFF))
			Y = 64'h8000000000000000;
		else
			Y = R - S;
	end
	5'b01000:
   begin        							                                            			// Multiplication
								
                   		case ({R[63],S[63]})                                            // Positive (R) times a Positive (S)
								2'b00: 
								begin		
                           Product_Register = {64'b0, S};	
                           Multiplicand = R;									
									repeat (64)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[127:64] = Product_Register[127:64] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end	
								Y = Product_Register[127:0];
								end
								
								2'b01:                                                         // Positive Multiplicand (R) times a Negative (S)
								begin
								   // Change multiplier to a positive number
									Product_Register = {64'b0, (~(S) + 1'b1)};
									Multiplicand = R;
									repeat (64)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[127:64] = Product_Register[127:64] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
							   // Change result back to a negative number
								//Y = ~(Product_Register[63:0] + 1);
								Product_Register = -Product_Register;
								Y = Product_Register[127:0];
								//{C, Y} = {1'b0, (~Product_Register[63:0] + 1'b1)};
								end
									
								2'b10:                                                        	// Negative Multiplicand (R) times a Positive Multiplier (S)
								begin
								   Product_Register = {64'b0, S};
									Multiplicand = ~R + 1'b1;
									repeat (64)
			
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[127:64] = Product_Register[127:64] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								Product_Register = -Product_Register;
								Y = Product_Register[127:0];
								end
								
								2'b11:                                                         // Negative Multiplicand (R) times a Negative Multiplier (S)
								begin
									Product_Register = {64'b0, -S};
									Multiplicand = -R;
									repeat (64)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[127:64] = Product_Register[127:64] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								//Y = ~Product_Register[63:0] + 1'b1;
								
								Y = Product_Register[127:0];
								end
									
								endcase
							end 
			5'b01001:   Y = Product_Register[127:64];                       // Most Significant Word (MSW) of Multiplication
			
			
			5'b01010:																	// Compare
			begin
				if ((R & S) == R)
				begin
					Y = 64'hFFFFFFFFFFFFFFFF;
				end
				else
					Y = 64'h0000000000000000;
			end
			5'b01011:
				Y = S;
			5'b11111:
			begin
			end

	default:
		Y = S;
			
	endcase
			
end





endmodule
