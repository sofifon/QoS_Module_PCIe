#Makefile Proyecto2
#Laura Rincon B55863
#Emanuel Fernandez
#Sofia Fonseca B42634

	
###########Comandos generales################################
	
fifo:
	iverilog -o fifo fifo_tb.v
	vvp fifo
	gtkwave fifo.vcd

robin:
	iverilog -o robin probador_RoundRobin_tb.v
	vvp robin
	gtkwave robin.vcd

fsm:
	iverilog -o fsm fsm_tb.v
	vvp fsm
	gtkwave fsm.vcd

flow:
	iverilog -o flow flow_tb.v
	vvp flow
	gtkwave flow.vcd


make:
	iverilog -o module probador_tb.v

run: 
	vvp module
	
look:
	gtkwave module.vcd

clean: 
	rm -f -R *.o *.vcd fifo rr fsm flow module
