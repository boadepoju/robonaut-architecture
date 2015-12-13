`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  CECS 440
// Engineer: Abodunrin Adepoju, Bruno Venegas
// 
// Create Date:    12:54:15 10/16/2011 
// Design Name: 
// Module Name:    biu 
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
module biu(clk, FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, MAR_En_PC, MAR_En_SP, inc_en, WR1_En, WR0_En, IR_En, FP_Out, REG_OUT, ALU_OUT, DS, imm_Op, mem_addr_bus, mem_data_bus, Rd_Buff_Out, FP1OE, FP0OE, WR1OE, WR0OE, IR_Wire, PC_Out, SP_Out, WR1Sel, WR0Sel, RdBuf1Wire, RdBuf0Wire, FP_R_OUT, MAR_En_FP, Int_En, FR_Out, WR0_FR_En, VALU_Out, VR1_En, VR0_En, VR1OE, VR0OE);

// Inputs
input clk, FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, MAR_En_PC, MAR_En_SP, MAR_En_FP, inc_en, WR1_En, WR0_En, IR_En, FP1OE, FP0OE, WR1OE, WR0OE;
input [63:0] FP_Out, REG_OUT, ALU_OUT, PC_Out, SP_Out, FP_R_OUT;
input WR0_FR_En;

input WR1Sel, WR0Sel;

input Int_En;

input [63:0] FR_Out;

input [63:0] VALU_Out;

// Outputs
output [63:0] DS, imm_Op, Rd_Buff_Out, mem_addr_bus;
wire [63:0] DS, imm_Op, Rd_Buff_Out, mem_addr_bus;

output [31:0] IR_Wire;
wire [31:0] IR_Wire;

output [31:0] RdBuf1Wire, RdBuf0Wire;
wire [31:0] RdBuf1Wire, RdBuf0Wire;

// Inout Data Bus
inout [31:0] mem_data_bus;
wire [31:0] mem_data_bus;

// Wires to select either PC or ALU_OUT for writing
wire [31:0] WR1_input, WR0_input;

// Registers
reg [31:0] FPBuf_1, FPBuf_0, RdBuf_1, RdBuf_0, WRBuf_1, WRBuf_0, IR;
reg [63:0] MAR;

// Vector Path
reg [31:0] VRBuf_1, VRBuf_0;
input VR1_En, VR0_En;
input VR1OE, VR0OE;

// Clock Sequential Logic
always @(posedge clk)
begin
	
	if (VR1_En)
		VRBuf_1 <= VALU_Out[63:32];
		
	if (VR0_En)
		VRBuf_0 <= VALU_Out[31:0];

	if (FP1_En)
		FPBuf_1 <= FP_Out[63:32];
	
	if (FP0_En)
		FPBuf_0 <= FP_Out[31:0];
	
	if (Rd1_En)
		RdBuf_1 <= mem_data_bus[31:0];
	
	if (Rd0_En)
		RdBuf_0 <= mem_data_bus[31:0];
		
	if (MAR_En)
		MAR <= REG_OUT;
		
	if (MAR_En_PC)
		MAR <= PC_Out;
		
	if (MAR_En_SP)
		MAR <= SP_Out;
		
	if (MAR_En_FP)
		MAR <= FP_R_OUT;
		
	if (inc_en)
		MAR <= MAR + 1'b1;
		
	if (WR1_En)
		WRBuf_1 <= WR1_input;
	
	if (WR0_En)
		WRBuf_0 <= WR0_input;
		
	if (WR0_FR_En)
	begin
		WRBuf_0 <= FR_Out[31:0];
		WRBuf_1 <= FR_Out[63:32];
	end
	
	if (IR_En)
		IR <= mem_data_bus[31:0];
		
	if (Int_En)
		MAR <= 64'h00000000000003FE;
	
end

// Assign Statements
assign DS = IR[23] ? {40'hFFFFFFFFFF, IR[23:0]} : {40'b0, IR[23:0]};	
assign imm_Op = IR[15] ? {56'hFFFFFFFFFFFFFF, IR[15:8]} : {56'b0, IR[15:8]};
assign mem_addr_bus = MAR;
assign Rd_Buff_Out = {RdBuf_1, RdBuf_0};	
assign   mem_data_bus =  FP1OE ? FPBuf_1 : 32'bz;
assign	mem_data_bus =  FP0OE ? FPBuf_0 : 32'bz;
assign	mem_data_bus =  WR1OE ? WRBuf_1 : 32'bz;
assign	mem_data_bus =  WR0OE ? WRBuf_0 : 32'bz;

assign   mem_data_bus =  VR1OE ? VRBuf_1 : 32'bz;
assign	mem_data_bus =  VR0OE ? VRBuf_0 : 32'bz;

assign IR_Wire = IR;

assign WR1_input = WR1Sel ? PC_Out[63:32] : ALU_OUT[63:32];
assign WR0_input = WR0Sel ? PC_Out[31:0] : ALU_OUT[31:0]; 

assign RdBuf1Wire = RdBuf_1;
assign RdBuf0Wire = RdBuf_0;

endmodule
