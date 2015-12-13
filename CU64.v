`timescale 1ps/ 100fs
/************************************************************************************** 
* Date: 			 October 26, 2011 
* File: 			 CU64.v 
* Engineers: 	 Abodunrin Adepoju, Bruno Venegas
* Project Name: Lab 6
* Class:			 CECS 440 
* 
* A state machine that implements the Control Unit (CU) for the major cycles of fetch, 
* execute and some 440 ISA instructions from memory, including checking for interrupts. 
*-------------------------------------------------------------------------------------- 
*                        CU    C O N T R O L     W O R D 
*------------------------------------------------------------------------------- 
* R_Addr=0;    S_Addr=0;    W_Addr=0;    W_En=0;      Alu_Op=NOP;  sil=0; sir=0; 
* S_Sel=0;     Y_Sel=0;     IR_ld=0;     MAR_ld=0;    MAR_inc=0; 
* RdBuf1_ld=0; RdBuf0_ld=0; WrBuf1_ld=0; WrBuf0_ld=0; WrBuf1_oe=0; WrBuf0_oe=0; 
* Mem_rd=1;    Mem_wr=1;    Mem_cs=1;    int_ack=0; 
********************************************************************************/ 

/*******************************************************************************
*------------------------------------------------------------------------------- 
*                   C O N T R O L     W O R D     F O R M A T S 
*------------------------------------------------------------------------------- 
FP Datapath Selectors       (25 bits)   -  {FW_En, F_Sel, FW_Addr, FS_Addr, 
														  FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE,
														  FP0OE}    
Integer Datapath Selectors  (30 bits)   -  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, 
                                            W_Addr, ALU_OP, PC_En, PC_Reset, Call_En,
														  Ret_En, SP_Inc, SP_Dec}
BIU Selectors               (24 bits)   -  {FP1_En, FP0_En, Rd1_En, Rd0_En, 
                                            MAR_En, inc_en, 
														  WR1_En, WR0_En, IR_En, FP1OE, FP0OE, 
														  WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel,
														  WR0Sel, MAR_En_FP, Int_En, WR0_FR_En, VR1_En,
														  VR0_En, VR1OE, VR0OE}
														  
Vector Datapath Selectors   (26 bits)   -  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_Op,
															V_Mode, MANDA_En}
															
I/O Selectors               (3 bits)    - {IO_CS_, IO_RD_, IO_WR_}

Memory Selectors            (3 bits)    -  {CS_, RD_, WR_}

// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP,
					Int_En, WR0_FR_En, VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000000000000000000000000;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					= 26'b0_0_00000_00000_00000_00000_000_0;
******************************************************************************/
 
//***************************************************************************** 
module  CU64 (sys_clk, reset,       // System Inputs 
              c, n, z, v, sol, sor,	     // Flags
				  FP_Status,					  // Floating Point Status
              int_ack,                   // Output to I/O subsystem 
				  W_En, W_Addr, S_Addr, 
				  S_Sel, Y_Sel, R_Addr, 
				  ALU_OP,						  // IDP
				  Jump_En, Jump_Reg,			  // Jump Boolean
				  PC_En,	PC_Reset,			  // Program Counter
				  Call_En, Ret_En,           // Call_En: RA <= PC; Ret_En: PC <= RA;
				  FW_En, F_Sel, FW_Addr, 
				  FS_Addr, FR_Addr, 			  // FPDP
				  FP_Op, FP1_En, FP0_En,
				  FP1OE, FP0OE,				  
				  Rd1_En, Rd0_En, MAR_En,
				  MAR_En_PC,
				  inc_en, WR1_En, WR0_En,
				  IR_En, WR1OE, WR0OE,		  // BIU
				  Mem_CS_, Mem_RD_,          // Memory
				  Mem_WR_, IR_Wire,
				  Flag_N_Sel, Flag_Z_Sel, Flag_V_Sel, Flag_C_Sel,
				  MAR_En_SP, SP_Dec, SP_Inc, MAR_En_FP,
				  WR1Sel, WR0Sel,
				  VW_En, VR_Addr, VS_Addr, VW_Addr, VALU_OP, VS_Sel, V_Mode,  // Vector
				  EX_En, WR_Sel,
				  IO_CS_, IO_RD_, IO_WR_, intr, Int_En,
				  FR_Out, WR0_FR_En, RdBuf0Wire, RdBuf1Wire,
				  MANDA_En,
				  VR1_En, VR0_En, VR1OE, VR0OE);	
//***************************************************************************** 
  
   // Inputs
   input       sys_clk, reset;   
   input       c, n, z, v, sol, sor;    
	input 		[5:0] FP_Status;
	input 		[31:0] IR_Wire; 
	
	input 		[31:0] RdBuf0Wire, RdBuf1Wire;
	
	// Interrupt Initialization
	input			intr;
	
	// Outputs
   output      int_ack;                 
   output      W_En, Y_Sel, Rd1_En, Rd0_En,
					FW_En, F_Sel, FP1_En, FP0_En, FP1OE, FP0OE,
					MAR_En, MAR_En_PC, inc_en, WR1_En, WR0_En, IR_En, WR1OE, WR0OE,
					Mem_CS_, Mem_RD_, Mem_WR_;
	output		IO_CS_, IO_RD_, IO_WR_;
	output		MAR_En_SP, SP_Inc, SP_Dec;
	output      MAR_En_FP;
	output      [1:0] S_Sel;
	output		PC_En, Call_En, Ret_En, PC_Reset;
	output		[3:0] FP_Op;
	output		[4:0] R_Addr, S_Addr, W_Addr, ALU_OP,
							FR_Addr, FS_Addr, FW_Addr;
	output 		Jump_En, Jump_Reg;
	output   	[2:0] Flag_N_Sel, Flag_C_Sel, Flag_V_Sel, Flag_Z_Sel;
	output      WR1Sel, WR0Sel;
	output 		EX_En, WR_Sel;
	output		Int_En;
	
	// Places Flag Register in WRBuf_0
	output 		WR0_FR_En;
	
	// Flag Register Output
	output 		[63:0] FR_Out;
	
	// VDP Outputs
	output VW_En, VS_Sel;
	output [4:0] VR_Addr, VS_Addr, VW_Addr;
	output [4:0] VALU_OP;
	output [2:0] V_Mode;
	output VR1_En, VR0_En, VR1OE, VR0OE;
	output	MANDA_En;
	
   reg         int_ack;             
   reg         W_En, Y_Sel, Rd1_En, Rd0_En,
					FW_En, F_Sel, FP1_En, FP0_En, FP1OE, FP0OE,
					MAR_En, inc_en, WR1_En, WR0_En, IR_En, WR1OE, WR0OE,
					Mem_CS_, Mem_RD_, Mem_WR_;
	reg 			IO_CS_, IO_RD_, IO_WR_;
	reg         MAR_En_SP, SP_Inc, SP_Dec;
	reg         [1:0] S_Sel;
	reg			PC_En, MAR_En_PC, PC_Reset, Call_En, Ret_En;
	reg			[2:0] Flag_N_Sel, Flag_Z_Sel, Flag_V_Sel, Flag_C_Sel;
	reg			[3:0] FP_Op;
	reg			[4:0] R_Addr, S_Addr, W_Addr, ALU_OP,
							FR_Addr, FS_Addr, FW_Addr; 
	reg 			Jump_En, Jump_Reg;
	reg			WR1Sel, WR0Sel;
	reg			MAR_En_FP;
	reg 			EX_En, WR_Sel;
	reg			Int_En;
	reg			WR0_FR_En;
	
	// VDP Reg Outputs
	reg VW_En, VS_Sel;
	reg [4:0] VR_Addr, VS_Addr, VW_Addr;
	reg [4:0] VALU_OP;
	reg [2:0] V_Mode;
	reg MANDA_En;
	reg	VR1_En, VR0_En, VR1OE, VR0OE;
	
	// Counting Variables
	integer 		i;
	integer		j;
	
	// Integer Datapath Flag Register
	reg 			[63:0] Flag_Register;
	assign		FR_Out = Flag_Register;
	
	// Interrupt Enable
	reg			INT_ENABLE;
	
	
   //**************************** 
   //  Internal Data Structures  
   //**************************** 
 
   parameter   // State Assignments 
     INT_CHK    = 0, INTR_1     = 1,  INTR_2     = 2,  INTR_3     = 3, INTR_4     = 4, 
     FETCH      = 5, DECODE     = 6,  ADDs       = 7,  LOAD_imm1  = 8, LOAD_imm2  = 9, 
     LD_imm3   = 10, LD_imm4    = 11, LD_imm5    = 12, STO_1     = 13, STO_2     = 14, 
     STO_3     = 15, SUB 		  = 16, MUL 		 = 17, DIV 		  = 18, AND 		= 19, 
	  OR 			= 20, XOR 		  = 21, JNZ 		 = 22, ASR		  = 23, LD1 		= 24,
	  LD2 		= 25, LD3        = 26, LD4        = 27, COPY      = 28, INC 		= 29,
	  DEC       = 30, JMP_Reg    = 31, JP			 = 32, JC        = 33, LSL			= 34,
	  CMP       = 35, JZ         = 36, JMP_Rel    = 37, CALL_Rel  = 38, RET       = 39,
	  MULI      = 40, NEG        = 41, CALL_Reg   = 42, ADDI      = 43, PUSH      = 44,
	  PUSH2     = 45, PUSH3      = 46, PUSH4      = 47, POP       = 48, POP2      = 49,
	  POP3      = 50, POP4       = 51, POP5       = 52, SUBI      = 53, ASL       = 54,
	  MUL2      = 55, DIV2       = 56, MULI2      = 57, NOT       = 58, DIVI      = 59,
	  DIVI2     = 60, ROR        = 61, ROL        = 62, JLT       = 63, JGE       = 64,
	  STC       = 65, CLC        = 66, CMPI       = 67, JNV       = 68, JV        = 69,
	  JLE       = 70, JGT        = 71, JAE        = 72, JA        = 73, JB        = 74,
	  JBE       = 75, CALL_Rel2  = 76, CALL_Rel3  = 77, CALL_Rel4 = 78, CALL_Rel5 = 79,
	  RET2      = 80, RET3       = 81, RET4       = 82, RET5      = 83, CALL_Reg2 = 84,
	  CALL_Reg3 = 85, CALL_Reg4  = 86, CALL_Reg5  = 87, LOAD_immV = 88, LOAD_immV2 = 89,
	  LOAD_immV3 = 90,LOAD_immV4 = 91, PADD       = 92, PSUB      = 93, PAND      = 94,
	  POR       = 95, PXOR       = 96, DEBUG_STATE = 97,                HALT      = 98,  
	  ILLEGAL_OP= 99, FLDI       = 100, FLDI2     = 101, FLDI3    = 102, FLDI4    = 103,
	  FLD      = 104, FLD2       = 105, FLD3      = 106, FLD4     = 107, FDIV     = 108,
	  FSTO     = 109, FSTO2      = 110, FSTO3     = 111, FADD     = 112, FSUB     = 113,
	  FMUL     = 114, FINC       = 115, FDEC      = 116, FZERO    = 117, FONE     = 118,
	  EXC      = 119, EXC2       = 120, EXC3      = 121, TEST     = 122, LSR      = 123,
	  JNC      = 124, JN         = 125, CMPC      = 126, ANDI     = 127, ORI      = 128,
	  XORI     = 129, INTR_5     = 130, INTR_6    = 131, INTR_7    = 132, INTR_8    = 133,
	  INTR_9    = 134, INTR_10     = 135, INTR_11    = 136, INTR_12   = 137,
	  INTR_RET  = 138, INTR_RET2   = 139, INTR_RET3  = 140, INTR_RET4 = 141,
	  INTR_RET5 = 142, INTR_RET6   = 143, INTR_RET7  = 144, INTR_RET8 = 145,
	  INTR_RET9 = 146, INPUT       = 147, INPUT2     = 148, INPUT3    = 149,
	  INPUT4    = 150, OUTPUT      = 151, OUTPUT2    = 152, OUTPUT3   = 153,
	  SETI      = 154, CLRI        = 155, PADDS     = 156,  PSUBS     = 157,
	  PMULANDADD		= 158,					PMULANDADD2 = 159,
	  PCOMPARE        = 160,					PSTO = 161, PSTO2 = 162, PSTO3 = 163;
 
   reg    [8:0] state;     // Present state register (up to 512 states) 
 
 
   initial  begin 
       int_ack = 0;        // Initialize the interrupt acknowledge output 
		 state = 8'b0;
		 Flag_Register[63:0] = 64'b0;
		 INT_ENABLE = 0;
     end 
	  	  
	  
	  
	 /************************************************ 
    * 440 RISC CONTROL UNIT (Finite State Machine) * 
    ************************************************/ 
	 
	 
   // Flag Register Clock Logic
	always @(posedge sys_clk)
	begin
	
	   // Flag_Register[3:0] <= {v, n, z, c};
		
		case (Flag_C_Sel)
			3'b000 : Flag_Register[0] <= Flag_Register[0];
			3'b001 : Flag_Register[0] <= c;
			3'b010 : Flag_Register[0] <= 1'b0;
			3'b011 : Flag_Register[0] <= 1'b1;
			3'b100 : Flag_Register[0] <= ~Flag_Register[0];
		endcase
		
		case (Flag_Z_Sel)
			3'b000 : Flag_Register[1] <= Flag_Register[1];
			3'b001 : Flag_Register[1] <= z;
			3'b010 : Flag_Register[1] <= 1'b0;
			3'b011 : Flag_Register[1] <= 1'b1;
			3'b100 : Flag_Register[1] <= ~Flag_Register[1];
		endcase
		
		case (Flag_N_Sel)
			3'b000 : Flag_Register[2] <= Flag_Register[2];
			3'b001 : Flag_Register[2] <= n;
			3'b010 : Flag_Register[2] <= 1'b0;
			3'b011 : Flag_Register[2] <= 1'b1;
			3'b100 : Flag_Register[2] <= ~Flag_Register[2];
		endcase
		
		case (Flag_V_Sel)
			3'b000 : Flag_Register[3] <= Flag_Register[3];
			3'b001 : Flag_Register[3] <= v;
			3'b010 : Flag_Register[3] <= 1'b0;
			3'b011 : Flag_Register[3] <= 1'b1;
			3'b100 : Flag_Register[3] <= ~Flag_Register[3];
		endcase
		
		if ({Flag_V_Sel, Flag_N_Sel, Flag_Z_Sel, Flag_C_Sel} == 12'b111_111_111_111)
			Flag_Register <= {RdBuf1Wire, RdBuf0Wire};
	end 
		
 
   always @(posedge sys_clk) 	
	  // --------------------------- Reset ------------------------------
     if (reset) // PC = 64'h0
     begin  
	  
	  @ (negedge sys_clk)
	  begin
         state = INT_CHK; 
			// FDP
			{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
		
			// IDP
			{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec}  
			  = 30'b0_00_1_00000_00000_00000_00000_0_1_0_0_00;
			  
			// VDP 
		   {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
			 = 26'b0_0_00000_00000_00000_00000_000_0;

		
			// BIU
			{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
			  IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En,
				VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000000000000000000000000;
			  
			
		
			// Mem
			{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
			
			// IO
			{IO_CS_, IO_RD_, IO_WR_} = 3'b111;
			
			Jump_En = 1'b0;
			Jump_Reg = 1'b0;
			
			// Exchange Control -- Special
			EX_En = 1'b0;
			WR_Sel = 1'b0;
			
		end
		
			
      end 
	
	  // --------------------------- INT_CHK ----------------------------
	  else 
       case (state) 
 
          INT_CHK: // if (int_ack = 1 & intr = 0)
						 // MAR <-- PC
          if (!intr)   
          begin 
			 if (int_ack) 
					int_ack=1'b0; 
			  
			 @ (negedge sys_clk)
			 begin
			 //$display(" ");
			 //$display("We're in INT_CHK!!");
			 //$display(" ");
					
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_01111_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					= 26'b0_0_00000_00000_00000_00000_000_0;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En,
						VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000000000000010000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				// IO
				{IO_CS_, IO_RD_, IO_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				// Exchange Control -- Special
				EX_En = 1'b0;
				WR_Sel = 1'b0;
					
            state = FETCH; 
			 end	
				
          end 
          
			 else 
          begin 
				if (INT_ENABLE)
				begin
				@ (negedge sys_clk)
				begin
				$display(" ");
				$display("ENTERING INTERRUPT!!");
			   $display("============================================================");
				$display("TIME = %t, PC = %h, FLAGS = {C, Z, N, V} = {%h, %h, %h, %h}", $time, 
					TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.PC, Flag_Register[0],
					Flag_Register[1], Flag_Register[2], Flag_Register[3]);
				$display("============================================================");
				// Default control word assignments   
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En, VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000000000000000000000000;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					= 26'b0_0_00000_00000_00000_00000_000_0;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				// Exchange Control -- Special
				EX_En = 1'b0;
				WR_Sel = 1'b0;
				
				state = INTR_1;
				
				end
				
				end
			
			 else
			 begin
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_01111_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					= 26'b0_0_00000_00000_00000_00000_000_0;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En,
					VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000000000000010000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				// IO
				{IO_CS_, IO_RD_, IO_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				// Exchange Control -- Special
				EX_En = 1'b0;
				WR_Sel = 1'b0;
					
            state = FETCH; 
				
				end
			end
			end
			 
			 // --------------------------- INTR_1 ----------------------------
          INTR_1: // MAR <-- 64'h3FE  // SP <-- SP - 4	<--
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1, MAR + 1
												  // WrBuf1:WrBuf0 <-- Flag_Register
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  
												  // MAR <-- 64'h3FE
												  // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
												  // RdBuf1 <-- M[MAR],
												  // PC <-- RdBuf1:RdBuf0, int_ack = 1
          begin 
				@ (negedge sys_clk)
			//	$display(" ");
			//	$display("We're in INTR!");
			//	$display(" ");
				begin	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_01;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En} = 20'b00000000000000000000;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
					
				// TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.MAR = 64'h3FE;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
					
            state   = INTR_2;  
				
				end
         
			end

			// --------------------------- INTR_2 ----------------------------
          INTR_2: // MAR <-- 64'h3FE  // SP <-- SP - 4	<--
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1, MAR + 1
												  // WrBuf1:WrBuf0 <-- Flag_Register
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  
												  // MAR <-- 64'h3FE
												  // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
												  // RdBuf1 <-- M[MAR],
												  // PC <-- RdBuf1:RdBuf0, int_ack = 1
          begin 
				@ (negedge sys_clk)
				
				begin	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_01;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En} = 20'b00000000000000000000;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
								
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
					
            state   = INTR_3;  
				
				end
         
			end 	

			// --------------------------- INTR_3 ----------------------------
          INTR_3: // MAR <-- 64'h3FE  // SP <-- SP - 4
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP	<--
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1, MAR + 1
												  // WrBuf1:WrBuf0 <-- Flag_Register
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  
												  // MAR <-- 64'h3FE
												  // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
												  // RdBuf1 <-- M[MAR],
												  // PC <-- RdBuf1:RdBuf0, int_ack = 1
          begin 
				@ (negedge sys_clk)
				
				begin	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En} = 20'b00000011000000111000;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
								
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
					
            state   = INTR_4;  
				
				end
         
			end 

			// --------------------------- INTR_4 ----------------------------
          INTR_4: // MAR <-- 64'h3FE  // SP <-- SP - 4
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1	<--
												  // M[MAR] <-- WrBuf1, MAR + 1
												  // WrBuf1:WrBuf0 <-- Flag_Register
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  
												  // MAR <-- 64'h3FE
												  // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
												  // RdBuf1 <-- M[MAR],
												  // PC <-- RdBuf1:RdBuf0, int_ack = 1
          begin 
				@ (negedge sys_clk)
				
				begin	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En} = 20'b00000100000010000000;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;
								
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
			//	$display(" ");
			//	$display("WrBuf0 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.WRBuf_0);
			//	$display("WrBuf1 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.WRBuf_1);
			//	$display(" ");
					
            state   = INTR_5;  
				
				end
         
			end 	
			 
			 // --------------------------- INTR_5 ----------------------------
          INTR_5: // MAR <-- 64'h3FE  // SP <-- SP - 4
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1, MAR + 1	<--
												  // WrBuf1:WrBuf0 <-- Flag_Register
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  
												  // MAR <-- 64'h3FE
												  // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
												  // RdBuf1 <-- M[MAR],
												  // PC <-- RdBuf1:RdBuf0, int_ack = 1
          begin 
				@ (negedge sys_clk)
				
				begin	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En} = 20'b00000100000100000000;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;
								
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
					
            state   = INTR_6;  
				
				end
         
			end 	
			
			// --------------------------- INTR_6 ----------------------------
          INTR_6: // MAR <-- 64'h3FE  // SP <-- SP - 4
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1, MAR + 1
												  // WrBuf1:WrBuf0 <-- Flag_Register	<--
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  
												  // MAR <-- 64'h3FE
												  // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
												  // RdBuf1 <-- M[MAR],
												  // PC <-- RdBuf1:RdBuf0, int_ack = 1
          begin 
				@ (negedge sys_clk)
				
				begin	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En} = 20'b0000000000000000001;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
								
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
		//		$display(" ");
		//		$display("Mem[3F9h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F9]);
		//		$display("Mem[3F8h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F8]);
		//		$display("Mem[3F7h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F7]);
		//		$display("Mem[3F6h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F6]);
		//		$display("Mem[3F5h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F5]);
		//		$display("Mem[3F4h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F4]);
		//		$display("Mem[3F3h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F3]);
		//		$display(" ");
				
		//		$display("Flag Register = %h", Flag_Register);
		//		$display("FR_Out = %h", FR_Out);
		//		$display("MAR = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.MAR);
				
					
            state   = INTR_7;  
				
				
				
				end
         
			end 
			
			// --------------------------- INTR_7 ----------------------------
          INTR_7: // MAR <-- 64'h3FE  // SP <-- SP - 4
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1, MAR + 1
												  // WrBuf1:WrBuf0 <-- Flag_Register	
												  // M[MAR] <-- WrBuf0, MAR + 1		<--
												  // M[MAR] <-- WrBuf1
												  
												  // MAR <-- 64'h3FE
												  // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
												  // RdBuf1 <-- M[MAR],
												  // PC <-- RdBuf1:RdBuf0, int_ack = 1
          begin 
				@ (negedge sys_clk)
				
				begin	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En} = 20'b00000100000010000000;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;
								
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				
		//		$display(" ");
		//		$display("WrBuf0 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.WRBuf_0);
		//		$display("WrBuf1 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.WRBuf_1);
		//		$display("WR0OE = %h", WR0OE);
		//		$display("MAR = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.MAR);
		//		$display(" "); 
					
            state   = INTR_8;  
				
				end
         
			end 
			
			// --------------------------- INTR_8 ----------------------------
          INTR_8: // MAR <-- 64'h3FE  // SP <-- SP - 4
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1, MAR + 1
												  // WrBuf1:WrBuf0 <-- Flag_Register	
												  // M[MAR] <-- WrBuf0, MAR + 1		
												  // M[MAR] <-- WrBuf1 <--
												  
												  // MAR <-- 64'h3FE
												  // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
												  // RdBuf1 <-- M[MAR],
												  // PC <-- RdBuf1:RdBuf0, int_ack = 1
          begin 
				@ (negedge sys_clk)
				
				begin	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En} = 20'b00000000000100000000;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;
								
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
					
            state   = INTR_9;  
				
				end
         
			end 
			 
			 // --------------------------- INTR_9 ----------------------------
          INTR_9: // MAR <-- 64'h3FE  // SP <-- SP - 4
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1, MAR + 1
												  // WrBuf1:WrBuf0 <-- Flag_Register
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  
												  // MAR <-- 64'h3FE
												  // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
												  // RdBuf1 <-- M[MAR],
												  // PC <-- RdBuf1:RdBuf0, int_ack = 1
          begin 
				@ (negedge sys_clk)
				
				begin	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En} = 19'b0000000000000000001;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
					
				// TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.MAR = 64'h3FE;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
		//		$display(" ");
		//		$display("Mem[3F9h]=%h",TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F9]);
		//		$display("Mem[3F8h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F8]);
		//		$display("Mem[3F7h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F7]);
		//		$display("Mem[3F6h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F6]);
		//		$display("Mem[3F5h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F5]);
		//		$display("Mem[3F4h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F4]);
		//		$display("Mem[3F3h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F3]);
		//		$display(" ");
					
            state   = INTR_10;  
				
				end
         
			end 
			
			// --------------------------- INTR_10 ----------------------------
         INTR_10: // RdBuf0 <-- M[MAR]
					  // MAR <-- MAR + 1
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
					
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
			   // VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En} = 19'b0001010000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
		//		$display("Contents of MAR = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.MAR);
				
				state = INTR_11; 
				end
            
			end 
			
			// --------------------------- INTR_11 ----------------------------
         INTR_11: // RdBuf1 <-- M[MAR]
         begin
			@ (negedge sys_clk)
			begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0__000000_00000_00000_00000_000;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	   


				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INTR_12;                
           end 
			end 
			
			// --------------------------- INTR_12 ----------------------------
         INTR_12: // PC <-- RdBuf1:RdBuf0
					  // int_ack = 1;
         begin 
             @ (negedge sys_clk)
				 begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_1_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
					
				// Interrupt Acknowledge
				int_ack = 1'b1;
				
		//		$display("Contents of RdBuf0", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.RdBuf_0);
		//		$display("Contents of RdBuf1", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.RdBuf_1);
					
				state = INT_CHK;                
            end
			end 
			
			
			// --------------------------- FETCH ----------------------------
         FETCH: // IR <-- M[MAR]
					 // PC <-- PC + 1
         begin 
            @ (negedge sys_clk)
				begin
			   //$display(" ");
			   //$display("We're in FETCH!");
			   //$display(" ");
				// FDP		
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;			 
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
				= 30'b0_00_1_00000_00000_00000_00000_1_0_0_0_00;
				
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000001000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				//$display("MAR in fetch = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.MAR);
					
				state = DECODE; 
				end	
				
         end 
			
			// --------------------------- DECODE ---------------------------
         DECODE: // $display IR
         begin 
            @ (negedge sys_clk)
				begin
				//$display(" ");
				//$display("We're in DECODE!!");
				//$display("PC = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.PC);
				//$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				// Display contents of IR	
				#1 //$display("DECODE with time = %t, and IR = %h", $time, 
						//			IR_Wire);
				//$display("MAR = %h", TB.Robonaut_Architecture.Core_Architecture.topmodule.CPU_EU.biu.MAR);
				
					
            case (IR_Wire[31:24]) 
						8'h00 :  state = LOAD_immV;
						8'h01 :  state = PADD;
						8'h02 :  state = PSUB;
						8'h03 :  state = PAND;
						8'h04 :  state = POR;
						8'h05 :  state = PXOR;
						8'h06 :  state = PADDS;
						8'h07 :  state = PSUBS;
						8'h08 :  state = PMULANDADD;
						8'h09 :  state = PCOMPARE;
						8'h0A :  state = PSTO;
                  8'h80 :  state = ADDs; 
						8'h81 :  state = SUB;
						8'h82 :  state = MUL;
						8'h83 :  state = DIV;
						8'h84 :  state = AND;
						8'h85 :  state = OR;
						8'h86 :  state = XOR;
                  8'h87 :  state = LOAD_imm1; 
						8'h88 :  state = LD1;
                  8'h89 :  state = STO_1;
						8'h8A :  state = COPY;
						8'h8B :  state = EXC;
						8'h8C :  state = INPUT;
						8'h8D :  state = OUTPUT;
						8'h8E :  state = CMP;
						8'h8F :  state = TEST;
						8'h90 :  state = PUSH;
						8'h91 :  state = POP;
						8'h92 :  state = NEG;
						8'h93 :  state = NOT;
						8'h94 :  state = INC;
						8'h95 :  state = DEC;
						8'h98 :  state = LSR;
						8'h99 :  state = LSL;
						8'h9A :  state = ASR;
						8'h9B :  state = ASL;
						8'h9C :  state = ROR;
						8'h9D :  state = ROL;
						8'hA0 :  state = JC;
						8'hA1 :  state = JNC;
						8'hA2 :  state = JZ;
						8'hA3 :	state = JNZ;
						8'hA4 :  state = JN;
						8'hA5 :  state = JP;
						8'hA6 :  state = JV;
						8'hA7 :  state = JNV;
						8'hA8 :  state = JLT;
						8'hA9 :  state = JGE;
						8'hAA :  state = JGT;
						8'hAB :  state = JLE;
						8'hAC :  state = JB;
						8'hAD :  state = JAE;
						8'hAE :  state = JA;
						8'hAF :  state = JBE;
						8'hB0 :  state = JMP_Rel;
						8'hB1 :  state = JMP_Reg;
						8'hB2 :  state = CALL_Rel;
						8'hB3 :  state = CALL_Reg;
						8'hB4 :  state = RET;
						8'hB5 :  state = INTR_RET;
						8'hC0 :  state = CLC;
						8'hC1 :  state = STC;
						8'hC2 :  state = CMPC;
						8'hC3 :  state = CLRI;
						8'hC4 :  state = SETI;
                  8'hC5 :  state = HALT; 
						8'hD0 :  state = ADDI;
						8'hD1 :  state = SUBI;
						8'hD2 :  state = MULI;
						8'hD3 :  state = DIVI;
						8'hD8 :  state = ANDI;
						8'hD9 :  state = ORI;
						8'hDA :  state = XORI;
						8'hDB :  state = CMPI;
						8'hE0 :  state = FADD;
						8'hE1 :  state = FSUB;
						8'hE2 :  state = FMUL;
						8'hE3 :  state = FDIV;
						8'hE4 :  state = FINC;
						8'hE5 :  state = FDEC;
						8'hE6 :  state = FZERO;
						8'hE7 :  state = FONE;
						8'hE8 :  state = FLDI;
						8'hE9 :  state = FLD;
						8'hEA :  state = FSTO;
                  default: state = ILLEGAL_OP; 
            endcase        
				end
         end 
			
			// ------------------------ LOAD_immV --------------------------
         LOAD_immV: // MAR <-- PC
         begin 
             @ (negedge sys_clk)
				 begin
	//			 $display(" ");
	//			 $display("We're in LDIV!!");
	//			 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000010000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;			

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
					
				state = LOAD_immV2;        
				end
         end 
			
			// ------------------------ LOAD_immV2 --------------------------
         LOAD_immV2: // RdBuf0 <-- M[MAR]
						  // PC <-- PC + 1
						  // MAR <-- MAR + 1
         begin 
				@ (negedge sys_clk)
				begin 
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP				
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_1_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = LOAD_immV3;
				end
				
         end 
			
			// ------------------------ LOAD_immV3 --------------------------
			LOAD_immV3: // RdBuf1 <-- M[MAR]
						    // PC <-- PC + 1
         begin 
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP			
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_1_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 25'b0_0_00000_00000_00000_00000_000;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
			
				state = LOAD_immV4;                
				end
         end 
			
			// ------------------------ LOAD_immV4 --------------------------
         LOAD_immV4: // V[R[d]] <-- RdBuf1:RdBuf0
         begin 
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP				
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {14'b0_00_0_00000_00000, 5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= {1'b1, 1'b1, 5'b00000, 5'b00000, IR_Wire[4:0], 5'b00001, 3'b000};
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
	//			$display("RdBuf1 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.RdBuf_1);
	//			$display("RdBUf0 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.RdBuf_0);
	//			$display("DS Wire in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.DS);
	//			$display("ALU_Out in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.ALU_Out);
				
				state = INT_CHK;                
				end
         end 
			
			// ------------------------ PSTO ------------------------------
         PSTO: // MAR <-- R[d]
					 // WrBuf1:WrBuf0 <-- VR[s1]
         begin 
            @ (negedge sys_clk)
				begin
	//			#1 $display(" ");
	//			#1 $display("We're in PSTO!");
	//			#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b0, 1'b0, 5'b00000, 5'b00000, 5'b00000, 4'b0000, 4'b0000};
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[4:0], 
						5'b00000, 5'b00000,
						5'b10010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = {1'b0, 1'b0, 5'b00000, IR_Wire[20:16], 5'b00000, 5'b01011, IR_Wire[7:5]};
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En,
					WR0_FR_En, VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000010000000000000001100;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = PSTO2;                
				end
			end 
			
			// ------------------------- PSTO2 ----------------------------
         PSTO2: // M[MAR] <-- WrBuf0
					 // MAR <-- MAR + 1
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En,
					WR0_FR_En, VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000001000000000000000001;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;	
            
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
	//			$display("VRBuf_0 in BIU = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.VRBuf_0);
	//			$display("VRBuf_1 in BIU = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.VRBuf_1);
				
				state = PSTO3;                
				end
         end 
			
			// ------------------------- PSTO3 ----------------------------
         PSTO3: // M[MAR] <-- WrBuf1 
         begin
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En,
					WR0_FR_En, VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000000000000000000000010;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
              
				state = INT_CHK;                
				end
		   end
			
			
			// --------------------------- PADD ----------------------------	 
			PADD: // R[d] <-- R[s1] + R[s2]
         begin 
            @ (negedge sys_clk)
				begin
		//		$display(" ");
		//		$display("We're in PADD!!");
		//		$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= {1'b1, 1'b0, IR_Wire[20:16], IR_Wire[12:8], IR_Wire[4:0], 5'b00000, IR_Wire[7:5]};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
		//		$display("ALU_Out in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.ALU_Out);
				
				state = INT_CHK;  
				end
         end

			// --------------------------- PSUB ----------------------------	 
			PSUB: // R[d] <-- R[s1] - R[s2]
         begin 
            @ (negedge sys_clk)
				begin
	//			$display(" ");
	//			$display("We're in PSUB!!");
	//			$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= {1'b1, 1'b0, IR_Wire[20:16], IR_Wire[12:8], IR_Wire[4:0], 5'b00010, IR_Wire[7:5]};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
		//		$display("ALU_Out in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.ALU_Out);
				
				state = INT_CHK;  
				end
         end 	
			
			// --------------------------- PMULANDADD ----------------------------	 
			PMULANDADD: // MANDA_REG[127:0] <== R * S
         begin 
            @ (negedge sys_clk)
				begin
		//		$display(" ");
		//		$display("We're in PMULANDADD!!");
		//		$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					= {1'b0, 1'b0, IR_Wire[20:16], IR_Wire[12:8], 5'b00000, 5'b01000, IR_Wire[7:5], 1'b1};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				// $display("ALU_Out in Vector Datapath = %h", CU_TB.Robonaut_Architecture.topmodule.CPU_EU.VectorDP.ALU_Out);
			//	$display("R in PMULLANDADD1 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.VectorALU16_3.R);
			//	$display("S in PMULANDADD1 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.VectorALU16_3.S);
			//	$display("PMULLANDADD1 Product_Register of VectorALU16_3 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.VectorALU16_3.Product_Register);
				state = PMULANDADD2;  
				end
         end 
			
			// --------------------------- PMULANDADD2 ---------------------------
			PMULANDADD2: // R[d] + 1 <== MSW of Multiplication
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					= {1'b1, 1'b0, 5'b00000, 5'b00000, IR_Wire[4:0], 5'b01010, IR_Wire[7:5], 1'b0};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;   // Marked as flags do not change
				
		//		$display("TEMP_REG in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.VectorRegFile.mandareg);
		//		$display("PMULANDADD2 Product_Register of VectorALU8_7 = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.VectorALU7.Product_Register);
				state = INT_CHK;  
				end
         end 
			
			

			// --------------------------- PAND ----------------------------	 
			PAND: // R[d] <-- R[s1] & R[s2]
         begin 
            @ (negedge sys_clk)
				begin
			//	$display(" ");
			//	$display("We're in PAND!!");
			//	$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= {1'b1, 1'b0, IR_Wire[20:16], IR_Wire[12:8], IR_Wire[4:0], 5'b00011, IR_Wire[7:5]};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				//$display("ALU_Out in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.ALU_Out);
				
				state = INT_CHK;  
				end
         end 
			
			// --------------------------- PCOMPARE ----------------------------	 
			PCOMPARE: // R[d] <-- R[s1] & R[s2]
         begin 
            @ (negedge sys_clk)
				begin
	//			$display(" ");
	//			$display("We're in PCOMPARE!!");
	//			$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= {1'b1, 1'b0, IR_Wire[20:16], IR_Wire[12:8], IR_Wire[4:0], 5'b01010, IR_Wire[7:5]};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				//$display("ALU_Out in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.ALU_Out);
				
				state = INT_CHK;  
				end
         end 

		// --------------------------- POR ----------------------------	 
			POR: // R[d] <-- R[s1] | R[s2]
         begin 
            @ (negedge sys_clk)
				begin
		//		$display(" ");
		//		$display("We're in POR!!");
		//		$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= {1'b1, 1'b0, IR_Wire[20:16], IR_Wire[12:8], IR_Wire[4:0], 5'b00100, IR_Wire[7:5]};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				//$display("ALU_Out in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.ALU_Out);
				
				state = INT_CHK;  
				end
         end 		

			// --------------------------- PXOR ----------------------------	 
			PXOR: // R[d] <-- R[s1] ^ R[s2]
         begin 
            @ (negedge sys_clk)
				begin
		//		$display(" ");
		//		$display("We're in PXOR!!");
		//		$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= {1'b1, 1'b0, IR_Wire[20:16], IR_Wire[12:8], IR_Wire[4:0], 5'b00101, IR_Wire[7:5]};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				//$display("ALU_Out in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.ALU_Out);
				
				state = INT_CHK;  
				end
         end 					
			
			// --------------------------- PADDS ----------------------------	 
			PADDS: // R[d] <-- R[s1] + R[s2]
         begin 
            @ (negedge sys_clk)
				begin
		//		$display(" ");
		//		$display("We're in PADDS!!");
		//		$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= {1'b1, 1'b0, IR_Wire[20:16], IR_Wire[12:8], IR_Wire[4:0], 5'b00110, IR_Wire[7:5]};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				//$display("ALU_Out in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.ALU_Out);
				
				state = INT_CHK;  
				end
         end
			
			// --------------------------- PSUBS ----------------------------	 
			PSUBS: // R[d] <-- R[s1] - R[s2]
         begin 
            @ (negedge sys_clk)
				begin
		//		$display(" ");
		//		$display("We're in PSUBS!!");
		//		$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= {1'b1, 1'b0, IR_Wire[20:16], IR_Wire[12:8], IR_Wire[4:0], 5'b00111, IR_Wire[7:5]};
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				//$display("ALU_Out in Vector Datapath = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.ALU_Out);
				
				state = INT_CHK;  
				end
         end
          
			// --------------------------- ADDs ----------------------------	 
			ADDs: // R[d] <-- R[s1] + R[s2]
         begin 
            @ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in ADD!!");
		//		#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, IR_Wire[20:16], 
						IR_Wire[12:8],
						IR_Wire[4:0], 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;  
				end
         end 
			
			// --------------------------- SUB ----------------------------	 
			SUB: // R[d] <-- R[s1] - R[s2]
         begin 
            @ (negedge sys_clk)
				begin
				
				//#1 $display(" ");
				//#1 $display("We're in SUB!!");
				//#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, IR_Wire[20:16], 
						IR_Wire[12:8],
						IR_Wire[4:0], 
						5'b00001, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
			//	#1 $display("V Flag in ALU = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.alu.V);
			//	#1 $display("R in ALU = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.alu.R);
			//	#1 $display("S in ALU = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.alu.S);
			//	#1 $display("Y in ALU = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.alu.Y);
			//	#1 $display(" ");
				
				state = INT_CHK;  
				end
         end 
			
			// --------------------------- MUL ----------------------------	 
			MUL: // R[d] <-- R[s1] * R[s2]
         begin 
            @ (negedge sys_clk)
				begin
	//			#1 $display(" ");
	//			#1 $display("We're in MUL!!");
	//			#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, IR_Wire[20:16], 
						IR_Wire[12:8],
						IR_Wire[4:0], 
						5'b00010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = MUL2;  
				end
         end 
			
			// --------------------------- MUL2 ---------------------------
			MUL2: // R[d] + 1 <== MSW of Multiplication
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						5'b00000,
						IR_Wire[4:0] + 1'b1, 
						5'b00011, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;   // Marked as flags do not change
				
				state = INT_CHK;  
				end
         end 
			
			
			// --------------------------- DIV ----------------------------	 
			DIV: // R[d] <-- R[s1] / R[s2]
         begin 
            @ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in DIV!!");
		//		#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, IR_Wire[20:16], 
						IR_Wire[12:8],
						IR_Wire[4:0], 
						5'b00100, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = DIV2;  
				end
         end 
			
			// --------------------------- DIV2 ---------------------------
			DIV2: // R[d] + 1 <== MSW of DIV
         begin 
            @ (negedge sys_clk)
				begin
	
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						5'b00000,
						IR_Wire[4:0] + 1'b1, 
						5'b00101, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INT_CHK;  
				end
         end 
			
			// --------------------------- AND ----------------------------	 
			AND: // R[d] <-- R[s1] and R[s2]
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, IR_Wire[20:16], 
						IR_Wire[12:8],
						IR_Wire[4:0], 
						5'b01000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;  
				end
         end 
			
			// --------------------------- OR ----------------------------	 
			OR: // R[d] <-- R[s1] and R[s2]
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, IR_Wire[20:16], 
						IR_Wire[12:8],
						IR_Wire[4:0], 
						5'b01001, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;  
				end
         end 

			// --------------------------- XOR ----------------------------	 
			XOR: // R[d] <-- R[s1] xor R[s2]
         begin 
            @ (negedge sys_clk)
				begin
	//			#1 $display(" ");
	//			#1 $display("We're in XOR!!");
	//			#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, IR_Wire[20:16], 
						IR_Wire[12:8],
						IR_Wire[4:0], 
						5'b01010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;  
				end
         end 
			
			// -------------------------- ASR ------------------------------
			ASR: // R[d] <-- ASR R[s]
			
			begin
				  @ (negedge sys_clk)
				  begin
				  // FDP
					{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16],
						IR_Wire[4:0], 
						5'b10011, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				  // VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
						= 24'b0_0_00000_00000_00000_00000_00;
								
				 // BIU
				 {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				 // Mem
				 {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				 Jump_En = 1'b0;
				 Jump_Reg = 1'b0;
				 
				 // Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				 state = INT_CHK;  
				 end
         end 
			
			// -------------------------- ASL ------------------------------
			ASL: // R[d] <-- ASL R[s]
			
			begin
				  @ (negedge sys_clk)
				  begin
				 // #1 $display(" ");
				 // #1 $display("We're in ASL!!");
				 // #1 $display(" ");
				  // FDP
					{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16],
						IR_Wire[4:0], 
						5'b10101, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				  // VDP 
				 {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				 // BIU
				 {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				 // Mem
				 {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				 Jump_En = 1'b0;
				 Jump_Reg = 1'b0;
				 
				 // Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				 state = INT_CHK;  
				 end
         end 
			
			// -------------------------- ROR ------------------------------
			ROR: 
			begin
				  @ (negedge sys_clk)
				  begin
				  //#1 $display(" ");
				  //#1 $display("We're in ROR!!! (rawr)!");
				  //#1 $display(" ");
				  // FDP
					{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16],
						IR_Wire[4:0], 
						5'b10111, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				 // VDP 
				 {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				 // BIU
				 {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				 // Mem
				 {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				 Jump_En = 1'b0;
				 Jump_Reg = 1'b0;
				 
				 // Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				 state = INT_CHK;  
				 end
         end 
			
			// -------------------------- ROL ------------------------------
			ROL: 
			begin
				  @ (negedge sys_clk)
				  begin
				 // #1 $display(" ");
				 // #1 $display("We're in ROL!!! (barrel roll)!");
				 // #1 $display(" ");
				  // FDP
					{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16],
						IR_Wire[4:0], 
						5'b11000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				  // VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
								
				 // BIU
				 {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				 // Mem
				 {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				 Jump_En = 1'b0;
				 Jump_Reg = 1'b0;
				 
				 // Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				 state = INT_CHK;  
				 end
         end 
				  
			// -------------------------- JC ------------------------------
			JC: // if (C == 1)
				  // PC <-- {40'bIR[23], IR[23:0]}
			begin	  
				  @ (negedge sys_clk)
				  begin
				 // #1 $display(" ");
				 // #1 $display("We're in JC!!!");
				 // #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  if (Flag_Register[0] == 1'b1)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end	

			// -------------------------- JNC ------------------------------
			JNC: // if (C == 0)
				  // PC <-- {40'bIR[23], IR[23:0]}
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in JNC!!!");
				//  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  if (Flag_Register[0] == 1'b0)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;;
						
				  end
			end				
			
			// -------------------------- JZ ------------------------------
			JZ: // if (Z == 1)
				  // PC <-- {40'bIR[23], IR[23:0]}
			begin	  
				  @ (negedge sys_clk)
				  begin
		//		  #1 $display(" ");
		//		  #1 $display("We're in JZ!");
		//		  #1 $display(" ");
				  // FDP
				 {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  if (Flag_Register[1] == 1'b1)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// -------------------------- JNZ ------------------------------
			JNZ: // if (Z == 0)
				  // PC <-- {40'bIR[23], IR[23:0]}
			begin	  
				  @ (negedge sys_clk)
				  begin
			//	  #1 $display(" ");
			//	  #1 $display("We're in JNZ!!");
			//	  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  if (Flag_Register[1] == 1'b0)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JN ---------------------------------
			JN: // if (N == 1 && Z == 1)
				 // PC <-- {40'bIR[23], IR[23:0]}
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in JN!");
				//  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  if (Flag_Register[2:1] == 2'b11)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;;
						
				  end
			end
			
			// ------------------------ JP ---------------------------------
			JP: // if (N == 0 && Z == 0)
				 // PC <-- {40'bIR[23], IR[23:0]}
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in JP!");
				//  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  if (Flag_Register[2:1] == 2'b00)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------- JV ---------------------------------
			JV:
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  //#1 $display(" ");
				  //#1 $display("We're in JV!!");
				  //#1 $display(" ");
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  if (Flag_Register[3] == 1'b1)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JNV ---------------------------------
			JNV:
			begin	  
				  @ (negedge sys_clk)
				  begin
				  //#1 $display(" ");
				  //#1 $display("We're in JNV!! (Junior Varsity)");
				  //#1 $display(" ");
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  if (Flag_Register[3] == 1'b0)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JLT ---------------------------------
			JLT:
			begin	  
				  @ (negedge sys_clk)
				  begin
				 // #1 $display(" ");
				 // #1 $display("We're in JLT!!");
				 // #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation // N = Flag_Register[2], V = Flag_Register[3] SF <> OF
				  if (Flag_Register[2] > Flag_Register[3] || Flag_Register[2] < Flag_Register[3])
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JGE ---------------------------------
			JGE:
			begin	  
				  @ (negedge sys_clk)
				  begin
				  //#1 $display(" ");
				  //#1 $display("We're in JGE!! (Jiggy)");
				  //#1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation // N = Flag_Register[2], V = Flag_Register[3] SF = OF
				  if (Flag_Register[2] == Flag_Register[3])
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JGT --------------------------------
			JGT:
				begin	  
				  @ (negedge sys_clk)
				  begin
				  //#1 $display(" ");
				  //#1 $display("We're in JGT!! (Jammin Guitar Threads)");
				  //#1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation // ZF = 0 and SF = OF  // Z = Flag_Register[1], N = Flag_Register[2], V = Flag_Register[3]
				  if (Flag_Register[1] == 0 && Flag_Register[2] == Flag_Register[3])
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JLE --------------------------------
			JLE:
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in JLE!! (Jet Lag Everyday)");
				//  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation // ZF == 1 or SF <> OF // Z = Flag_Register[1] N = Flag_Register[2] V = Flag_Register[3]
				  if (Flag_Register[1] == 1'b1 || Flag_Register[2] > Flag_Register[3] || Flag_Register[2] < Flag_Register[3])
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JB ---------------------------------
			JB:
			begin	  
				  @ (negedge sys_clk)
				  begin
				 // #1 $display(" ");
				 // #1 $display("We're in JB!! (Jalopy Bayou)");
				 // #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation // CF == 1
				  if (Flag_Register[0] == 1'b1)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JAE --------------------------------
			JAE:
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in JAE!! (Jagged Area Edges)");
				//  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation // CF == 0
				  if (Flag_Register[0] == 1'b0)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JA ---------------------------------
			JA:
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in JA!! (Juniper Aurora)");
				//  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation // CF == 0 && ZF == 0
				  if (Flag_Register[0] == 1'b0 && Flag_Register[1] == 1'b0)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JBE --------------------------------
			JBE:
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in JBE!! (January Bad Eggs)");
				//  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation // CF == 1 || ZF == 1
				  if (Flag_Register[0] == 1'b1 || Flag_Register[1] == 1'b1)
						Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JMP_Rel ----------------------------
			JMP_Rel: // PC <-- DS
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in JMP_Rel!");
				 // #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  
				  Jump_En = 1'b1;
						
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ JMP_Reg ----------------------------
			JMP_Reg: // PC <-- R[R[IR[20:16]]]
				begin	  
				  @ (negedge sys_clk)
				  begin
				  
				//  #1 $display(" ");
				//  #1 $display("We're in JMP_Reg");
				//  #1 $display(" ");
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[20:16], 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				  // VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  Jump_En = 1'b0;
				  
				  Jump_Reg = 1'b1;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ CALL_Rel ---------------------------
			CALL_Rel: // PC <-- DS + PC  // SP <-- SP - 2
						                    // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  // PC <-- PC + DS
			begin	  
				  @ (negedge sys_clk)
				  begin
			//	  #1 $display(" ");
			//	  #1 $display("We're in CALL_Rel!");
			//	  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_01;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = CALL_Rel2;
						
				  end
			end 

			// ------------------------ CALL_Rel2 ---------------------------
			CALL_Rel2: // PC <-- DS + PC // SP <-- SP - 2
						 // RA <-- PC       // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  // PC <-- PC + DS
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				 {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000110000001110;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = CALL_Rel3;
						
				  end
			end 
			
			// ------------------------ CALL_Rel3 ---------------------------
			CALL_Rel3: // PC <-- DS + PC // SP <-- SP - 2
						 // RA <-- PC       // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  // PC <-- PC + DS
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000001000000100000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = CALL_Rel4;
						
				  end
			end 
			
			// ------------------------ CALL_Rel4 ---------------------------
			CALL_Rel4: // PC <-- DS + PC // SP <-- SP - 2
						 // RA <-- PC       // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  // PC <-- PC + DS
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000001000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = CALL_Rel5;
						
				  end
			end 
			
			// ------------------------ CALL_Rel5 ---------------------------
			CALL_Rel5: // PC <-- DS + PC // SP <-- SP - 2
						 // RA <-- PC       // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
												  // M[MAR] <-- WrBuf0, MAR + 1
												  // M[MAR] <-- WrBuf1
												  // PC <-- PC + DS
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b1;	
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end 

			// ------------------------ CALL_Reg ----------------------------
			CALL_Reg: // SP <-- SP - 2
						 // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
			          // M[MAR] <-- WrBuf0, MAR + 1
					    // M[MAR] <-- WrBuf1
						 // PC <-- REG_OUT IR_Wire[4:0]
			begin	  
			  @ (negedge sys_clk)
			  begin
		//	  #1 $display(" ");
		//	  #1 $display("We're in CALL_Reg");
		//	  #1 $display(" ");
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01};
						
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  Jump_En = 1'b0;
				  
				  Jump_Reg = 1'b0;
						
				  state = CALL_Reg2;
						
				  end
			end
			
			// ------------------------ CALL_Reg2 ----------------------------
			CALL_Reg2: // SP <-- SP - 2
						 // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
			          // M[MAR] <-- WrBuf0, MAR + 1
					    // M[MAR] <-- WrBuf1
						 // PC <-- REG_OUT IR_Wire[4:0]
			begin	  
			  @ (negedge sys_clk)
			  begin
			   
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				  // VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000110000001110;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  Jump_En = 1'b0;
				  
				  Jump_Reg = 1'b0;
						
				  state = CALL_Reg3;
						
				  end
			end
			
			// ------------------------ CALL_Reg3 ----------------------------
			CALL_Reg3: // SP <-- SP - 2
						 // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
			          // M[MAR] <-- WrBuf0, MAR + 1
					    // M[MAR] <-- WrBuf1
						 // PC <-- REG_OUT IR_Wire[4:0]
			begin	  
			  @ (negedge sys_clk)
			  begin
			   
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000001000000100000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  Jump_En = 1'b0;
				  
				  Jump_Reg = 1'b0;
						
				  state = CALL_Reg4;
						
				  end
			end
			
			// ------------------------ CALL_Reg4 ----------------------------
			CALL_Reg4: // SP <-- SP - 2
						 // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
			          // M[MAR] <-- WrBuf0, MAR + 1
					    // M[MAR] <-- WrBuf1
						 // PC <-- REG_OUT IR_Wire[4:0]
			begin	  
			  @ (negedge sys_clk)
			  begin
			   
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000001000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  Jump_En = 1'b0;
				  
				  Jump_Reg = 1'b0;
						
				  state = CALL_Reg5;
						
				  end
			end
			
			// ------------------------ CALL_Reg5 ----------------------------
			CALL_Reg5: // SP <-- SP - 2
						 // WrBuf1:WrBuf0 <-- PC, MAR <-- SP
			          // M[MAR] <-- WrBuf0, MAR + 1
					    // M[MAR] <-- WrBuf1
						 // PC <-- REG_OUT IR_Wire[4:0]
			begin	  
			  @ (negedge sys_clk)
			  begin
			   
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[20:16], 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation
				  Jump_En = 1'b0;
				  
				  Jump_Reg = 1'b1;
						
				  state = INT_CHK;
						
				  end
			end
			
			// ------------------------ RET ------------------------------
			RET: // PC <-- RA                       // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // PC <-- RdBuf1:RdBuf0
																 // SP <-- SP + 2
			begin	  
				  @ (negedge sys_clk)
				  begin
	//			  #1 $display(" ");
	//			  #1 $display("We're in Return!!");
	//			  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				  // VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000001000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = RET2;
						
				  end
			end 
			
			// ------------------------ RET2 ------------------------------
			RET2: // PC <-- RA                       // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // PC <-- RdBuf1:RdBuf0
																 // SP <-- SP + 2
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = RET3;
						
				  end
			end 
			
			// ------------------------ RET3 ------------------------------
			RET3: // PC <-- RA                       // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // PC <-- RdBuf1:RdBuf0
																 // SP <-- SP + 2
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = RET4;
						
				  end
			end 
			
			// ------------------------ RET4 ------------------------------
			RET4: // PC <-- RA                       // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // PC <-- RdBuf1:RdBuf0
																 // SP <-- SP + 2
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_1_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = RET5;
						
				  end
			end 
			
			// ------------------------ RET5 ------------------------------
			RET5: // PC <-- RA                       // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // PC <-- RdBuf1:RdBuf0
																 // SP <-- SP + 2
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_10;
					
				  // VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end 
			
			// --------------------------- INTR_RET -------------------------
			INTR_RET:					 					 // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR], MAR <-- MAR + 1
																 // PC <-- RdBuf1:RdBuf0
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // Flag_Register <-- RdBuf1:RdBuf0
																 // SP <-- SP + 4
			begin	  
				  @ (negedge sys_clk)
				  begin
				$display(" ");
				$display("RETURNING FROM INTERRUPT!!");
			   $display("============================================================");
				$display("============================================================");
				$display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				  // VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000001000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INTR_RET2;
						
				  end
			end 
			
			// --------------------------- INTR_RET2 -------------------------
			INTR_RET2:					 					 // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR], MAR <-- MAR + 1
																 // PC <-- RdBuf1:RdBuf0
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // Flag_Register <-- RdBuf1:RdBuf0
																 // SP <-- SP + 4
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INTR_RET3;
						
				  end
			end
			
			// --------------------------- INTR_RET3 -------------------------
			INTR_RET3:					 					 // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR], MAR <-- MAR + 1
																 // PC <-- RdBuf1:RdBuf0
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // Flag_Register <-- RdBuf1:RdBuf0
																 // SP <-- SP + 4
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001001000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INTR_RET4;
						
				  end
			end
			
			// --------------------------- INTR_RET4 -------------------------
			INTR_RET4:					 					 // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR], MAR <-- MAR + 1
																 // PC <-- RdBuf1:RdBuf0
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // Flag_Register <-- RdBuf1:RdBuf0
																 // SP <-- SP + 4
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_1_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INTR_RET5;
						
				  end
			end 
			
			// --------------------------- INTR_RET5 -------------------------
			INTR_RET5:					 					 // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR], MAR <-- MAR + 1
																 // PC <-- RdBuf1:RdBuf0
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // Flag_Register <-- RdBuf1:RdBuf0
																 // SP <-- SP + 4
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INTR_RET6;
						
				  end
			end
			
			// --------------------------- INTR_RET6 -------------------------
			INTR_RET6:					 					 // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR], MAR <-- MAR + 1
																 // PC <-- RdBuf1:RdBuf0
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // Flag_Register <-- RdBuf1:RdBuf0
																 // SP <-- SP + 4
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INTR_RET7;
						
				  end
			end
			
			// --------------------------- INTR_RET7 -------------------------
			INTR_RET7:					 					 // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR], MAR <-- MAR + 1
																 // PC <-- RdBuf1:RdBuf0
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // Flag_Register <-- RdBuf1:RdBuf0
																 // SP <-- SP + 4
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b111_111_111_111;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INTR_RET8;
						
				  end
			end
			
			// --------------------------- INTR_RET8 -------------------------
			INTR_RET8:					 					 // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR], MAR <-- MAR + 1
																 // PC <-- RdBuf1:RdBuf0
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // Flag_Register <-- RdBuf1:RdBuf0
																 // SP <-- SP + 4
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_10;
					
				  // VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INTR_RET9;
						
				  end
			end
			
			// --------------------------- INTR_RET9 -------------------------
			INTR_RET9:					 					 // MAR <-- SP
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR], MAR <-- MAR + 1
																 // PC <-- RdBuf1:RdBuf0
																 // RdBuf0 <-- M[MAR], MAR <-- MAR + 1
																 // RdBuf1 <-- M[MAR]
																 // Flag_Register <-- RdBuf1:RdBuf0
																 // SP <-- SP + 4
			begin	  
				  @ (negedge sys_clk)
				  begin
				  
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_10;
					
				  // VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end
			
			
			
			
			
			
			// ------------------------ CLC --------------------------------
			CLC:
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in Clear Carry!!");
				//  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b010_000_000_000;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end 
			
			// ------------------------ STC --------------------------------
			STC:
			begin	  
				  @ (negedge sys_clk)
				  begin
				  //#1 $display(" ");
				  //#1 $display("We're in Set Carry!!");
				  //#1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b011_000_000_000;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;
						
				  end
			end 
			
			// ------------------------ CMPC --------------------------------
			CMPC:
			begin	  
				  @ (negedge sys_clk)
				  begin
				  //#1 $display(" ");
				  //#1 $display("We're in CMPC!!");
				  //#1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b100_000_000_000;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
						
				  state = INT_CHK;;
						
				  end
			end 
			
			// ------------------------ SETI --------------------------------
			SETI:
			begin	  
				  @ (negedge sys_clk)
				  begin
			//	  #1 $display(" ");
			//	  #1 $display("We're in SETI!!");
			//	  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b000_000_000_000;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
				  
				  INT_ENABLE = 1;
						
				  state = INT_CHK;
						
				  end
			end 
			
			// ------------------------ CLRI --------------------------------
			CLRI:
			begin	  
				  @ (negedge sys_clk)
				  begin
				//  #1 $display(" ");
				//  #1 $display("We're in CLRI!!");
				//  #1 $display(" ");
				  // FDP
				  {FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				  // IDP
				  {W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
					// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				  // BIU
				  {FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					 IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				  // Mem
				  {Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				  
				  // Flag Control Logic
				  {Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b000_000_000_000;
				 
				  // Jump Calculation 
				  Jump_En = 1'b0;	
				  Jump_Reg = 1'b0;
				  
				  INT_ENABLE = 0;
						
				  state = INT_CHK;
						
				  end
			end 
			
			// ------------------------ LOAD_imm1 --------------------------
         LOAD_imm1: // MAR <-- PC
         begin 
             @ (negedge sys_clk)
				 begin
			//	 #1 $display(" ");
			//	 #1 $display("We're in LDI!!");
			//	 #1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000010000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;			

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				
					
				state = LOAD_imm2;        
				end
         end 
			
			// ------------------------ LOAD_imm2 --------------------------
         LOAD_imm2: // RdBuf0 <-- M[MAR]
						  // PC <-- PC + 1
						  // MAR <-- MAR + 1
         begin 
				@ (negedge sys_clk)
				begin 
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP				
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_1_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = LD_imm3;
				end
				
         end 
			
			// ------------------------ LOAD_imm3 --------------------------
			LD_imm3: // RdBuf1 <-- M[MAR]
						// PC <-- PC + 1
         begin 
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP			
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_1_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
			
				state = LD_imm4;                
				end
         end 
			
			// ------------------------ LOAD_imm4 --------------------------
         LD_imm4: // R[d] <-- RdBuf1:RdBuf0
         begin 
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP				
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {14'b1_00_0_00000_00000, IR_Wire[4:0], 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INT_CHK;                
				end
         end 
			
			// ------------------------ LD1 -------------------------------
			LD1: // MAR <-- R[S[IR[20:16]]
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in LD!");
		//		#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[20:16], 
						5'b00000, 5'b00000,
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000010000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = LD2;  
				end
			end
			
			// ------------------------ LD2 -------------------------------
			LD2: // RdBuf0 <-- MAR
				  // MAR <-- MAR + 1
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = LD3;  
				end
			end
			
			// ------------------------ LD3 -------------------------------
			LD3: // RdBuf1 <-- MAR
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = LD4;  
				end
			end
			
			// ------------------------ LD4 -------------------------------
			LD4: // R[D[IR[4:0]] <-- RdBuf1:RdBuf0
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1000, 5'b00000, 
						5'b00000, IR_Wire[4:0],
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INT_CHK;  
				end
			end
			
			
			// ------------------------- STO_1 ----------------------------
         STO_1: // MAR <-- R[d]
					 // WrBuf1:WrBuf0 <-- R[s1]
         begin 
            @ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in store!");
		//		#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[4:0], 
						IR_Wire[20:16], 5'b00000,
						5'b10010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000010110000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = STO_2;                
				end
			end 
 
			// ------------------------- STO_2 ----------------------------
         STO_2: // M[MAR] <-- WrBuf0
					 // MAR <-- MAR + 1
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000001000000100000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;	
            
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = STO_3;                
				end
         end 
 
			// ------------------------- STO_3 ----------------------------
         STO_3: // M[MAR] <-- WrBuf1 
         begin
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000001000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- COPY -----------------------------
			COPY:
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in COPY!");
		//		#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, IR_Wire[20:16], 
						5'b00000, IR_Wire[4:0],
						5'b10001, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- EXC --------------------------
			EXC:    // Register_Intermediate <-- R[rs]
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in EXC!");
		//		#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						IR_Wire[12:8], 5'b00000,
						5'b10010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				// Exchange Control -- Special
				EX_En = 1'b1;
				WR_Sel = 1'b0;
              
				state = EXC2;                
				end
		   end
			
			// ------------------------- EXC2 --------------------------
			EXC2:    // R[rs] <-- R[rd]
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, IR_Wire[20:16], 
						5'b00000, IR_Wire[12:8],
						5'b10001, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				// Exchange Control -- Special
				EX_En = 1'b0;
				WR_Sel = 1'b0;
				
				
              
				state = EXC3;                
				end
		   end
			
			// ------------------------- EXC3 --------------------------
			EXC3:    // R[rd] <-- Intermediate Register
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						5'b00000, IR_Wire[20:16],
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				// Exchange Control -- Special
				EX_En = 1'b0;
				WR_Sel = 1'b1;
              
				state = INT_CHK;               
				end
		   end
			
			// ------------------------ INPUT -------------------------------
			INPUT: // MAR <-- R[S[IR[20:16]]
			begin
				@ (negedge sys_clk)
				begin
		//		$display(" ");
		//		$display("We're in INPUT!!");
		//		$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[20:16], 
						5'b00000, 5'b00000,
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000010000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	

				// IO
				{IO_CS_, IO_RD_, IO_WR_} = 3'b111;				

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INPUT2;  
				end
			end
			
			// ------------------------ INPUT2 -------------------------------
			INPUT2: // RdBuf0 <-- MAR
				  // MAR <-- MAR + 1
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	

				// IO
				{IO_CS_, IO_RD_, IO_WR_} = 3'b001;

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INPUT3;  
				end
			end
			
			// ------------------------ INPUT3 -------------------------------
			INPUT3: // RdBuf1 <-- MAR
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	

				// IO
				{IO_CS_, IO_RD_, IO_WR_} = 3'b001;

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INPUT4;  
				end
			end
			
			// ------------------------ INPUT4 -------------------------------
			INPUT4: // R[D[IR[4:0]] <-- RdBuf1:RdBuf0
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1000, 5'b00000, 
						5'b00000, IR_Wire[4:0],
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		
				
				// IO
				{IO_CS_, IO_RD_, IO_WR_} = 3'b111;

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INT_CHK;  
				end
			end
			
			// ------------------------- OUTPUT ----------------------------
         OUTPUT: // MAR <-- R[d]
					  // WrBuf1:WrBuf0 <-- R[s1]
         begin 
            @ (negedge sys_clk)
				begin
			//	#1 $display(" ");
			//	#1 $display("We're in OUTPUT!");
			//	#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[4:0], 
						IR_Wire[20:16], 5'b00000,
						5'b10010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000010110000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	

				// IO
				{IO_CS_, IO_RD_, IO_WR_} = 3'b111;				

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = OUTPUT2;                
				end
			end 
 
			// ------------------------- OUTPUT2 ----------------------------
         OUTPUT2: // M[MAR] <-- WrBuf0
					 // MAR <-- MAR + 1
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000001000000100000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;	
				
				// IO
				{IO_CS_, IO_RD_, IO_WR_} = 3'b010;
            
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = OUTPUT3;                
				end
         end 
 
			// ------------------------- OUTPUT3 ----------------------------
         OUTPUT3: // M[MAR] <-- WrBuf1 
         begin
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000001000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		
				
				// IO
				{IO_CS_, IO_RD_, IO_WR_} = 3'b010;

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
              
				state = INT_CHK;                
				end
		   end
			
			
			
			// ------------------------- CMP ------------------------------
			CMP:
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in CMP!");
		//		#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[20:16], 
						IR_Wire[12:8], 5'b00000,
						5'b00001, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- TEST ------------------------------
			TEST:
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in TEST!");
		//		#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[20:16], 
						IR_Wire[12:8], 5'b00000,
						5'b01000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- PUSH -----------------------------
			PUSH:  // SP <-- SP - 2
         begin 
            @ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in PUSH!");
		//		#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000, 5'b00000,
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = PUSH2;                
				end
			end 
			
			// ------------------------- PUSH2 ----------------------------
			PUSH2: // MAR <-- SP
					 // WrBuf1:WrBuf0 <-- R[s1]
         begin 
            @ (negedge sys_clk)
				begin
			
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						IR_Wire[20:16], 5'b00000,
						5'b10010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000110000001000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = PUSH3;                
				end
			end 
			
			// ------------------------- PUSH3 ----------------------------
			PUSH3: // M[MAR] <-- WrBuf0         
					 // MAR <-- MAR + 1           
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000001000000100000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;	
            
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = PUSH4;                
				end
         end

			// ------------------------- PUSH4 ----------------------------
			PUSH4: // M[MAR] <-- WrBuf1
         begin
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000001000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- POP ------------------------------
			POP: // MAR <-- SP
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in POP!!");
		//		#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000, 5'b00000,
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000001000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = POP2;  
				end
			end
			
			// ------------------------- POP2 -----------------------------
			POP2: // RdBuf0 <-- MAR
				   // MAR <-- MAR + 1
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = POP3;  
				end
			end
			
			// ------------------------- POP3 -----------------------------
			POP3: // RdBuf1 <-- MAR
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = POP4;  
				end
			end
			
			// ------------------------- POP4 -----------------------------
			POP4: // R[D[IR[4:0]] <-- RdBuf1:RdBuf0
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1000, 5'b00000, 
						5'b00000, IR_Wire[4:0],
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = POP5;  
				end
			end
			
			// ------------------------- POP5 -----------------------------
			POP5: // SP <-- SP + 2
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000, 5'b00000,
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INT_CHK;  
				end
			end
			
			
			// ------------------------- NEG ------------------------------
			NEG:
			begin
				@ (negedge sys_clk)
				begin
			//	#1 $display(" ");
			//	#1 $display("We're in NEG!");
			//	#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16], IR_Wire[4:0],
						5'b01100, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- NOT ------------------------------
			NOT:
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in NOT!");
		//		#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16], IR_Wire[4:0],
						5'b01011, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- INC ------------------------------
			INC:
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in INC!");
		//		#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16], IR_Wire[4:0],
						5'b00110, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- DEC ------------------------------
			DEC:
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in DEC!!");
		//		#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16], IR_Wire[4:0],
						5'b00111, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- LSR ------------------------------
			LSR:
			begin
				@ (negedge sys_clk)
				begin
				//#1 $display(" ");
				//#1 $display("We're in LSR!");
				//#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16], IR_Wire[4:0],
						5'b01110, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;             
				end
		   end
			
			// ------------------------- LSL ------------------------------
			LSL:
			begin
				@ (negedge sys_clk)
				begin
				//#1 $display(" ");
				//#1 $display("We're in LSL!");
				//#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						IR_Wire[20:16], IR_Wire[4:0],
						5'b01101, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;;                
				end
		   end
			
			// ------------------------- ADDI -----------------------------	
			ADDI:
			begin
				@ (negedge sys_clk)
				begin
			//	#1 $display(" ");
			//	#1 $display("We're in ADDI!");
			//	#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1101, IR_Wire[20:16], 
						5'b00000, IR_Wire[4:0],
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- SUBI -----------------------------	
			SUBI:
			begin
				@ (negedge sys_clk)
				begin
			//	#1 $display(" ");
			//	#1 $display("We're in SUBI!");
			//	#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1101, IR_Wire[20:16], 
						5'b00000, IR_Wire[4:0],
						5'b00001, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;               
				end
		   end
			
			// ------------------------- MULI -----------------------------	
			MULI:
			begin
				@ (negedge sys_clk)
				begin
			//	#1 $display(" ");
			//	#1 $display("We're in MULI!");
			//	#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1101, IR_Wire[20:16], 
						5'b00000, IR_Wire[4:0],
						5'b00010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = MULI2;                
				end
		   end
			
			// ------------------------- MULI2 ----------------------------	
			MULI2:
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						5'b00000, IR_Wire[4:0] + 1'b1,
						5'b00011, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- DIVI -----------------------------	
		   DIVI:
			begin
				@ (negedge sys_clk)
				begin
		//		#1 $display(" ");
		//		#1 $display("We're in DIVI!");
		//		#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1101, IR_Wire[20:16], 
						5'b00000, IR_Wire[4:0],
						5'b00100, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = DIVI2;                
				end
		   end
			
			// ------------------------- DIVI2 -----------------------------
			DIVI2:
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1001, 5'b00000, 
						5'b00000, IR_Wire[4:0] + 1'b1,
						5'b00101, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- ANDI -----------------------------	
			ANDI:
			begin
				@ (negedge sys_clk)
				begin
				//#1 $display(" ");
				//#1 $display("We're in ANDI!");
				//#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1101, IR_Wire[20:16], 
						5'b00000, IR_Wire[4:0],
						5'b01000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;               
				end
		   end
			
			// ------------------------- ORI -----------------------------	
			ORI:
			begin
				@ (negedge sys_clk)
				begin
				//#1 $display(" ");
				//#1 $display("We're in ORI!");
				//#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1101, IR_Wire[20:16], 
						5'b00000, IR_Wire[4:0],
						5'b01001, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- XORI -----------------------------	
			XORI:
			begin
				@ (negedge sys_clk)
				begin
			//	#1 $display(" ");
			//	#1 $display("We're in XORI!");
			//	#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b1101, IR_Wire[20:16], 
						5'b00000, IR_Wire[4:0],
						5'b01010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;                
				end
		   end
			
			// ------------------------- CMPI -----------------------------
			CMPI:
			begin
				@ (negedge sys_clk)
				begin
				//#1 $display(" ");
				//#1 $display("We're in CMPI!!");
				//#1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0101, IR_Wire[20:16], 
						5'b00000, 5'b00000,
						5'b00001, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
              
				state = INT_CHK;               
				end
		   end
			
			// ------------------------- FADD -----------------------------
			FADD: // FR[d] <-- FR[s1] + FR[s2]
         begin 
            @ (negedge sys_clk)
				begin
				//$display(" ");
				//$display("We're in FADD!!");
				//$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b1, IR_Wire[4:0], IR_Wire[12:8], IR_Wire[20:16], 4'b0110, 4'b0000};
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;
				end
         end 
			
			// ------------------------- FSUB -----------------------------
			FSUB: // FR[d] <-- FR[s1] - FR[s2]
         begin 
            @ (negedge sys_clk)
				begin
				//$display(" ");
				//$display("We're in FSUB!!");
				//$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b1, IR_Wire[4:0], IR_Wire[12:8], IR_Wire[20:16], 4'b0111, 4'b0000};
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;  
				end
         end
			
			// ------------------------- FMUL -----------------------------
			FMUL: // FR[d] <-- FR[s1] * FR[s2]
         begin 
            @ (negedge sys_clk)
				begin
				//$display(" ");
				//$display("We're in FMUL!!");
				//$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b1, IR_Wire[4:0], IR_Wire[12:8], IR_Wire[20:16], 4'b1001, 4'b0000};
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;  
				end
         end
			
			// ------------------------- FDIV -----------------------------
			FDIV: // R[d] <-- R[s1] and R[s2]
         begin 
            @ (negedge sys_clk)
				begin
				//$display(" ");
				//$display("We're in FDIV!!");
				//$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b1, IR_Wire[4:0], IR_Wire[12:8], IR_Wire[20:16], 4'b1010, 4'b0000};
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK; 
				end
         end 
			
			// ------------------------- FINC -----------------------------
			FINC: // R[d] <-- R[s1] + 1
         begin 
            @ (negedge sys_clk)
				begin
				//$display(" ");
				//$display("We're in FINC!!");
				//$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b1, IR_Wire[4:0], 5'b00000, IR_Wire[20:16], 4'b0010, 4'b0000};
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;  
				end
         end 
			
			// ------------------------- FDEC -----------------------------
			FDEC: // R[d] <-- R[s1] - 1
         begin 
            @ (negedge sys_clk)
				begin
				//$display(" ");
				//$display("We're in FDEC!!");
				//$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b1, IR_Wire[4:0], 5'b00000, IR_Wire[20:16], 4'b0100, 4'b0000};
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;
				end
         end 
			
			// ------------------------- FZERO -----------------------------
			FZERO: // R[d] <-- 0.0
         begin 
            @ (negedge sys_clk)
				begin
			//	$display(" ");
			//	$display("We're in FZERO!!");
			//	$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b1, IR_Wire[4:0], 5'b00000, 5'b00000, 4'b1100, 4'b0000};
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK;
				end
         end 
			
			// ------------------------- FONE -----------------------------
			FONE: // R[d] <-- 1.0
         begin 
            @ (negedge sys_clk)
				begin
				//$display(" ");
				//$display("We're in FONE!!");
				//$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b1, IR_Wire[4:0], 5'b00000, 5'b00000, 4'b1101, 4'b0000};
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000,
						5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
								
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b001_001_001_001;
				
				state = INT_CHK; 
				end
         end 
			
			
			// ------------------------- FLDI -----------------------------
			FLDI: // MAR <-- PC
         begin 
             @ (negedge sys_clk)
				 begin
				// #1 $display(" ");
				// #1 $display("We're in FLDI!!");
				// #1 $display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					= 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000010000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;			

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
					
				state = FLDI2;        
				end
         end 
			
			// ------------------------- FLDI2 -----------------------------
			FLDI2: // RdBuf0 <-- M[MAR]
				    // PC <-- PC + 1
				    // MAR <-- MAR + 1
         begin 
				@ (negedge sys_clk)
				begin 
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP				
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_1_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = FLDI3;
				end
				
         end 
			
			// ------------------------- FLDI3 -----------------------------
			FLDI3: // RdBuf1 <-- M[MAR]
						// PC <-- PC + 1
         begin 
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
			
				// IDP			
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_1_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;	
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
			
				state = FLDI4;                
				end
         end 
			
			// ------------------------- FLDI4 -----------------------------
			FLDI4: // R[d] <-- RdBuf1:RdBuf0
         begin 
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b0, IR_Wire[4:0], 5'b00000, 5'b00000, 4'b0000, 4'b0000};
				
				// IDP				
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {14'b0_00_1_00000_00000, 5'b00000, 
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INT_CHK;              
				end
         end 
			
			// ------------------------ FLD --------------------------------
			FLD: // MAR <-- R[S[IR[20:16]]
			begin
				@ (negedge sys_clk)
				begin
			//	$display(" ");
			//	$display("We're in FLD!!");
			//	$display(" ");
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[20:16], 
						5'b00000, 5'b00000,
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000010000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = FLD2;  
				end
			end
			
			// ------------------------ FLD2 ------------------------------
			FLD2: // RdBuf0 <-- MAR
				  // MAR <-- MAR + 1
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000101000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = FLD3;  
				end
			end
			
			// ------------------------ FLD3 -------------------------------
			FLD3: // RdBuf1 <-- MAR
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b001000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = FLD4;  
				end
			end
			
			// ------------------------ FLD4 -------------------------------
			FLD4: // R[D[IR[4:0]] <-- RdBuf1:RdBuf0
			begin
				@ (negedge sys_clk)
				begin
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b1, 1'b0, IR_Wire[4:0], 5'b00000, 5'b00000, 4'b0000, 4'b0000};
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, 5'b00000, 
						5'b00000, 5'b00000,
						5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = INT_CHK;
				end
			end
			
			// ------------------------ FSTO ------------------------------
         FSTO: // MAR <-- R[d]
					 // WrBuf1:WrBuf0 <-- FR[s1]
         begin 
            @ (negedge sys_clk)
				begin
				//#1 $display(" ");
				//#1 $display("We're in FSTO!");
				//#1 $display(" ");
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} 
					= {1'b0, 1'b1, 5'b00000, IR_Wire[20:16], IR_Wire[4:0], 4'b0001, 4'b1100};
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= {4'b0001, IR_Wire[4:0], 
						5'b00000, 5'b00000,
						5'b10010, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00};
						
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b110010000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = FSTO2;                
				end
			end 
			
			// ------------------------- FSTO2 ----------------------------
         FSTO2: // M[MAR] <-- WrBuf0
					 // MAR <-- MAR + 1
         begin 
            @ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000001000010000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;	
            
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				state = FSTO3;                
				end
         end 
			
			// ------------------------- FSTO3 ----------------------------
         FSTO3: // M[MAR] <-- WrBuf1 
         begin
				@ (negedge sys_clk)
				begin
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;

				// IDP					
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode}                                          
					 = 24'b0_0_00000_00000_00000_00000_00;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000000000100000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b010;		

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
              
				state = INT_CHK;               
				end
		   end
			
			
			// ------------------------- HALT -----------------------------				
         HALT: // Dump_Registers
					// Dump_Memory
					// $finish
			begin
			   @ (negedge sys_clk)
				begin
				// Display time of halt instruction fetch
				$display("HALT INSTRUCTION FETCHED %t",$time); 
              
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					 = 26'b0_0_00000_00000_00000_00000_000_0;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP,
					Int_En, WR0_FR_En, VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000000000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				$display(" ");
				$display("Integer Datapath Registers After Operations");
				$display("------------------------------------------------");
            Dump_Registers; 
				$display(" ");
				$display("Memory After Operations");
				$display("------------------------------------------------");
				Dump_Memory;
//				$display(" ");
//				$display("Floating Point Registers After Operations");
//				$display("------------------------------------------------");
//				Dump_FP;
//				$display(" ");
//				$display("Vector Registers After Operations");
//				$display("------------------------------------------------");
//				Dump_Vectors;
            $finish; 
				end
         end 
 
			// ----------------------- ILLEGAL_OP --------------------------
         ILLEGAL_OP: // Dump_Registers
							// $finish
         begin 
				
				// Illegal Opcode
				$display("ILLEGAL OPCODE FETCHED %t",$time); 
				
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
            
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					 = 26'b0_0_00000_00000_00000_00000_000_0;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP,
					Int_En, WR0_FR_En, VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000000000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;			

				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
             
				Dump_Registers; 
				$display("Mem[3FDh]=%h",TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3FD]);
				$display("Mem[3FCh]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3FC]);
				$display(" ");
				$display("Contents of MANDA temp reg = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.VectorRegFile.mandareg);
				$display("Contents of R2 in Vector Reg File = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.VectorRegFile.R2);
				$display("PC = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.PC);
				$display("-----------------Contents of Vector Registers--------------------");
				Dump_Vectors;
            $finish; 
				
            
			end 
			
			// ----------------------- DEBUG_STATE --------------------------
			DEBUG_STATE:
			begin
			   @ (negedge sys_clk)
				begin
				// Display time of halt instruction fetch
			//	$display("DEBUG STATE %t",$time); 
              
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
				
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} 
					= 30'b0_00_1_00000_00000_00000_00000_0_0_0_0_00;
					
				// VDP 
				{VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					= 26'b0_0_00000_00000_00000_00000_000_0;
					
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP, Int_En, WR0_FR_En,
					VR1_En, VR0_En, VR1OE, VR0OE} = 24'b000000000000000000000000;
					
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b111;
				
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
				// Exchange Control -- Special
				EX_En = 1'b0;
				WR_Sel = 1'b0;
				
		//		$display(" ");
		//		$display("Integer Datapath Registers After Operations");
		//		$display("------------------------------------------------");
       //     Dump_Registers; 
//				$display(" ");
//				$display("Vector Datapath Registers After Operations");
//				$display("------------------------------------------------");
//				Dump_Vectors;
		//		$display(" ");
		//		$display("Memory After Operations");
		//		$display("------------------------------------------------");
		//		Dump_Memory;
		//		$display(" ");
//				$display("Floating Point Registers After Operations");
//				$display("------------------------------------------------");
//				Dump_FP;
//				$display("Flag Register = %h ", Flag_Register);
//           $display("PC = %h",TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.PC);
//				$display("R15 in regfile = %h", TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.regfile64.reg32[15]);
		//		$display("Mem[3F9h]=%h",TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F9]);
		//		$display("Mem[3F8h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F8]);
		//		$display("Mem[3F7h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F7]);
		//		$display("Mem[3F6h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F6]);
		//		$display("Mem[3F5h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F5]);
		//		$display("Mem[3F4h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F4]);
		//		$display("Mem[3F3h]=%h", TB.Robonaut_Architecture.Core_Architecture.memory.memarray[10'h3F3]);
            state = INT_CHK;
				end
         end 
 
       endcase 

// ---------------------------- Memory Dump ------------------------------		 
task Dump_Memory;
	begin
		for (j = 8'hE0; j <= 8'hFF; j = j + 1'b1)
		begin
			@ (negedge sys_clk)
			begin
	
				TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.MAR = j;
		
				// FDP
				{FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP0_En, FP1_En, FP1OE, FP0OE} = 25'b0;
		
				// IDP
				{W_En, S_Sel, Y_Sel, R_Addr, S_Addr, W_Addr, ALU_OP, PC_En, PC_Reset, Call_En, Ret_En, SP_Inc, SP_Dec} = 30'b0;
				
				// VDP 
				  {VW_En, VS_Sel, VR_Addr, VS_Addr, VW_Addr, VALU_OP, V_Mode, MANDA_En}                                          
					 = 26'b0_0_00000_00000_00000_00000_000_0;
		
				// BIU
				{FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, 
					IR_En, FP1OE, FP0OE, WR1OE, WR0OE, MAR_En_PC, MAR_En_SP, WR1Sel, WR0Sel, MAR_En_FP} = 18'b000100000000000000;
		
				// Mem
				{Mem_CS_, Mem_RD_, Mem_WR_} = 3'b001;
		
				Jump_En = 1'b0;
				Jump_Reg = 1'b0;
				
				// Flag Control Logic
				{Flag_C_Sel, Flag_Z_Sel, Flag_N_Sel, Flag_V_Sel} = 12'b0;
				
			end
			@ (posedge sys_clk)
			begin
	
			end
			#1 $display("t = %t, M[%h], Memory_Content = %h", $time, j, 
								TB.Robonaut_Architecture.Core_Architecture.CPU_EU.biu.RdBuf_0);
		end
	end
endtask

// ---------------------------- Register Dump ------------------------------		
task Dump_Registers;
	for (i = 0; i < 16; i = i + 1) 
	begin
		@ (posedge sys_clk)
		begin
			#1 $display ("t = %t, R_Addr[%h] = %h", $time, i, 
								TB.Robonaut_Architecture.Core_Architecture.CPU_EU.Integer_Datapath.regfile64.reg32[i]);
		end		
	end
endtask

// ---------------------- Vector Register Dump ------------------------------		
task Dump_Vectors;
	for (i = 0; i < 16; i = i + 1) 
	begin
		@ (posedge sys_clk)
		begin
			#1 $display ("t = %t, R_Addr[%h] = %h", $time, i, 
								TB.Robonaut_Architecture.Core_Architecture.CPU_EU.VectorDP.VectorRegFile.reg32[i]);
		end		
	end
endtask

// ------------------------ FP Register Dump --------------------------------		
task Dump_FP;
	for (i = 0; i < 16; i = i + 1) 
	begin
		@ (posedge sys_clk)
		begin
			#1 $display ("t = %t, R_Addr[%h] = %h", $time, i, 
								TB.Robonaut_Architecture.Core_Architecture.CPU_EU.FloatDP.FPRegFile.reg32[i]);
		end		
	end
endtask
 
endmodule
