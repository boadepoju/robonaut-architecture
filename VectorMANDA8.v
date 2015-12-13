`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:14:05 11/19/2011 
// Design Name: 
// Module Name:    VectorMANDA8 
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
module VectorMANDA8(R, S, ALU_Op, Y);

input [15:0] R, S;
input [4:0] ALU_Op;
output [15:0] Y;
reg [15:0] Y;

reg [15:0] Product_Register;
reg [7:0] Multiplicand;

always @(R or S or ALU_Op)
begin
	case (ALU_Op)
	5'b01010:	
		Y = R + S;                        // Addition	
	default:
		Y = S;
	endcase
			
end

endmodule
