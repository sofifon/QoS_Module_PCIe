module probFSM(CLK, reset, set_init, empty, full, Pause, Continue);

output reg CLK, reset, set_init;
output reg [3:0] Pause, Continue, empty, full;

initial
	begin
	CLK <= 0;
	end

initial
	begin
	$dumpfile("FSM_synt.vcd");
	$dumpvars;
	
	
	reset <= 0;
	set_init <= 1;
	empty <= 4'd0;
	full <= 4'd0;
	Pause <= 4'd0;
	Continue <= 4'd0;
	#14
	//@(posedge CLK)
	reset <= 1;
	#10
	//@(posedge CLK)
	set_init <= 0;
	#10
	//@(posedge CLK)
	empty <= 4'd15;
	#20
	//@(posedge CLK)
	empty <= 4'd0;
	#20
	//@(posedge CLK)
	Pause <= 4'b0110;
	#20
	//@(posedge CLK)
	Pause <= 4'd0;
	#20
	//@(posedge CLK)
	Pause <= 4'b0110;
	Continue <= 4'b0100;
	#20
	//@(posedge CLK)
	Pause <= 4'd0;
	Continue <= 4'b1010;
	#20
	//@(posedge CLK)
	Continue <= 4'd0;
	#20
	//@(posedge CLK)
	full <= 4'd4;
	#20
	//@(posedge CLK)
	reset <= 1;
	#40
	$finish;
	
	end
	
	always 
		begin
        	#5 CLK <= ~CLK;
      	end

endmodule