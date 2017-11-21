#Makefile Proyecto2
#Laura Rincon B55863
#Emanuel Fernandez
#Sofia Fonseca B42634

	
###########Comandos generales################################
	
fifo:
	iverilog -o fifo testbenchFIFO.v
	vvp fifo
	gtkwave probadorFIFO.vcd

robin:
	iverilog -o robin RoundRobin_tb.v
	vvp robin
	gtkwave robin.vcd

translater:
	iverilog -o translate translater_tb.v
	vvp translate
	gtkwave translate.vcd

fsm:
	iverilog -o fsm FSM_tb.v
	vvp fsm
	gtkwave FSM_synt.vcd

make:
	iverilog -o module TESTBENCHTRANSACTIONLL.v
	vvp module
	gtkwave Transmitter.vcd

run: 
	vvp module
	
look:
	gtkwave Transmitter.vcd

clean: 
	rm -f -R *.o *.vcd fifo robin fsm module translate
