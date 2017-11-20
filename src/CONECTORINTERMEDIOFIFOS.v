module CONECTORINTERMEDIOFIFOS ( RESET, CLOCK, POPDATOCF, GRAND, POPff0, POPff1, POPff2, POPff3, /* DATO_OUTff0, DATO_OUTff1, DATO_OUTff2, DATO_OUTff3, CFDATOFIFOP, */ PUSHDATOFIFOPRINCIPAL);
	input POPDATOCF, RESET, CLOCK;
	input [3:0] GRAND;
	/* input [3:0] DATO_OUTff0, DATO_OUTff1, DATO_OUTff2, DATO_OUTff3; */
	output reg POPff0, POPff1, POPff2, POPff3, PUSHDATOFIFOPRINCIPAL;
	// output reg [3:0] CFDATOFIFOP;
 
	always @(*) begin
		if (RESET) begin
			PUSHDATOFIFOPRINCIPAL = POPDATOCF;
			if (POPDATOCF) begin
				if ( GRAND == 4'b0001) begin
					POPff0 = 1'b1;
					POPff1 = 1'b0;
					POPff2 = 1'b0;
					POPff3 = 1'b0;
					// CFDATOFIFOtemp = DATO_OUTff0;
				end
				else if ( GRAND == 4'b0010) begin
					POPff0 = 1'b0;
					POPff1 = 1'b1;
					POPff2 = 1'b0;
					POPff3 = 1'b0;
					// CFDATOFIFOtemp = DATO_OUTff1;
				end
				else if ( GRAND == 4'b0100) begin
					POPff0 = 1'b0;
					POPff1 = 1'b0;
					POPff2 = 1'b1;
					POPff3 = 1'b0;
					/* CFDATOFIFOtemp = DATO_OUTff2; */
				end
				else if ( GRAND == 4'b1000) begin
					POPff0 = 1'b0;
					POPff1 = 1'b0;
					POPff2 = 1'b0;
					POPff3 = 1'b1;
					// CFDATOFIFOtemp = DATO_OUTff3;
				end
			end
		end
		else if (!RESET) begin
			POPff0 = 1'b0;
			POPff1 = 1'b0;
			POPff2 = 1'b0;
			POPff3 = 1'b0;
		end
	end
	

	// always @(posedge CLOCK) begin
		// if (RESET && ((POPff0 == 'b1) || (POPff1 == 'b1) || (POPff2 == 'b1) || (POPff3 == 'b1)) ) begin
			// if (POPff0==1'b1) begin
				// CFDATOFIFOP <= DATO_OUTff0;
			// end
			// if (POPff1==1'b1) begin
				// CFDATOFIFOP <= DATO_OUTff1;
			// end
			// if (POPff2==1'b1) begin
				// CFDATOFIFOP <= DATO_OUTff2;
			// end
			// if (POPff3==1'b1) begin
				// CFDATOFIFOP <= DATO_OUTff3;
			// end
			// PUSHDATOFIFOPRINCIPAL <= POPDATOCF;
		// end
	// end
	
endmodule