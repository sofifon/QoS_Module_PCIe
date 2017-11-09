module probadorrr(sel, clk, table, weight, enb, out);
	output wire [1:0] sel;
	output wire clk, enb;
	output wire [1:0] weight;
  	output wire [31:0] table;
	output wire [3:0] out;

	initial begin
		clk=0;
		enb=0;
		sel=0;
		table=32'b10110001100111100110111110010010;
		3412324323443213
		weight=0;

		#18 enb=1;
		#10 out=4'b0001;
		#10 out=4'b0010;
		#10 out=4'b0100;
		#10 out=4'b1000;
		#10 out=4'b0001;
		#10 out=4'b0010;
		#10 out=4'b0100;
		#10 out=4'b1000;
		#10 out=4'b0001;
		#10 out=4'b0010;
		#10 sel=1;
		#10 out=4'b0100;
		#10 out=4'b0001;
		#10 out=4'b0010;
		#10 out=4'b0100;
		#10 out=4'b1000;
		#10 out=4'b1000;
		#10 out=4'b0100;
		#10 out=4'b0010;
		#10 out=4'b0100;
		#10 out=4'b1000;
		#10 out=4'b0010;
		#10 out=4'b0100;
		#10 out=4'b0010;
		#10 out=4'b0001;
		#10 out=4'b1000;
		#10 out=4'b0100;
		#10 sel=2;
		weight=1;
		#10 out=4'b0001;
		#20 weight=3;
		out=4'b0010;
		#30 weight=0;
		out=4'b0100;
		#30 weight=2;
		out=4'b1000;

		#40 sel=3;
		weight=3;
		out=4'b0100;
		#30 weight=2;
		out=4'b0001;
		#20 weight=0;
		out=4'b0000;
		#10 weight=1;
		out=4'b0100;

		#10
	  	$finish;
	end
	always begin
        	#10 clk <= ~clk;
      	end
	
endmodule
