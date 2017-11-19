`include "translater.v"
`include "translater_p.v"

module translater_tb();

wire ENB, clk, in_1, in_2, selector1, selector2;
wire out_1, out_2;

translater_p transp(ENB, clk, in_1, in_2, selector1, selector2);
translater trans(ENB, clk, in_1, in_2, selector1, selector2, out_1, out_2);


initial 
	begin
	$dumpfile("translate.vcd");
	$dumpvars;
	end

endmodule 
