`include "RoundRobin.v"
`include "probador_RoundRobin.v"

module probadorRoundRobintb();

input wire [1:0] SELECT;
input wire [1:0] W;
input wire [31:0] TAB;
input wire CLK, ENB;
output wire [3:0] OUT;

probadorrr prr(SELECT, CLK, TAB, W, ENB);
roundrobin rr(SELECT, CLK, TAB, W, OUT, ENB);


initial 
	begin
	$dumpfile("robin.vcd");
	$dumpvars;
	end

endmodule 
