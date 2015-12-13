`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:28:38 11/13/2011 
// Design Name: 
// Module Name:    VectorALU16 
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
module VectorALU16(R, S, ALU_Op, Y, Y2);

input [15:0] R, S;
input [4:0] ALU_Op;
output [15:0] Y;
reg [15:0] Y;

output [31:0] Y2;
reg [31:0] Y2;

reg [31:0] Product_Register;
reg [15:0] Multiplicand;

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
		if (R[15] == 1'b0 && S[15] == 1'b0 && (R + S >= 16'h8000))				// Packed Add, Unsigned Saturated
		begin
			Y = 16'h7FFF;
		end
		else if (R[15] == 1'b1 && S[15] == 1'b1 && (R + S <= 16'h7FFF))
		begin
			Y = 16'h8000;
		end
		else
			Y = R + S;
			
	end
	5'b00111:																			// Packed Subtract, signed Saturated
	begin
		if (R[15] == 1'b0 && S[15] == 1'b1 && (R + S >= 16'h8000))
			Y = 16'h7FFF;
		else if (R[15] == 1'b1 && S[15] == 1'b0 && (R + S <= 16'h7FFF))
			Y = 16'h8000;
		else
			Y = R - S;
	end
		
				
	5'b01000:	
		begin																					// Multiplication
		case ({R[15],S[15]})                                            // Positive (R) times a Positive (S)
								2'b00: 
								begin		
                           Product_Register = {16'b0, S};	
                           Multiplicand = R;									
									repeat (16)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[31:16] = Product_Register[31:16] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end	
								Y2 = Product_Register[31:0];
								end
								
								2'b01:                                                         // Positive Multiplicand (R) times a Negative (S)
								begin
								   // Change multiplier to a positive number
									Product_Register = {16'b0, (~(S) + 1'b1)};
									Multiplicand = R;
									repeat (16)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[31:16] = Product_Register[31:16] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
							   // Change result back to a negative number
								Product_Register = -Product_Register;
								Y2 = Product_Register[31:0];
								end
									
								2'b10:                                                        	// Negative Multiplicand (R) times a Positive Multiplier (S)
								begin
								   Product_Register = {16'b0, S};
									Multiplicand = ~R + 1'b1;
									repeat (16)
			
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[31:16] = Product_Register[31:16] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								Product_Register = -Product_Register;
								Y2 = Product_Register[31:0];
								end
								
								2'b11:                                                         // Negative Multiplicand (R) times a Negative Multiplier (S)
								begin
									Product_Register = {16'b0, -S};
									Multiplicand = -R;
									repeat (16)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[31:16] = Product_Register[31:16] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								
								Y2 = Product_Register[31:0];
								end
								endcase
				end
	5'b01001:	
				Y2 = Product_Register[31:0];                       // Most Significant Word (MSW) of Multiplication	
	5'b01010:																	// Compare
	begin
				if ((R & S) == R)
				begin
					Y = 16'hFFFF;
				end
				else
					Y = 16'h0000;
	end	
	5'b01011:
				Y = S;

	default:
		Y = S;
	endcase
			
end


endmodule
