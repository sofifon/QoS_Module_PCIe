module translater_p(ENB, clk, in_1, in_2, in_3, selector, selector3);
	output reg clk, ENB, selector, selector3;
	output reg [6:0] in_1, in_2;	
	output reg [31:0] in_3;	

	initial 
	begin
		clk=0;
		ENB=0;
		selector=0;
		selector3=0;
		in_1=1;
		in_2=0;
		in_3=0;

		#18 ENB=1;

		#30 in_1=0;
		#20 in_1=7'd75;
		in_2=7'd25;

		#50 selector=1;

		#60 selector=0;
		in_3=32'b10000111100011100101101011011110;

		
		
		#60
	  	$finish;
	end
	always begin
        	#10 clk <= ~clk;
      	end
	
endmodule
