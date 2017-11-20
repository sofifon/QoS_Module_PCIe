module TransactionProb(CLK, Reset, Push_fifos, VC_ID, DataWord, Th_L, Th_H, Selector, Matrix, Weight, Pop_CF, Pop_buffer, Set_init, Idle, Pause_stb, Continue_stb, Error_full);

input Idle;
input [3:0]  Pause_stb, Continue_stb, Error_full;

output reg CLK, Reset, Set_init, Pop_buffer, Pop_CF, Push_fifos;
output reg [1:0] VC_ID, Weight, Selector;
output reg [3:0] DataWord;
output reg [6:0] Th_L, Th_H;
output reg [31:0] Matrix;

reg transmitter;

initial
	begin
	$dumpfile("Transmitter.vcd");
	$dumpvars;
	VC_ID <= 2'b00;
	DataWord <= 4'b1010;
	Pop_CF <=0;
	Pop_buffer<=0;
	CLK <= 0;
	Reset <= 0;
	Set_init <=1;
	Th_H <= 7'd75;
	Th_L <= 7'd25;
	Matrix <= 32'b10110001100111100110111110010010;;
	Selector <= 2'b01;
	Weight <= 2'b00;
	#30
	Reset <= 1;
	#10
	Set_init <= 0;
	#30
	transmitter <= 0;
	Push_fifos <= 1;
	VC_ID <= 2'b00;
	DataWord <= 4'd0; 
	#20
	VC_ID <= 2'b00;
	DataWord <= 4'd1; 
	#20
	VC_ID <= 2'b00;
	DataWord <= 4'd2; 
	#20
	VC_ID <= 2'b01;
	DataWord <= 4'd3; 
	#20
	VC_ID <= 2'b01;
	DataWord <= 4'd4;
	#20
	VC_ID <= 2'b10;
	DataWord <= 4'd5; 
	#20
	VC_ID <= 2'b10;
	DataWord <= 4'd6;
	#20
	VC_ID <= 2'b11;
	DataWord <= 4'd7;
	#20
	VC_ID <= 2'b10;
	DataWord <= 4'd8;
	#20
	VC_ID <= 2'b01;
	DataWord <= 4'd9;
	#20
	VC_ID <= 2'b11;
	DataWord <= 4'd10;
	#20
	VC_ID <= 2'b11;
	DataWord <= 4'd11;
	#20
	VC_ID <= 2'b11;
	DataWord <= 4'd12;
	#20 
	@(posedge CLk);
	VC_ID <= 2'b00;
	DataWord <= 4'd13;
	#20
	VC_ID <= 2'b00;
	DataWord <= 4'd14;
	Pop_CF <=1;
	#20
	VC_ID <= 2'b01;
	DataWord <= 4'd15;
	#20
	VC_ID <= 2'b10;
	DataWord <= 4'd12;
	#20
	VC_ID <= 2'b10;
	DataWord <= 4'd13;
	#20
	VC_ID <= 2'b11;
	DataWord <= 4'd15;
	#20
	VC_ID <= 2'b01;
	DataWord <= 4'd11;
	#20 transmitter <= 1;
	Pop_buffer <= 1;
	#20
	Pop_buffer <= 0;
	#20
	Pop_buffer <= 1;
	#20
	Pop_buffer <= 0;
	#40
	Pop_buffer <= 1;
	#20
	Pop_buffer <= 0;
	#10
	// Pop_buffer <= 1;
	// #40
	// Pop_buffer <= 0;
	// #30
	// Pop_buffer <= 1;
	// #40
	// Pop_buffer <= 0;
	// #30
	$finish;
	end
	
always 
	begin
		#10 CLK <= ~CLK;
	end
	
// always @(Set_init)
	// begin
	// if(!Set_init)
		// begin
			// Push_fifos <= 1;
			// VC_ID <= 2'd3;
			// transmitter <= 1;
			// DataWord <=  4'b1001;  
		// end
	// end

always @(posedge CLK) begin
	if(transmitter)
		begin
		if (DataWord >= 4'b1111) begin
			DataWord <= 4'b0000;
		end
		else begin
			DataWord <= DataWord + 3 ;
		end
		if(|Continue_stb)
			begin
			if(Continue_stb[0]==1)
				begin
				VC_ID <= 0;
				end
			else if(Continue_stb[1]==1)
				begin
				VC_ID <= 1;
				end
			else if(Continue_stb[2]==1)
				begin
				VC_ID <= 2;
				end
			else if(Continue_stb[3]==1)
				begin
				VC_ID <= 3;
				end
			end
		else
			begin
				if (VC_ID>=2'b11) begin
					VC_ID <= 2'b00;
				end
				else begin
					VC_ID <= VC_ID + 1 ;
				end
				if (Pause_stb[VC_ID] ==1)
					begin
						Push_fifos <= 0;
					end
				else
					begin
						Push_fifos <= 1;
					end
			end
		end
	end		


endmodule