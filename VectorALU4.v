`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:12 11/18/2011 
// Design Name: 
// Module Name:    VectorALU4 
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
module VectorALU4(R, S, ALU_Op, Y, Y2);

input [3:0] R, S;
input [4:0] ALU_Op;
output [3:0] Y;
reg [3:0] Y;

output [7:0] Y2;
reg [7:0] Y2;

reg [7:0] Product_Register;
reg [3:0] Multiplicand;

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
		if (R[3] == 1'b0 && S[3] == 1'b0 && (R + S >= 4'h8))				// Packed Add, signed Saturated
		begin
			Y = 4'h7;
		end
		else if (R[3] == 1'b1 && S[3] == 1'b1 && (R + S <= 4'h7))
		begin
			Y = 4'h8;
		end
		else
			Y = R + S;
			
	end
	5'b00111:																			// Packed Subtract, signed Saturated
	begin
		if (R[3] == 1'b0 && S[3] == 1'b1 && (R + S >= 4'h8))
			Y = 4'h7;
		else if (R[3] == 1'b1 && S[3] == 1'b0 && (R + S <= 4'h7))
			Y = 4'h8;
		else
			Y = R - S;
	end
	5'b01000:
  begin                        							                            			// Multiplication
								
                   		case ({R[3],S[3]})                                            // Positive (R) times a Positive (S)
								2'b00: 
								begin		
                           Product_Register = {4'b0, S};	
                           Multiplicand = R;									
									repeat (4)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[7:4] = Product_Register[7:4] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end	
								Y2 = Product_Register[7:0];
								end
								
								2'b01:                                                         // Positive Multiplicand (R) times a Negative (S)
								begin
								   // Change multiplier to a positive number
									Product_Register = {4'b0, (~(S) + 1'b1)};
									Multiplicand = R;
									repeat (4)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[7:4] = Product_Register[7:4] + Multiplicand;
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
								Y2 = Product_Register[7:0];
								//{C, Y} = {1'b0, (~Product_Register[63:0] + 1'b1)};
								end
									
								2'b10:                                                        	// Negative Multiplicand (R) times a Positive Multiplier (S)
								begin
								   Product_Register = {4'b0, S};
									Multiplicand = ~R + 1'b1;
									repeat (4)
			
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[7:4] = Product_Register[7:4] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								Product_Register = -Product_Register;
								Y2 = Product_Register[7:0];
								end
								
								2'b11:                                                         // Negative Multiplicand (R) times a Negative Multiplier (S)
								begin
									Product_Register = {4'b0, -S};
									Multiplicand = -R;
									repeat (4)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[7:4] = Product_Register[7:4] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								//Y = ~Product_Register[63:0] + 1'b1;
								
								Y2 = Product_Register[7:0];
								end
									
								endcase
							end 
			5'b01001:    Y2 = Product_Register[7:4];                       // Most Significant Word (MSW) of Multiplication
			5'b11111:
			begin
			end
			5'b01010:																	// Compare
			begin
				if ((R & S) == R)
				begin
					Y = 4'hF;
				end
				else
					Y = 4'h0;
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
