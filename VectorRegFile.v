`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:32:33 11/13/2011 
// Design Name: 
// Module Name:    VectorRegFile 
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
module VectorRegFile(clk, W_En, W_Addr, S_Addr, R_Addr, WR, M_ALU_Out, R, S, R2, MANDA_En);

input clk, W_En, MANDA_En;
input [63:0] WR;
input [127:0] M_ALU_Out;
input [4:0] R_Addr, S_Addr, W_Addr;
output [63:0] R, S;
reg [63:0] R, S;

output [127:0] R2;
reg [127:0] R2;

reg [63:0] reg32[31:0];

// Temporary register location for MULANDADD instructions
reg [127:0] mandareg;

// behavorial section for writing to the register
always @(posedge clk)
begin
	if (W_En)
		reg32[W_Addr] <= WR;
		
	if (MANDA_En)
		mandareg <= M_ALU_Out;
end

always @(R_Addr or reg32[R_Addr])
begin
	
		R <= reg32[R_Addr];
		
	
end

always @(S_Addr or reg32[S_Addr])
begin
	
		S <= reg32[S_Addr];
		
end

always@(*)                 //  @(R_Addr or mandareg[R_Addr])
begin
	R2 <= mandareg;         // mandareg[R_Addr];
end

//always @(S_Addr or mandareg[S_Addr])
//begin
//	S2 <= mandareg[S_Addr];
//end


endmodule
