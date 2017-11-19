`include "FIFO.v"
`include "probadorFIFO.v"
`include "FIFO8synt.v"

module testbench;
	wire CLOCK, RESET, PUSH, POP, ALMOST_EMPTY, ALMOST_FULL, EMPTY, FULL;
	wire [3:0] DATO_IN, DATO_OUT;
	wire [3:0] DATO_OUTsynt;
	wire ALMOST_EMPTYsynt, ALMOST_FULLsynt, EMPTYsynt, FULLsynt;
	wire [6:0] TL, TH;
	probadorFIFO probadorff(CLOCK, RESET, PUSH, POP ,DATO_IN, TL, TH);
	FIFO  #(8) ff(CLOCK, RESET, PUSH, POP ,DATO_IN, DATO_OUT, ALMOST_EMPTY, ALMOST_FULL, EMPTY, FULL, TL, TH);
	FIFO8synt ffsynt(CLOCK, RESET, PUSH, POP, DATO_IN, DATO_OUTsynt, ALMOST_EMPTYsynt, ALMOST_FULLsynt, EMPTYsynt, FULLsynt, TL, TH);
endmodule
