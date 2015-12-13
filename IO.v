`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:24:14 11/18/2011 
// Design Name: 
// Module Name:    IO 
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
module IO(Addr, Data, IO_CS_, IO_RD_, IO_WR_, Clk, interrupt, int_ack);

input [9:0] Addr;
input IO_CS_, IO_RD_, IO_WR_, Clk;
inout [31:0] Data;

reg [31:0] memarray [0:1023];
wire [31:0] Data;

// Interrupt Assertation
output interrupt;
reg interrupt;

// Interrupt Acknowledge
input int_ack;

assign Data = (!IO_CS_ & !IO_RD_) ? memarray[Addr] : 32'bz;

initial begin
interrupt = 1'b0;
end

always @(posedge Clk)
	if (!IO_CS_ & !IO_WR_)
		memarray[Addr] = Data;
   

endmodule
