module probadorrr(sel, clk, table, weight, enb);
	output wire [1:0] sel;
	output wire clk, enb;
	output wire [1:0] weight;
  	output wire [31:0] table;

	initial begin
		clk=0;
		enb=0;
		sel=0;
		table=32'b10110001100111100110111110010010;
		weight=0;

		#18 enb=1;

		#100 sel=1;

		#160 sel=2;
		weight=1;
		#20
		#20 weight=3;

		#30 weight=0;
		#30 weight=2;

		#40 sel=3;
		weight=3;
		#30 weight=2;
		#20 weight=0;
		#10 weight=1;

		#10
	  	$finish;
	end
	always begin
        	#10 clk <= ~clk;
      	end
	
endmodule
