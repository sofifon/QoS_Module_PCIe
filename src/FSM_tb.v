`include "FSM.v"
`include "FSMsynt.v"
`include "probFSM.v"
module FSM_tb();

wire CLK, reset, set_init, init, idle;
wire [3:0] Pause, Continue, pause_stb, continue_stb, pause_stb_synt, continue_stb_synt, empty, full, error_full, error_full_synt; 

probFSM prob(CLK, reset, set_init, empty, full, Pause, Continue);

FSMsynt synt(CLK, reset, set_init, empty, full, Pause, Continue, init_synt, idle_synt, pause_stb_synt, continue_stb_synt, error_full_synt);

FSM fsm(CLK, reset, set_init, empty, full, Pause, Continue, init, idle, pause_stb, continue_stb, error_full);

endmodule