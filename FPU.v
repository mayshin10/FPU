
module FPU(clk, reset, A, B, sel, round_mode, start, error, over_flow, Y);
input clk, reset;
input [31:0] A, B;
input [1:0] sel;
input round_mode, start;
output reg error, over_flow;
output reg [31:0] Y;

reg [31:0] A_fpu, B_fpu;
reg [1:0] sel_fpu;
reg round_fpu;

wire error_fpu, over_flow_fpu;
wire [31:0] Y_fpu;

FPU_CAL fpu_cal(clk, start, A_fpu, B_fpu, sel_fpu, round_fpu, error_fpu, over_flow_fpu, Y_fpu);

always @(posedge clk, negedge reset) begin
	if(~reset) begin
		A_fpu <=0;
		B_fpu <=0;
		sel_fpu <=0;
		round_fpu <=0;
		Y<=0;
	 end

	else begin
		if(start) begin
			A_fpu <=A;
			B_fpu <=B;
			sel_fpu <=sel;
			round_fpu <=round_mode;
		end
		else begin
			A_fpu <=A_fpu;
			B_fpu <=B_fpu;
			sel_fpu <=sel_fpu;
			round_fpu <=round_fpu;
			Y <= Y_fpu;
			over_flow <= over_flow_fpu;
			error <= error_fpu;
		end
	end
end
endmodule











	