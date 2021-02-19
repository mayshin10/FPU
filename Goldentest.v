
`timescale 1ns/10ps

module Goldentest;
	reg Clock, Reset;
	reg [31:0] A, B;
	reg [1:0] Sel;
        reg round;
	reg start;
	wire [31:0] Y;
	wire Overflow, Error;
	parameter STEP=5;
	
	FPU FPU(Clock,Reset,A,B,Sel,round, start, Error,Overflow,Y);
	
	initial
		$monitor($time, "A = %b, B = %b, Sel = %b, Y = %b, Overflow = %b, Error = %b", A, B, Sel, Y, Overflow, Error);
	
	initial
	begin
		Clock = 1'b0;
		forever #(STEP/2) Clock = ~Clock;
	end
	
	initial begin 
		Reset=1;
		A=32'b00000000000000000000000000000000;
		B=32'b00000000000000000000000000000000;
		Sel = 2'b00;
		start =0;
		round =0;
		repeat(2)@(negedge Clock); Reset = 0;
		repeat(2)@(negedge Clock); Reset = 1;
		repeat(1)@(negedge Clock);
		
		
		//arithmetic operation
		A = 32'b0_10000110_11100000000000000000000;
		B = 32'b0_10000101_11100000000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);


		A = 32'b0_10000110_11100000000000000000000;
		B = 32'b0_10000101_11100000000000000000000;
		Sel = 2'b01;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);



		A = 32'b1_10000110_11100000000000000000000;
		B = 32'b1_10000101_11100000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);


		A = 32'b0_10000110_11100000000000000000000;
		B = 32'b1_10000101_11100000000000000000000;
		Sel = 2'b11;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		//rounding
		A = 32'b0_10000000_00000001000000000000000;
		B = 32'b0_10000001_00000001000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		
		A = 32'b0_10000000_00000001000000000000000;
		B = 32'b0_10000001_00000001000000000000000;
		Sel = 2'b00;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);


		//overflow
		A = 32'b0_11111110_00000010000000000000000;
		B = 32'b0_11111110_00000010000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);


		A = 32'b0_11111110_00000010000000000000000;
		B = 32'b1_11000000_11100000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);
		
		//zero
		A = 32'b0_11111110_00000010000000000000000;
		B = 32'b0_11111110_00000010000000000000000;
		Sel = 2'b01;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);


		A = 32'b0_00000000_00000010000000000000000;
		B = 32'b1_11111110_00000010000000000000000;
		Sel = 2'b11;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		//NAN
		A = 32'b0_11111111_00000000000000000000000;
		B = 32'b1_11111111_00000000000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_00000000_00000000000000000000000;
		B = 32'b0_11111111_00000000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_00000000_00000000000000000000000;
		B = 32'b0_00000000_00000000000000000000000;
		Sel = 2'b11;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		//arithmetic operation
		A = 32'b0_10000110_00000010000000000000000;
		B = 32'b0_10000101_11100000000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000101_11111100000000000000000;
		B = 32'b1_10000000_10000000000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000101_00000000000000000000000;
		B = 32'b0_10000101_11111100000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000101_11111100000000000000000;
		B = 32'b1_10000100_00000000000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000101_11111100000000000000000;
		B = 32'b0_10000011_11100000000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000011_00000000000000000000000;
		B = 32'b1_10000011_10110000000000000000000;
		Sel = 2'b00;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000110_00000010000000000000000;
		B = 32'b1_10000101_11100000000000000000000;
		Sel = 2'b00;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000110_00000010000000000000000;
		B = 32'b1_10000110_00100000000000000000000;
		Sel = 2'b00;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000010_11000000000000000000000;
		B = 32'b1_10000101_11111100000000000000000;
		Sel = 2'b00;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000011_11110000000000000000000;
		B = 32'b1_10000000_00000000000000000000000;
		Sel = 2'b00;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000110_00000010000000000000000;
		B = 32'b0_10000101_11100000000000000000000;
		Sel = 2'b01;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000110_00000010000000000000000;
		B = 32'b0_10000110_00100000000000000000000;
		Sel = 2'b01;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000010_11000000000000000000000;
		B = 32'b0_10000101_11111100000000000000000;
		Sel = 2'b01;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000011_11110000000000000000000;
		B = 32'b0_10000000_00000000000000000000000;
		Sel = 2'b01;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000101_11111100000000000000000;
		B = 32'b1_10000000_10000000000000000000000;
		Sel = 2'b01;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000101_00000000000000000000000;
		B = 32'b0_10000101_11111100000000000000000;
		Sel = 2'b01;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000101_11111100000000000000000;
		B = 32'b1_10000100_00000000000000000000000;
		Sel = 2'b01;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000101_11111100000000000000000;
		B = 32'b0_10000011_11100000000000000000000;
		Sel = 2'b01;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000011_00000000000000000000000;
		B = 32'b1_10000011_10110000000000000000000;
		Sel = 2'b01;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000110_00000010000000000000000;
		B = 32'b1_10000101_11100000000000000000000;
		Sel = 2'b01;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000110_00000010000000000000000;
		B = 32'b1_10000110_00100000000000000000000;
		Sel = 2'b01;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000010_11000000000000000000000;
		B = 32'b1_10000101_11111100000000000000000;
		Sel = 2'b01;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000011_11110000000000000000000;
		B = 32'b1_10000000_00000000000000000000000;
		Sel = 2'b01;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000100_10011000000000000000000;
		B = 32'b0_10000011_10110000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000101_11100000000000000000000;
		B = 32'b0_10000000_10000000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_01111111_00000000000000000000000;
		B = 32'b0_10000011_01100000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000100_10011000000000000000000;
		B = 32'b0_10000011_10110000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000101_11100000000000000000000;
		B = 32'b1_10000000_10000000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_01111111_00000000000000000000000;
		B = 32'b1_10000011_01100000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000100_10011000000000000000000;
		B = 32'b1_10000011_10110000000000000000000;
		Sel = 2'b10;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000101_11100000000000000000000;
		B = 32'b1_10000000_10000000000000000000000;
		Sel = 2'b10;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_01111111_00000000000000000000000;
		B = 32'b1_10000011_01100000000000000000000;
		Sel = 2'b10;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000011_00010000000000000000000;
		B = 32'b0_10000000_10000000000000000000000;
		Sel = 2'b11;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000110_11100110000000000000000;
		B = 32'b0_10000100_10011000000000000000000;
		Sel = 2'b11;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000100_01011000000000000000000;
		B = 32'b0_10000101_11000000000000000000000;
		Sel = 2'b11;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000000_00000000000000000000000;
		B = 32'b0_10000110_01001100000000000000000;
		Sel = 2'b11;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000011_00010000000000000000000;
		B = 32'b0_10000000_10000000000000000000000;
		Sel = 2'b11;
		start =1;
		round =0;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000110_11100110000000000000000;
		B = 32'b0_10000100_10011000000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000100_01011000000000000000000;
		B = 32'b0_10000101_11000000000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000000_00000000000000000000000;
		B = 32'b0_10000110_01001100000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000011_00010000000000000000000;
		B = 32'b1_10000000_10000000000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000110_11100110000000000000000;
		B = 32'b1_10000100_10011000000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000100_01011000000000000000000;
		B = 32'b1_10000101_11000000000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b0_10000000_00000000000000000000000;
		B = 32'b1_10000110_01001100000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000011_00010000000000000000000;
		B = 32'b1_10000000_10000000000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000110_11100110000000000000000;
		B = 32'b1_10000100_10011000000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000100_01011000000000000000000;
		B = 32'b1_10000101_11000000000000000000000;
		Sel = 2'b11;
		start =1;
		round =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);

		A = 32'b1_10000000_00000000000000000000000;
		B = 32'b1_10000110_01001100000000000000000;
		Sel = 2'b11;
		round =1;
		start =1;
		repeat(1)@(negedge Clock);
		start =0;
		repeat(10)@(negedge Clock);
	 
		repeat(200)@(negedge Clock);
		$stop;
	end

endmodule

