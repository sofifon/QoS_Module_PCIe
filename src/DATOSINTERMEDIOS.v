module DATOSINTERMEDIOS(RESET, CLOCK, POPff0, POPff1, POPff2, POPff3, DATO_OUTff0, DATO_OUTff1, DATO_OUTff2, DATO_OUTff3, DATOCF_OUT);
	input RESET, CLOCK;
	input POPff0, POPff1, POPff2, POPff3;
	input [3:0] DATO_OUTff0, DATO_OUTff1, DATO_OUTff2, DATO_OUTff3;
	output reg [3:0] DATOCF_OUT;
	
	always @(posedge CLOCK) begin
		if (RESET) begin
			if (POPff0) begin
				DATOCF_OUT<=DATO_OUTff0;
			end
			if (POPff1) begin
				DATOCF_OUT<=DATO_OUTff1;
			end
			if (POPff2) begin
				DATOCF_OUT<=DATO_OUTff2;
			end
			if (POPff3) begin
				DATOCF_OUT<=DATO_OUTff3;
			end
		end
	end
endmodule