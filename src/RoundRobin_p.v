module probadorrr(sel, clk, TABLE, weight, enb);
	output reg [1:0] sel;
	output reg clk, enb;
	output reg [1:0] weight;
  	output reg [31:0] TABLE;

	initial begin
		clk=0;
		enb=0;
		sel=0;
		TABLE=32'b10110001100111100110111110010010;
		weight=0;

		#18 enb=1;

		#100 sel=1;

		#300 sel=2;
		weight=1;
		#20
		#20 weight=3;

		#60 weight=0;
		#30 weight=2;

		#40 sel=3;
		weight=3;
		#100 weight=2;
		#20 weight=0;
		#100 weight=1;

		#10
	  	$finish;
	end
	always begin
        	#10 clk <= ~clk;
      	end
	
endmodule
