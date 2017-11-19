module translater(ENB, clk, in_1, in_2, selector1, selector2, out_1, out_2);

	input wire ENB, clk, in_1, in_2, selector1, selector2;
	output reg out_1, out_2;
	reg mux1, mux2;

	always @(*)
	begin
		if(ENB==1) 
		begin
			if(selector1==0) 
			begin
				mux1 = in_1;
			end 
			else if (selector1==1)
			begin
				mux1 = mux1;
			end
			if(selector2==0) 
				begin
				mux2 =in_2;
				end 
			else
			begin
				mux2 = mux2;
			end
		end
		else 
			begin
				mux1=in_1;
				mux2 = mux2;
			end
	end
	
	always @(posedge clk) 
		begin
			out_1<=mux1;
			out_2<=mux2;
		end

endmodule
