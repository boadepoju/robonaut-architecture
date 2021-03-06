`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  CECS 440, Lab 3
// Engineer: Abodunrin Adepoju, 007209772
// 
// Create Date:    22:30:35 09/10/2011 
// Design Name: 
// Module Name:    regfile64 
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
module regfile64(clk, W_En, W_Addr, S_Addr, R_Addr, WR, R, S);

	input clk, W_En;
	input [63:0] WR;
	input [4:0] R_Addr, S_Addr, W_Addr;
	output [63:0] R, S;
	reg [63:0] R, S;
	
	
	reg [63:0] reg32[31:0];	
	
	// behavorial section for writing to the register
	always @(posedge clk)
	begin
		if (W_En)
			reg32[W_Addr] <= WR;
	end
   
	// behavorial section for assigning R data path
	always @(R_Addr or reg32[R_Addr])
	begin
		R <= reg32[R_Addr];
	end
	
	// behavorial section for assigning S data path
	always @(S_Addr or reg32[S_Addr])
	begin
		S <= reg32[S_Addr];
	end

endmodule
