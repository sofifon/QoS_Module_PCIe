module translater(ENB, clk, in_1, in_2, selector1, selector2, out_1, out_2);

	input wire ENB, clk, in_1, in_2, selector1, selector2;
	output wire out_1, out_2;
	wire mux1, mux2;

	always @(*)
	begin
		if(selector1==0) begin
			mux1<=in_1;
		end else
			mux1<=out_1;
		end
		if(selector2==0) begin
			mux2<=in_2;
		end else
			mux2<=out_2;
		end
	end
	
	always @(posedge clk) begin
		if(ENB==1) begin
			out_1=mux1;
			out_2=mux2;
		end
	end

endmodule
