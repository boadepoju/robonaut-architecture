`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:42:26 10/16/2011 
// Design Name: 
// Module Name:    memory 
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

module memory(Addr, Data, CS_, RD_, WR_, Clk);

input [9:0] Addr;
input CS_, RD_, WR_, Clk;
inout [31:0] Data;

reg [31:0] memarray [0:1023];
wire [31:0] Data;

assign Data = (!CS_ & !RD_) ? memarray[Addr] : 32'bz;

always @(posedge Clk)
	if (!CS_ & !WR_)
		memarray[Addr] = Data;
		

endmodule