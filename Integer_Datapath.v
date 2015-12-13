`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ROBONAUT PROCESSOR
//////////////////////////////////////////////////////////////////////////////////
module Integer_Datapath(W_En, W_Clk, W_Addr, S_Addr, DS, imm_Op, S_Sel, 
DY, Y_Sel, PC_En, Call_En, Ret_En, PC_Reset, Jump_En, Jump_Reg, PC_Out, SP_Dec, SP_Inc, SP_Out, R_Addr, ALU_OP, REG_OUT, ALU_OUT, SOL, SOR, N, Z, C, V, RdBuf1Wire, RdBuf0Wire, EX_En, WR_Sel);

// Program Counter Register
reg [63:0] PC;

// Return Address Register (for CALL instructions)
reg [63:0] RA;

// Stack Pointer Register
reg [63:0] SP;

// Intermediate Register (for EXCHANGE)
reg [63:0] Intermediate_Reg;

// Inputs
input Y_Sel, PC_En, PC_Reset, Jump_En, Jump_Reg, Call_En, Ret_En, EX_En, WR_Sel;
input SP_Dec, SP_Inc;
input [1:0] S_Sel;
input W_Clk, W_En;
input [63:0] DS, DY;
input [63:0] imm_Op;
input [4:0] R_Addr, S_Addr, W_Addr, ALU_OP;

input [31:0] RdBuf1Wire, RdBuf0Wire;

// Outputs 
output [63:0] ALU_OUT, REG_OUT;
wire [63:0] ALU_OUT, REG_OUT, WR;
output N, Z, C, V, SOL, SOR;
wire N, Z, C, V, SOL, SOR;

// Wires and Assign Statements
wire [63:0] S, Y, S_Out;
// assign S_Out = S_Sel ? S : DS;
assign ALU_OUT = Y_Sel ? Y : DY;

assign WR = WR_Sel ? Intermediate_Reg : ALU_OUT;

output [63:0] PC_Out;
assign PC_Out = PC;

output [63:0] SP_Out;
assign SP_Out = SP;


//                     1                       0                                         
assign S_Out = (S_Sel == 2'b00) ? S : (S_Sel == 2'b01) ? DS : (S_Sel == 2'b10) ? imm_Op : S;

initial begin
SP = 12'h3F9;       // Stack Pointer initialization
end

// Program Counter Clock Logic
always @(posedge W_Clk)
begin

	if (PC_En)
		PC <= PC + 1'b1;
		
	if (PC_Reset)
		PC <= 64'h0;
	
	if (Jump_En)
	   PC <= DS + PC;
		
	if (Jump_Reg)
		PC <= REG_OUT;
		
	if (Call_En)
		RA <= PC;
		
	if (Ret_En)
		PC <= {RdBuf1Wire, RdBuf0Wire};
		
	//if (EX_En)
	//	Intermediate_Reg <= ALU_OUT;
		
end

always@(*)
begin
	if (EX_En)
	Intermediate_Reg <= ALU_OUT;
end

// Stack Pointer Clock Logic
always @(posedge W_Clk)
begin

	if (SP_Dec)
		SP <= SP - 2;
		
	if (SP_Inc)
		SP <= SP + 2;

end
	
// module regfile64(clk, W_En, W_Addr, S_Addr, R_Addr, WR, R, S);
regfile64 regfile64(W_Clk, W_En, W_Addr, S_Addr, R_Addr, WR, 
REG_OUT, S);

// module alu(R, S, Alu_Op, Y, N, Z, C, V, SOR, SOL);
alu alu(REG_OUT, S_Out, ALU_OP, Y, N, Z, C, V, SOR, SOL);




endmodule
