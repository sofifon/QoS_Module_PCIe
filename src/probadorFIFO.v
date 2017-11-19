module probadorFIFO(CLOCK, RESET, PUSH, POP ,DATO_IN, TL, TH);
	output reg CLOCK, RESET, PUSH, POP;
	output reg [3:0] DATO_IN;
	output reg [6:0] TL, TH;
	reg [31:0] contador;
	
	initial begin
		$dumpfile("probadorFIFO.vcd");
        $dumpvars;
		CLOCK <= 1'b0;
		RESET <= 1'b0;
		TL <= 7'b0011001;
		TH <= 7'b1001011;
		contador <= 0;
		POP <= 1'b0;
		PUSH <= 1'b0;
		#15 DATO_IN <= 4'b1111; // Espero 1 ciclo de reloj (1)
		RESET <= 1'b1; //Espero 2 ciclos y activo el reset (2)
		#10 PUSH <= 1'b1; //(3)
		#10 DATO_IN <= 4'b0010; //(5)
		#10 DATO_IN <= 4'b0110; //(9)
		#10 DATO_IN <= 4'b0000; //(9)
		#10 DATO_IN <= 4'b0001; //(5)
		#10 DATO_IN <= 4'b1000; //(9)
		#10 DATO_IN <= 4'b1011; //(9)
		#10 DATO_IN <= 4'b1101; //(9)
		#10 PUSH <= 1'b0; //(11)
		#10 POP <= 1'b1; //(12)
		#80 POP <= 1'b0; // se vacia el FIFO
		#20;
			 
		RESET <= 1'b0;
		#20 RESET <= 1'b1;
		#10 POP <= 1'b1;
		#10 POP <= 1'b0;
		#20; 
		
		RESET <= 1'b0;
		DATO_IN <= 1'b1;
		#20 RESET <= 1'b1;
		#10 PUSH <= 1'b1; //
		#95; 
		
		CLOCK <= 1'b0;
		RESET <= 1'b0;
		contador <= 0;
		POP <= 1'b0;
		PUSH <= 1'b0;
		#15 DATO_IN <= 4'b1111; // Espero 1 ciclo de reloj (1)
		RESET <= 1'b1; //Espero 2 ciclos y activo el reset (2)
		#10 PUSH <= 1'b1; //(3)
		#10 DATO_IN <= 4'b0010; //(5)
		#10 DATO_IN <= 4'b0110; //(9)
		#10 DATO_IN <= 4'b0000; //(9)
		#10 DATO_IN <= 4'b0001; //(5)
		POP <= 1'b1; //(12)
		#10 DATO_IN <= 4'b1000; //(9)
		#10 DATO_IN <= 4'b1011; //(9)
		#10 DATO_IN <= 4'b1101; //(9)
		#10 PUSH <= 1'b0; //(11)
		#40 POP <= 1'b0; // se vacia el FIFO
		#20 $finish ;
			
	end
	
	always @(posedge CLOCK) begin
		if (RESET) begin
			contador <= contador + 1;
		end
	end
	
	always begin
		#5 CLOCK=!CLOCK;
	end		
endmodule 