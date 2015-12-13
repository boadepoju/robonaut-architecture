`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:15:39 11/19/2011 
// Design Name: 
// Module Name:    VectorMANDA16 
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
module VectorMANDA16(R, S, ALU_Op, Y);


input [31:0] R, S;
input [4:0] ALU_Op;
output [31:0] Y;
reg [31:0] Y;

reg [15:0] Product_Register;
reg [7:0] Multiplicand;

always @(R or S or ALU_Op)
begin
//	$display(" ");
//$display("We entered VECTOR M AND D 16!!!");
//$display(" ");
	case (ALU_Op)
	5'b01010:	
		Y = R + S;                        // Addition	
	default:
	Y = 0;
	endcase
	//$display("R = %h", R);
	//$display("S = %h", S);
	//$display("Y = %h", Y);
	
end
 


endmodule
