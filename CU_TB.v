`timescale 1ps / 100fs
/************************************************************************************** 
* Date: 			 October 26, 2011 
* File: 			 
* Engineers: 	 Abodunrin Adepoju, Bruno Venegas
* Project Name: Robonaut Architecture
* Class:			 CECS 440 
* 
* Testbench Implementation
******************************************************************************/

module TB;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
//	wire int_ack;

	// Instantiate the Unit Under Test (UUT)
	Robonaut_Architecture Robonaut_Architecture (
		.clk(clk), 
		.reset(reset)  
	);
	
	always
		#50 clk =~clk;

	initial begin
		// Initialize Inputs
		$timeformat(-9, 1, "ns", 6);
		$readmemh("mem01_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem02_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem03_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem04_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem05_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem06_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem07_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem08_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem09_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem10_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem11_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem12_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem13_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem14_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
//		$readmemh("mem15_64_Fa11.dat", Robonaut_Architecture.Core_Architecture.memory.memarray);
		clk = 0;
		
		Robonaut_Architecture.Core_Architecture.IO.interrupt= 1'b0;
		
		@ (negedge clk)
		begin
			reset = 1;
		end

		@ (negedge clk)
		begin
			reset = 0;
		end
		
		#16000;
//		Robonaut_Architecture.Core_Architecture.IO.interrupt = 1'b1;
		
		@(posedge Robonaut_Architecture.CU64.int_ack)
		Robonaut_Architecture.Core_Architecture.IO.interrupt = 1'b0;
		
	end
      
endmodule

