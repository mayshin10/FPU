
module FPU_CAL (clk, start, A, B, sel, round_mode, error, over_flow, Y);
input clk, start;
input [31:0] A, B;
input [1:0] sel;
input round_mode;

output reg error,over_flow;
output reg [31:0] Y;
/****************************************************************/
wire S1, S2;
wire [7:0] E1, E2;
wire [22:0] M1, M2;
wire [22:0] result;
wire [4:0] shifted;

reg [24:0] M1_t, M2_t,M_sum;
reg S;
reg [8:0] E;
reg [47:0] M1M2;
reg [47:0] div;
reg [23:0] divider;
reg [24:0] quotient;

FPU_normalize fpu_normalize(M_sum, result, shifted);	//normalizer for adder&subtractor


/****************************************************************/
assign S1 = A[31];
assign E1 = A[30:23];
assign M1 = A[22:0];

assign S2 = B[31];
assign E2 = B[30:23];
assign M2 = B[22:0];
/****************************************************************/

parameter NaN = 32'b0_11111111_10000000000000000000000,
	  INF = 31'b11111111_00000000000000000000000;

parameter STATE1 = 0,	//NaN condition check or calculation
	  STATE2 = 1,	//normalization
	  STATE3 = 2,	//rounding
	  STATE4 = 3;	//output

reg [2:0] next_state;


always @(posedge clk) begin
	//initialization
        if(start) begin
		error=0;
		over_flow=0;
 		next_state=STATE1;
	end
	//operation before normalization
	else if(next_state==STATE1) begin
		next_state=STATE2;
		case (sel)
		//ADD mode
		2'b00, 2'b01 : begin
			//NaN condition for ADD and SUB
			if ((A[30:0]==INF && B[30:0]==INF) && (A[31]^B[31]^sel[0])) begin
				Y = NaN;
				error = 1;
				next_state=STATE4;
			end	
			else begin
				M1_t={2'b01,M1};
				M2_t={2'b01,M2};
				if (E1 > E2) begin
					M2_t = M2_t >> E1-E2;
					E = {1'b0,E1};
				end
				else begin
					M1_t = M1_t >> E2-E1;
					E = {1'b0,E2};
				end

				if (M1_t>M2_t) begin
					S=S1;
					if (S1^S2^sel[0])
						M_sum = M1_t-M2_t;
					else
						M_sum = M1_t+M2_t;
				end
				else begin
					if (S1^S2^sel[0]) begin
						M_sum = M2_t-M1_t;
						S = 1-S1;
					end
					else begin
						M_sum = M2_t+M1_t;
						S = S1;
					end
				end
				
			end
		end		
		2'b10 : begin
			//NaN condition for Multi
			//including denormalized number as 0
			if ((A[30:23] == 8'b0 && B[30:0]==INF) || (A[30:0] == INF && B[30:23]==8'b0)) begin
				Y = NaN;
				error = 1;
				next_state=STATE4;
				end	
			else if ((A[30:0] == INF) || (B[30:0] == INF)) begin
				Y={S1^S2,INF};
				over_flow=1;
				next_state=STATE4;
				end				
			//input 0		
			else if ((A[30:23] == 8'b0) || (B[30:23] == 8'b0)) begin
				Y={S1^S2,31'b0};
				next_state=STATE4;
				end
			else if (E1+E2<9'b0_0111_1111) begin
				Y={S1^S2,31'b0};
				next_state=STATE4;
				end
			else begin
				E=E1+E2-8'b0111_1111;
				M1M2={1'b1,M1}*{1'b1,M2};
			end
		end
		2'b11 : begin
			//NaN condition for DIV
			if ((A[30:0]==INF) && (B[30:0]==INF)) begin
				error = 1;
				Y=NaN;
				next_state=STATE4;
				end
			else if ((A[30:23]==8'b0) && (B[30:23]==8'b0)) begin
				error = 1;
				Y=NaN;
				next_state=STATE4;
				end
			else if (B[30:23]==8'b0) begin
				Y={S1^S2,INF};
				over_flow=1;
				next_state=STATE4;
				end
			else if (E1<=E2-8'b0111_1111) begin 
				Y={S1^S2,31'b0};
				next_state=STATE4;
				end
			else begin
				div={1'b1,M1,24'b0};
				divider = {1'b1,M2};
				E=E1-E2+8'b0111_1111;
			end
		  end
	endcase
	
	end
	
	else if(next_state==STATE2) begin
	next_state=STATE3;
	case (sel)
		2'b00, 2'b01 : begin
			if (M_sum == 25'b0) begin
				Y=0;
				next_state = STATE4;
				end
			else if (E < shifted) begin
				Y=0;
				next_state = STATE4;
				end
			else begin
				E = E - shifted + 1; 
			end				
		end		
		2'b10 : begin
			if (M1M2[47]==1) begin
				E=E+1'b1;
			end
			else begin
				M1M2=M1M2 << 1;
			end
			
		end
		2'b11 : begin
			if (M2>M1)begin
				E=E-1'b1;
				quotient={div/divider,1'b0};
				end				
			else begin
				E=E;
				quotient=div/divider;
			end
		end
	endcase
	end
	//rounding process
	else if(next_state==STATE3) begin
	case (sel)
		//ADD mode
		2'b00, 2'b01 : begin
				if (E >= 9'b0_1111_1111 ) begin	//bigger than infinite
					over_flow=1;
					Y = (S==0) ? {1'b0,INF} : {1'b1,INF};
				end
				else if ({M_sum[15:14],round_mode}==3'b110) 
					Y={S,E[7:0],result[22:15]+1'b1,15'b0};
				else
					Y={S,E[7:0],result[22:15],15'b0};
				
		end		
		2'b10 : begin
				if (E >= 9'b0_1111_1111) begin
					Y={S1^S2,8'b1111_1111,23'b0};
					over_flow = 1;
					end
				else if (E == 9'b0) begin
					Y={S1^S2,31'b0};
					end
				else if ({M1M2[39:38],round_mode}==3'b110) begin
					Y={S1^S2,E[7:0],M1M2[46:39]+1'b1,15'b0};
					end
				else 
					Y={S1^S2,E[7:0],M1M2[46:39],15'b0};
		end
		2'b11 : begin
				if (E >= 9'b0_1111_1111) begin
					Y={S1^S2,8'b1111_1111,23'b0};
					over_flow = 1;
					end
				else if (E == 9'b0) begin
					Y={S1^S2,31'b0};
					end
				else if ({quotient[16:15],round_mode}==3'b110)
					Y={S1^S2,E[7:0],quotient[23:16]+1'b1,15'b0};
				else 
					Y={S1^S2,E[7:0],quotient[23:16],15'b0};
				
		end
	endcase
	end

	//if(next_state==STATE4) + default statement
	else begin
		Y = Y;
	end

end
endmodule



