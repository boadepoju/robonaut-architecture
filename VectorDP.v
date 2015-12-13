`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:30:22 11/13/2011 
// Design Name: 
// Module Name:    VectorDP 
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
module VectorDP(S_Sel, W_En, W_Clk, W_Addr, R_Addr, S_Addr, ALU_Op, DS, V_Mode, MANDA_En, ALU_Out);

input W_En, W_Clk, S_Sel, MANDA_En;
input [4:0] W_Addr, R_Addr, S_Addr, ALU_Op;
input [2:0] V_Mode;
input [63:0] DS;

wire [63:0] R, S;
wire [63:0] ALU8_Out, ALU16_Out, ALU32_Out, ALU64_Out, ALU4_Out, ALU_Out, MandA4_Out, MandA8_Out, MandA16_Out;
output [63:0] ALU_Out;

wire [63:0] S_Out;


assign S_Out = S_Sel ? DS : S;

assign ALU_Out = (V_Mode == 3'b000) ? ALU4_Out : (V_Mode == 3'b001) ? ALU8_Out : (V_Mode == 3'b010) ? ALU16_Out : (V_Mode == 3'b011) ? ALU32_Out : (V_Mode == 3'b100) ? ALU64_Out : (V_Mode == 3'b101) ? MandA4_Out : (V_Mode == 3'b110) ? MandA8_Out : (V_Mode == 3'b111) ? MandA16_Out : ALU4_Out; 

// Wire Assignments for 127 bit output
wire [127:0] M_ALU_Out;
wire [127:0] M_ALU4_Out;
wire [127:0] M_ALU8_Out;
wire [127:0] M_ALU16_Out;

// Wire From output of MANDA REGISTER
wire [127:0] R2;

// Assign statement for Wire Assignments for 127 bit output
assign M_ALU_Out = (V_Mode == 3'b101) ? M_ALU4_Out : (V_Mode == 3'b110) ? M_ALU8_Out : (V_Mode == 3'b111) ? M_ALU16_Out : M_ALU4_Out;


// VectorRegFile(clk, W_En, W_Addr, S_Addr, R_Addr, WR, R, S); 
VectorRegFile VectorRegFile(W_Clk, W_En, W_Addr, S_Addr, R_Addr, ALU_Out, M_ALU_Out, R, S, R2, MANDA_En);

// module VectorALU(R, S, ALU_Op, Y); // Packed Byte
// 8 bits
VectorALU VectorALU0(R[63:56], S_Out[63:56], ALU_Op, ALU8_Out[63:56], M_ALU8_Out[127:112]),
			 VectorALU1(R[55:48], S_Out[55:48], ALU_Op, ALU8_Out[55:48], M_ALU8_Out[111:96]),
			 VectorALU2(R[47:40], S_Out[47:40], ALU_Op, ALU8_Out[47:40], M_ALU8_Out[95:80]),
			 VectorALU3(R[39:32], S_Out[39:32], ALU_Op, ALU8_Out[39:32], M_ALU8_Out[79:64]),
			 VectorALU4(R[31:24], S_Out[31:24], ALU_Op, ALU8_Out[31:24], M_ALU8_Out[63:48]),
			 VectorALU5(R[23:16], S_Out[23:16], ALU_Op, ALU8_Out[23:16], M_ALU8_Out[47:32]),
			 VectorALU6(R[15:8], S_Out[15:8], ALU_Op, ALU8_Out[15:8],	  M_ALU8_Out[31:16]),
			 VectorALU7(R[7:0], S_Out[7:0], ALU_Op, ALU8_Out[7:0],		  M_ALU8_Out[15:0]);

// Packed Word
// 16 bits
VectorALU16 VectorALU16_0(R[63:48], S_Out[63:48], ALU_Op, ALU16_Out[63:48], M_ALU16_Out[127:96]),
				VectorALU16_1(R[47:32], S_Out[47:32], ALU_Op, ALU16_Out[47:32], M_ALU16_Out[95:64]),
				VectorALU16_2(R[31:16], S_Out[31:16], ALU_Op, ALU16_Out[31:16], M_ALU16_Out[63:32]),
				VectorALU16_3(R[15:0], S_Out[15:0], ALU_Op, ALU16_Out[15:0], 	 M_ALU16_Out[31:0]);

// Packed Doubleword
// 32 bits				
VectorALU32 VectorALU32_0(R[63:32], S_Out[63:32], ALU_Op, ALU32_Out[63:32]),
				VectorALU32_1(R[31:0], S_Out[31:0], ALU_Op, ALU32_Out[31:0]);
				
// Quadword
// 64 bits
VectorALU64 VectorALU64_0(R[63:0], S_Out[63:0], ALU_Op, ALU64_Out[63:0]);

// Packed Nibble
// 4 bits
VectorALU4	VectorALU4_0(R[63:60], S_Out[63:60], ALU_Op, ALU4_Out[63:60], M_ALU4_Out[127:120]),
				VectorALU4_1(R[59:56], S_Out[59:56], ALU_Op, ALU4_Out[59:56], M_ALU4_Out[119:112]),
				VectorALU4_2(R[55:52], S_Out[55:52], ALU_Op, ALU4_Out[55:52], M_ALU4_Out[111:104]),
				VectorALU4_3(R[51:48], S_Out[51:48], ALU_Op, ALU4_Out[51:48], M_ALU4_Out[103:96]),
				VectorALU4_4(R[47:44], S_Out[47:44], ALU_Op, ALU4_Out[47:44], M_ALU4_Out[95:88]),
				VectorALU4_5(R[43:40], S_Out[43:40], ALU_Op, ALU4_Out[43:40], M_ALU4_Out[87:80]),
				VectorALU4_6(R[39:36], S_Out[39:36], ALU_Op, ALU4_Out[39:36], M_ALU4_Out[79:72]),
				VectorALU4_7(R[35:32], S_Out[35:32], ALU_Op, ALU4_Out[35:32], M_ALU4_Out[71:64]),
				VectorALU4_8(R[31:28], S_Out[31:28], ALU_Op, ALU4_Out[31:28], M_ALU4_Out[63:56]),
				VectorALU4_9(R[27:24], S_Out[27:24], ALU_Op, ALU4_Out[27:24], M_ALU4_Out[55:48]),
				VectorALU4_10(R[23:20], S_Out[23:20], ALU_Op, ALU4_Out[23:20], M_ALU4_Out[47:40]),
				VectorALU4_11(R[19:16], S_Out[19:16], ALU_Op, ALU4_Out[19:16], M_ALU4_Out[39:32]),
				VectorALU4_12(R[15:12], S_Out[15:12], ALU_Op, ALU4_Out[15:12], M_ALU4_Out[31:24]),
				VectorALU4_13(R[11:8], S_Out[11:8], ALU_Op, ALU4_Out[11:8],    M_ALU4_Out[23:16]),
				VectorALU4_14(R[7:4], S_Out[7:4], ALU_Op, ALU4_Out[7:4],       M_ALU4_Out[15:8]),
				VectorALU4_15(R[3:0], S_Out[3:0], ALU_Op, ALU4_Out[3:0],       M_ALU4_Out[7:0]);
				
				
// MULANDADD ALU
// 4 bit [127] TEMP to 8 bit 
VectorMANDA4	VectorMANDA4_0(R2[127:120], R2[119:112], ALU_Op, MandA4_Out[63:56]),
					VectorMANDA4_1(R2[111:104], R2[103:96], ALU_Op,  MandA4_Out[55:48]),
					VectorMANDA4_2(R2[95:88],   R2[87:80], ALU_Op,   MandA4_Out[47:40]),
					VectorMANDA4_3(R2[79:72],   R2[71:64], ALU_Op,   MandA4_Out[39:32]),
					VectorMANDA4_4(R2[63:56],   R2[55:48], ALU_Op,   MandA4_Out[31:24]),
					VectorMANDA4_5(R2[47:40],   R2[39:32], ALU_Op,   MandA4_Out[23:16]),
					VectorMANDA4_6(R2[31:24],   R2[23:16], ALU_Op,   MandA4_Out[15:8]),
					VectorMANDA4_7(R2[15:8],    R2[7:0],   ALU_Op,   MandA4_Out[7:0]);
					
// MULANDADD ALU
// 8 bit [127] TEMP to 16 bit
VectorMANDA8	VectorMANDA8_0(R2[127:112], R2[111:96], ALU_Op, MandA8_Out[63:48]),
					VectorMANDA8_1(R2[95:80],   R2[79:64], ALU_Op,  MandA8_Out[47:32]),
					VectorMANDA8_2(R2[63:48],   R2[47:32], ALU_Op,  MandA8_Out[31:16]),
					VectorMANDA8_3(R2[31:16],   R2[15:0],  ALU_Op,    MandA8_Out[15:0]);
					
// MULANDADD ALU
// 16 bit [127] TEMP to 32 bit
VectorMANDA16	VectorMANDA16_0(R2[127:96], R2[95:64], ALU_Op, MandA16_Out[63:32]),
					VectorMANDA16_1(R2[63:32],   R2[31:0], ALU_Op,  MandA16_Out[31:0]);
					

					

				

endmodule
