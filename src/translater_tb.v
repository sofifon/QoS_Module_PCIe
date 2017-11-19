`include "translater.v"
`include "translater_p.v"

module translater_tb();

wire ENB, clk, selector, selector3;
wire [6:0] in_1, in_2;
wire [31:0] in_3;
wire [6:0] out_1, out_2;
wire [31:0] out_3;

translater_p transp(ENB, clk, in_1, in_2, in_3, selector, selector3);
translater trans(ENB, clk, in_1, in_2, in_3, selector, selector3, out_1, out_2, out_3);


initial 
	begin
	$dumpfile("translate.vcd");
	$dumpvars;
	end

endmodule 
