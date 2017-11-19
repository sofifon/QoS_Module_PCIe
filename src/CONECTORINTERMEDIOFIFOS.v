module CONECTORINTERMEDIOFIFOS ( POPDATOCF, ID, CFPOP0, CFPOP1, CFPOP2, CFPOP3, CFDATOFIFO0, CFDATOFIFO1, CFDATOFIFO2, CFDATOFIFO3, CFDATOFIFOP, PUSHDATOFIFOPRINCIPAL);
	input POPDATOCF;
	input [1:0] ID;
	input [3:0] CFDATOFIFO0, CFDATOFIFO1, CFDATOFIFO2, CFDATOFIFO3;
	output reg CFPOP0, CFPOP1, CFPOP2, CFPOP3, PUSHDATOFIFOPRINCIPAL;
	output reg [3:0] CFDATOFIFOP;
 
	always @(*) begin
		if (POPDATOCF) begin
			if ( ID == 2'b00) begin
				CFPOP0 <= 1'b1;
				CFPOP1 <= 1'b0;
				CFPOP2 <= 1'b0;
				CFPOP3 <= 1'b0;
				CFDATOFIFOP <= CFDATOFIFO0;
			end
			else if ( ID == 2'b01) begin
				CFPOP0 <= 1'b0;
				CFPOP1 <= 1'b1;
				CFPOP2 <= 1'b0;
				CFPOP3 <= 1'b0;
				CFDATOFIFOP <= CFDATOFIFO1;
			end
			else if ( ID == 2'b10) begin
				CFPOP0 <= 1'b0;
				CFPOP1 <= 1'b0;
				CFPOP2 <= 1'b1;
				CFPOP3 <= 1'b0;
				CFDATOFIFOP <= CFDATOFIFO2;
			end
			else if ( ID == 2'b11) begin
				CFPOP0 <= 1'b0;
				CFPOP1 <= 1'b0;
				CFPOP2 <= 1'b0;
				CFPOP3 <= 1'b1;
				CFDATOFIFOP <= CFDATOFIFO3;
			end
		end
		PUSHDATOFIFOPRINCIPAL = POPDATOCF;
	end
endmodule