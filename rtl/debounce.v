//module debounce_low_act
module debounce_low_act(rst, clk, in, out);
input wire clk, rst, in;
output reg out;

reg [5:0] counter;

always@(posedge clk, posedge rst)
begin
	if(rst)
		out <= 1'd1;
	else if (counter == 6'd63)
		out <= 1'd0; // low active
	else 
		out <= 1'd1;

end

always@(posedge clk, posedge rst)
begin
	if(rst) 
		counter <= 6'd0;
	else if(in == 1)
		counter <= 6'd0;
	else if (counter == 6'd63)
		counter <= counter;
	else  // low active
		counter <= counter + 6'd1;
end
//endmodule
endmodule

//module debounce_high_act
module debounce_high_act(rst, clk, in, out);
input wire clk, rst, in;
output reg out;

reg [5:0] counter;

always@(posedge clk, posedge rst)
begin
	if(rst)
		out <= 1'd0;
	else if (counter == 6'd63)
		out <= 1'd1; 
	else 
		out <= 1'd0;

end

always@(posedge clk, posedge rst)
begin
	if(rst) 
		counter <= 6'd0;
	else if(in == 1)
		counter <= 6'd0;
	else if (counter == 6'd63)
		counter <= counter;
	else  
		counter <= counter + 6'd1;
end
//endmodule
endmodule