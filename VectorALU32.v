`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:38:24 11/13/2011 
// Design Name: 
// Module Name:    VectorALU32 
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
module VectorALU32(R, S, ALU_Op, Y);

input [31:0] R, S;
input [4:0] ALU_Op;
output [31:0] Y;
reg [31:0] Y;

reg [63:0] Product_Register;
reg [31:0] Multiplicand;

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
		if (R[31] == 1'b0 && S[31] == 1'b0 && (R + S >= 32'h80000000))				// Packed Add, Unsigned Saturated
		begin
			Y = 32'h7FFFFFFF;
		end
		else if (R[15] == 1'b1 && S[15] == 1'b1 && (R + S <= 32'h7FFFFFFF))
		begin
			Y = 32'h80000000;
		end
		else
			Y = R + S;
			
	end
	5'b00111:																			// Packed Subtract, signed Saturated
	begin
		if (R[31] == 1'b0 && S[31] == 1'b1 && (R + S >= 32'h80000000))
			Y = 32'h7FFFFFFF;
		else if (R[31] == 1'b1 && S[31] == 1'b0 && (R + S <= 32'h7FFFFFFF))
			Y = 32'h80000000;
		else
			Y = R - S;
	end
	5'b01000:
	begin																					 // Multiplication
		case ({R[31],S[31]})                                            // Positive (R) times a Positive (S)
								2'b00: 
								begin		
                           Product_Register = {32'b0, S};	
                           Multiplicand = R;									
									repeat (32)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[63:32] = Product_Register[63:32] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end	
								Y = Product_Register[63:0];
								end
								
								2'b01:                                                         // Positive Multiplicand (R) times a Negative (S)
								begin
								   // Change multiplier to a positive number
									Product_Register = {32'b0, (~(S) + 1'b1)};
									Multiplicand = R;
									repeat (32)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[63:32] = Product_Register[63:32] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
							   // Change result back to a negative number
								Product_Register = -Product_Register;
								Y = Product_Register[63:0];
								end
									
								2'b10:                                                        	// Negative Multiplicand (R) times a Positive Multiplier (S)
								begin
								   Product_Register = {32'b0, S};
									Multiplicand = ~R + 1'b1;
									repeat (32)
			
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[63:32] = Product_Register[63:32] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								Product_Register = -Product_Register;
								Y = Product_Register[63:0];
								end
								
								2'b11:                                                         // Negative Multiplicand (R) times a Negative Multiplier (S)
								begin
									Product_Register = {32'b0, -S};
									Multiplicand = -R;
									repeat (32)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[63:32] = Product_Register[63:32] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								
								Y = Product_Register[63:0];
								end
								endcase
		end
	5'b01001:	
				Y = Product_Register[63:32];                       // Most Significant Word (MSW) of Multiplication	
	5'b01010:																	// Compare
	begin
				if ((R & S) == R)
				begin
					Y = 32'hFFFFFFFF;
				end
				else
					Y = 32'h00000000;
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
