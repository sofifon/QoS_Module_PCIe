module RoundRobin(sel,clk,table,weight,enb, out);
		input wire [1:0] sel;
		input wire clk;
		input wire enb;
		input wire [1:0] weight;
		input wire [31:0] table;
		output reg [3:0] out;
		reg [1:0] bits;
		reg [3:0] count;
		
		always @(sel)
		begin
			bits=0;
			count=0;
		end 

		always @(posedge clk) begin
			if(ENB==1) begin
				if(sel==2'b00)begin
					case(bits[1:0])
						2'b00:
						begin	
							bits<=2'b01;
							out<=4'b0001;
						end
						2'b01:
						begin	
							bits<=2'b10;
							out<=4'b0010;
						end
						2'b10:
						begin	
							bits<=2'b11;
							out<=4'b0100;
						end
						2'b11:
						begin	
							bits<=2'b00;
							out<=4'b1000;
						end
					endcase
				end 
				else
				if(sel==2'b01)begin
					out<=4'b0000; 
				end 
				else
				if(sel==2'b10)begin
					if(bits==2'b00)begin
						if(weight==0)begin
							bits<=2'b01;
						end
						else
						begin
							out<=4'b0001;
							weight<=weight-1;
						end
					end
					if(bits==2'b01)begin
						if(weight==0)begin
							bits<=2'b10;
						end
						else
						begin
							out<=4'b0010;
							weight<=weight-1;
						end
					end
					if(bits==2'b10)begin
						if(weight==0)begin
							bits<=2'b11;
						end
						else
						begin
							out<=4'b0100;
							weight<=weight-1;
						end
					end
					if(bits==2'b11)begin
						if(weight==0)begin
							bits<=2'b00;
						end
						else
						begin
							out<=4'b1000;
							weight<=weight-1;
						end
					end
				end
				else
				if(sel==2'b11)begin
					out<=0; 
				end
			end
		end
	endmodule
