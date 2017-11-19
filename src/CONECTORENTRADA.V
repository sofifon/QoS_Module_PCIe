module CONECTORENTRADA( PUSHDATOENTRADA, ID, CFPUSH0, CFPUSH1, CFPUSH2, CFPUSH3);	
	input PUSHDATOENTRADA;
	input [1:0] ID;
	output reg CFPUSH0, CFPUSH1, CFPUSH2, CFPUSH3;
	
	always @(*) begin
		if (PUSHDATOENTRADA) begin
			if ( ID == 2'b00) begin
				CFPUSH0<=1'b1;
				CFPUSH1<=1'b0;
				CFPUSH2<=1'b0;
				CFPUSH3<=1'b0;
			end
			else if ( ID == 2'b01) begin
				CFPUSH0<=1'b0;
				CFPUSH1<=1'b1;
				CFPUSH2<=1'b0;
				CFPUSH3<=1'b0;
			end
			else if ( ID == 2'b10) begin
				CFPUSH0<=1'b0;
				CFPUSH1<=1'b0;
				CFPUSH2<=1'b1;
				CFPUSH3<=1'b0;
			end
			else if ( ID == 2'b11) begin
				CFPUSH0<=1'b0;
				CFPUSH1<=1'b0;
				CFPUSH2<=1'b0;
				CFPUSH3<=1'b1;
			end
		end
	end	
endmodule 