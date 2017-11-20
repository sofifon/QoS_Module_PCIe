module FSM(CLK, reset, set_init, empty, full, pause_fifos, continue_fifos, init, idle, pause_stb, continue_stb, error_full);

//Declaracion de variables
input CLK, reset, set_init;
input [3:0] pause_fifos, continue_fifos, empty, full;

output reg init, idle;
output reg [3:0] continue_stb, pause_stb, error_full;
//Variables auxiliares
reg [3:0] state, next_state, pause_signal, continue_signal;

//Declaracion de estados
parameter [2:0] Reset = 3'b000,
				Init  = 3'b001,
				IDLE  = 3'b010,
				Active = 3'b011,
				Pause = 3'b100,
				Continue = 3'b101,
				Pause_Continue = 3'b110,
				Error = 3'b111;
				
//Maquina de Estados

always @(*)
	begin
	next_state = 3'b000;
		case (state)
			Reset:  begin
					if(!reset)
						begin
							next_state = Reset;
						end
					else 
						begin
							next_state = Init;
						end
					end
					
			Init:   begin
					if(set_init)
						begin
							next_state = Init;
						end
					else
						begin
							next_state = IDLE;
						end
					end
					
			IDLE:	begin
					if(&(empty))
						begin
							next_state = IDLE;
						end
					else
						begin
							next_state = Active;
						end

					end
			Active: 
				begin
				if(|pause_fifos && |continue_fifos && pause_fifos!=pause_signal && continue_fifos!=continue_signal)
					begin
						next_state = Pause_Continue;
					end
				else if(|continue_fifos && continue_fifos!=continue_signal)
					begin
						next_state = Continue;
					end
				else if(|pause_fifos && pause_fifos!=pause_signal)
					begin
						next_state = Pause;
					end
				else if(|(full))
					begin
						next_state = Error;
					end	
				else 
					begin
						next_state = Active;
					end
				end

			Pause:
				begin
				if(|pause_fifos && pause_fifos!=pause_signal)
					begin
						next_state = Pause;
					end
				else if(|continue_fifos && continue_fifos!=continue_signal)
					begin
						next_state = Continue;
					end
				else if(|pause_fifos && |continue_fifos && pause_fifos!=pause_signal && continue_fifos!=continue_signal)
					begin
						next_state = Pause_Continue;
					end
				else if(|(full))
					begin
						next_state = Error;
					end
				else 
					begin
						next_state = Active;
					end
				end

			Continue:
				begin
				if(|pause_fifos && pause_fifos!=pause_signal)
					begin
						next_state = Pause;
					end
				else if(|continue_fifos && continue_fifos!=continue_signal)
					begin
						next_state = Continue;
					end
				else if(|pause_fifos && |continue_fifos && pause_fifos!=pause_signal && continue_fifos!=continue_signal)
					begin
						next_state = Pause_Continue;
					end
				else if(|(full))
					begin
						next_state = Error;
					end
				else 
					begin
						next_state = Active;
					end
				end
				
			Pause_Continue:
				begin
				if(|pause_fifos && pause_fifos!=pause_signal)
					begin
						next_state = Pause;
					end
				else if(|continue_fifos && continue_fifos!=continue_signal)
					begin
						next_state = Continue;
					end
				else if(|pause_fifos && |continue_fifos && pause_fifos!=pause_signal && continue_fifos!=continue_signal)
					begin
						next_state = Pause_Continue;
					end
				else if(|(full))
					begin
						next_state = Error;
					end
				else 
					begin
						next_state = Active;
					end
				end
			
			Error:  begin
					if(!reset)
						begin
							next_state = Reset;
						end
					else
						begin
							next_state = Error;
						end
					end
	/* 		default: 
					begin 
						next_state = Reset;
						//next_state = state;
					end */
		endcase	
	end
	
always @(posedge CLK)
	begin
		if(!reset)
			begin
				state <= 3'b000;
				//pause_signal <= 0;
				//continue_signal<= 0; 
			end
		else 
			begin
				state <= next_state;
			end
	end

//Logica para salidas
always @(posedge CLK)
	begin
	if(!reset)
		begin
			init <= 0;
			idle <= 0;
			error_full <= 4'd0;
			continue_stb <= 4'd0;
			pause_stb <= 4'd0;
			pause_signal<=4'd0;
			continue_signal<=4'd0;
		end
	else
		begin
		init <= 0;
		idle <= 0;
		error_full <= 4'd0;
		continue_stb <= 4'd0;
		pause_stb <= 4'd0;
		pause_signal <= pause_fifos;
		continue_signal <= continue_fifos;	
		
			case(next_state)

			Init:
				begin
					idle <= 0;
					error_full <= 4'd0;
					continue_stb <= 4'd0;
					pause_stb <= 4'd0;
					pause_signal <= pause_fifos;
					continue_signal <= continue_fifos;
					if (set_init)
						begin
							init <= 1;
						end
					else
						begin
							init <= 0;
						end
				end
				
			IDLE:
				begin
					error_full <= 4'd0;
					continue_stb <= 4'd0;
					pause_stb <= 4'd0;
					pause_signal <= pause_fifos;
					continue_signal <= continue_fifos;	
					init <= 0;
					if(&(empty))
						begin
							idle <= 1;
						end
					else
						begin
							idle <= 0;
						end
				end
				
			Pause:
				begin
					init <= 0;
					idle <= 0;
					error_full <= 4'd0;
					continue_stb <= 4'd0;
					if (pause_fifos != pause_signal)
						begin
							pause_stb <= pause_fifos;
						end
					else
						begin
							pause_stb <= 4'd0;
						end
					continue_signal <= continue_fifos;
					pause_signal<= pause_fifos;
				end
			
			Continue:
				begin
					init <= 0;
					idle <= 0;
					error_full <= 4'd0;
					pause_stb <= 4'd0;
					if (continue_fifos != continue_signal)
						begin
							continue_stb <= continue_fifos;
						end
					else
						begin
							continue_stb <= 4'd0;
						end
					continue_signal <= continue_fifos;
					pause_signal<= pause_fifos;
				end
			Pause_Continue:
				begin
					init <= 0;
					idle <= 0;
					error_full <= 4'd0;
					if (continue_fifos != continue_signal && pause_fifos!= continue_signal)
						begin
							pause_stb <= pause_fifos;
							continue_stb <= continue_fifos;
						end
					else
						begin
							pause_stb <= 4'd0;
							continue_stb <= 4'd0;
						end
					continue_signal <= continue_fifos;
					pause_signal<= pause_fifos;
				end
			
			Error:  
				begin
					init <= 0;
					idle <= 0;
					continue_stb <= 4'd0;
					pause_stb <= 4'd0;
					pause_signal <= pause_fifos;
					continue_signal <= continue_fifos;
					if(|(full))
						begin
							error_full <= full;
						end 
					else
						begin
							error_full <= 4'd0;
						end
				end
				
	/* 		default: 
				begin
					init <= 0;
					idle <= 0;
					error_full <= 4'd0;
					continue_stb <= 4'd0;
					pause_stb <= 4'd0;
					pause_signal <= pause_fifos;
					continue_signal <= continue_fifos;			
				end */
			
			endcase
		end
	end

endmodule 