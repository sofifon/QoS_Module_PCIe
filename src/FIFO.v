module FIFO (CLOCK, RESET, PUSH, POP ,DATO_IN, DATO_OUT, ALMOST_EMPTY, ALMOST_FULL, EMPTY, FULL, TL, TH);
	parameter
		Ext = 0;
	
	input CLOCK, RESET, PUSH, POP;
	input [3:0] DATO_IN;
	input [6:0] TL, TH;
	output reg [3:0] DATO_OUT;
	output reg ALMOST_EMPTY, ALMOST_FULL, EMPTY, FULL;
	reg [3:0] arreglomemoria [0:Ext];
	reg [0:Ext] memwrite, memread, contadordatos, calmostempty, calmostfull;
	
	always @(posedge CLOCK) begin
		if ( RESET ) begin
			if ( PUSH && (contadordatos!=Ext) ) begin
				if (memwrite < Ext) begin
					arreglomemoria[memwrite] <= DATO_IN ;
					memwrite <= memwrite + 1'b1 ;
					if (!POP) begin
						contadordatos <= contadordatos + 1'b1 ;
					end
					DATO_OUT <= 4'bzzzz;
					if ( memwrite == Ext ) begin
						memwrite <= 1'b0;
					end
					if ( contadordatos==(Ext) || (contadordatos>calmostfull) ) begin
						EMPTY <= 1'b0;
						ALMOST_EMPTY <= 1'b0;
						ALMOST_FULL <= 1'b0;
						FULL <= 1'b1;
					end
					else if ( (contadordatos>=(calmostfull-1)) && (contadordatos<(Ext-1)) ) begin
						EMPTY <= 1'b0;
						ALMOST_EMPTY <= 1'b0;
						ALMOST_FULL <= 1'b1;
						FULL <= 1'b0;
					end
					else if ( (contadordatos == 1'b0) || (contadordatos<calmostempty) ) begin
						EMPTY <= 1'b0;
						ALMOST_EMPTY <= 1'b1;
						ALMOST_FULL <= 1'b0;
						FULL <= 1'b0;
					end
					else if ( (contadordatos>=calmostempty) && (contadordatos<=(calmostfull-1)) ) begin
						EMPTY <= 1'b0;
						ALMOST_EMPTY <= 1'b0;
						ALMOST_FULL <= 1'b0;
						FULL <= 1'b0;
					end
				end
			end
			else if ( PUSH ) begin
				DATO_OUT <= 4'bzzzz;
				$display ("ERROR");
				$display ("SE CORROMPIO EL FIFO");
				$display ("FIFO LLENO");
			end
			if ( POP && (contadordatos!=4'b0000) ) begin
				if (memread < Ext)begin
					DATO_OUT <= arreglomemoria[memread];
					memread <= memread + 1'b1;
					if (!PUSH) begin
						contadordatos <= contadordatos - 1'b1 ;
					end
					if ( memread == Ext ) begin
						memread <= 1'b0;
					end
					if ( (contadordatos == 1'b0 ) || (contadordatos<calmostempty) ) begin
						EMPTY <= 1'b1;
						ALMOST_EMPTY <= 1'b0;
						ALMOST_FULL <= 1'b0;
						FULL <= 1'b0;
					end
					else if ( (contadordatos>1'b0) && ( contadordatos <= (calmostempty+1) ) ) begin
						EMPTY <= 1'b0;
						ALMOST_EMPTY <= 1'b1;
						ALMOST_FULL <= 1'b0;
						FULL <= 1'b0;
					end
					else if ( (contadordatos>=calmostempty) && (contadordatos<(calmostfull+1)) ) begin
						EMPTY <= 1'b0;
						ALMOST_EMPTY <= 1'b0;
						ALMOST_FULL <= 1'b0;
						FULL <= 1'b0;
					end
					else if ( (contadordatos>=(calmostfull-1)) || (contadordatos==Ext) ) begin 
						EMPTY <= 1'b0;
						ALMOST_EMPTY <= 1'b0;
						ALMOST_FULL <= 1'b1;
						FULL <= 1'b0;
					end
								
				end
			end
			else if ( POP ) begin
				DATO_OUT <= 4'bzzzz;
				$display ("ERROR");
				$display ("SE CORROMPIO EL FIFO");
				$display ("FIFO VACIO");
			end
		end
		
		

		
		else begin
			memread <= 1'b0;
			memwrite <= 1'b0;
			DATO_OUT <= 4'bzzzz;
			ALMOST_EMPTY <= 1'b0;
			ALMOST_FULL <= 1'b0;
			EMPTY <= 1'b1;
			FULL <= 1'b0;
			contadordatos <= 1'b0;
			calmostempty <= ((Ext*TL)/100);
			calmostfull <= ((Ext*TH)/100);
		end
	end
	
	
endmodule	
