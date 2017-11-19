module translater_p(ENB, clk, in_1, in_2, selector1, selector2);
	output wire clk, ENB, in_1, in_2, selector1, selector2;

	initial begin
		clk=0;
		ENB=0;
		selector1=0;
		selector2=0;
		in_1=1;
		in_2=0;

		#18 ENB=1;

		#30 in_1=0;
		#20 in_1=0;
		
		#20 selector2=1;
		selector1=1;

		#20 selector2=0;
		selector1=0;

		
		#10
	  	$finish;
	end
	always begin
        	#10 clk <= ~clk;
      	end
	
endmodule
