`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:39:21 11/13/2011 
// Design Name: 
// Module Name:    VectorALU 
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
module VectorALU(R, S, ALU_Op, Y, Y2);

input [7:0] R, S;
input [4:0] ALU_Op;
output [7:0] Y;
reg [7:0] Y;

output [15:0] Y2;
reg [15:0] Y2;

reg [15:0] Product_Register;
reg [7:0] Multiplicand;

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
		if (R[7] == 1'b0 && S[7] == 1'b0 && (R + S >= 8'h80))				// Packed Add, signed Saturated
		begin
			Y = 8'h7F;
		end
		else if (R[7] == 1'b1 && S[7] == 1'b1 && (R + S <= 8'h7F))
		begin
			Y = 8'h80;
		end
		else
			Y = R + S;
			
	end
	5'b00111:																			// Packed Subtract, signed Saturated
	begin
		if (R[7] == 1'b0 && S[7] == 1'b1 && (R + S >= 8'h80))
			Y = 8'h7F;
		else if (R[7] == 1'b1 && S[7] == 1'b0 && (R + S <= 8'h7F))
			Y = 8'h80;
		else
			Y = R - S;
	end
	
	5'b01000:																			// Multiplication
	begin
		case ({R[7],S[7]})                                            // Positive (R) times a Positive (S)
								2'b00: 
								begin		
                           Product_Register = {8'b0, S};	
                           Multiplicand = R;									
									repeat (8)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[15:8] = Product_Register[15:8] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end	
								Y2 = Product_Register[15:0];
								end
								
								2'b01:                                                         // Positive Multiplicand (R) times a Negative (S)
								begin
								   // Change multiplier to a positive number
									Product_Register = {8'b0, (~(S) + 1'b1)};
									Multiplicand = R;
									repeat (8)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[15:8] = Product_Register[15:8] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
							   // Change result back to a negative number
								Product_Register = -Product_Register;
								Y2 = Product_Register[15:0];
								end
									
								2'b10:                                                        	// Negative Multiplicand (R) times a Positive Multiplier (S)
								begin
								   Product_Register = {8'b0, S};
									Multiplicand = ~R + 1'b1;
									repeat (8)
			
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[15:8] = Product_Register[15:8] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								Product_Register = -Product_Register;
								Y2 = Product_Register[15:0];
								end
								
								2'b11:                                                         // Negative Multiplicand (R) times a Negative Multiplier (S)
								begin
									Product_Register = {8'b0, -S};
									Multiplicand = -R;
									repeat (8)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[15:8] = Product_Register[15:8] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								
								Y2 = Product_Register[15:0];
								end
								endcase
		
		end
		
		
	5'b01001:	
				Y2 = Product_Register[15:8];                       // Most Significant Word (MSW) of Multiplication	
	5'b01010:																	// Compare
	begin
				if ((R & S) == R)
				begin
					Y = 8'hFF;
				end
				else
					Y = 8'h00;
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
