module translater(ENB, clk, in_1, in_2, in_3, selector, selector3, out_1, out_2, out_3);

	input wire ENB, clk, selector, selector3;
	input wire [6:0] in_1, in_2;
	input wire [31:0] in_3;
	output reg [6:0] out_1, out_2;
	output reg [31:0] out_3;
	reg [6:0] mux1, mux2;
	reg [31:0] mux3;

	always @(*)
	begin
		if(ENB==1) 
		begin
			if(selector==0) 
			begin
				mux1 = in_1;
				mux2 = in_2;
			end 
			else if (selector==1)
			begin
				mux1 = mux1;
				mux2 = mux2;
			end
			if(selector3==0) 
				begin
				mux3=in_3;
				end 
			else
			begin
				mux3=mux3;
			end
		end
		else 
			begin
				mux1=mux1;
				mux2=mux2;
				mux3=mux3;
			end
	end
	
	always @(posedge clk) 
		begin
			out_1<=mux1;
			out_2<=mux2;
			out_3<=mux3;
		end

endmodule
