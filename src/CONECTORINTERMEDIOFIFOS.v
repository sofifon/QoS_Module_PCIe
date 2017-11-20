module CONECTORINTERMEDIOFIFOS ( POPDATOCF, GRAND, CFPOP0, CFPOP1, CFPOP2, CFPOP3, CFDATOFIFO0, CFDATOFIFO1, CFDATOFIFO2, CFDATOFIFO3, CFDATOFIFOP, PUSHDATOFIFOPRINCIPAL);
	input POPDATOCF;
	input [3:0] GRAND;
	input [3:0] CFDATOFIFO0, CFDATOFIFO1, CFDATOFIFO2, CFDATOFIFO3;
	output reg CFPOP0, CFPOP1, CFPOP2, CFPOP3, PUSHDATOFIFOPRINCIPAL;
	output reg [3:0] CFDATOFIFOP;
 
	always @(*) begin
		if (POPDATOCF) begin
			if ( GRAND == 4'b0001) begin
				CFPOP0 <= 1'b1;
				CFPOP1 <= 1'b0;
				CFPOP2 <= 1'b0;
				CFPOP3 <= 1'b0;
				CFDATOFIFOP <= CFDATOFIFO0;
			end
			else if ( GRAND == 4'b0010) begin
				CFPOP0 <= 1'b0;
				CFPOP1 <= 1'b1;
				CFPOP2 <= 1'b0;
				CFPOP3 <= 1'b0;
				CFDATOFIFOP <= CFDATOFIFO1;
			end
			else if ( GRAND == 4'b0100) begin
				CFPOP0 <= 1'b0;
				CFPOP1 <= 1'b0;
				CFPOP2 <= 1'b1;
				CFPOP3 <= 1'b0;
				CFDATOFIFOP <= CFDATOFIFO2;
			end
			else if ( GRAND == 4'b1000) begin
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