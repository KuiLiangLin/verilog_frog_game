module frogg(clk, rst, go, back, frog, reset);
input wire reset, clk, go, rst, back;
output reg [18:0]frog;

parameter s0=5'd0  ,s1=5'd1  ,s2=5'd2  ,s3=5'd3  ,s12=5'd12;
parameter s4=5'd4  ,s5=5'd5  ,s6=5'd6  ,s7=5'd7  ,s13=5'd13;
parameter s8=5'd8  ,s9=5'd9  ,s10=5'd10,s17=5'd17,s11=5'd11;
parameter s14=5'd14,s15=5'd15,s16=5'd16,s18=5'd18;

reg [4:0]state;
wire go_debounce, back_debounce, reset_posi_debounce;

//low active
debounce_low_act debounce_go(.rst(rst), .clk(clk), .in(go), .out(go_debounce));
debounce_low_act debounce_back(.rst(rst), .clk(clk), .in(back), .out(back_debounce));
debounce_high_act debounce_reset(.rst(rst), .clk(clk), .in(reset), .out(reset_posi_debounce));

always@(posedge clk, posedge rst)
begin
	if(rst)
		state <= 5'b00000;
	else if (reset_posi_debounce)
		state <= 5'b00000;
	else if (!go_debounce)
		state <= state+5'b00001;
	else if (!back_debounce)
		state <= state-5'b00001;
	else 
		state <= state;
end

always@(posedge clk, posedge rst)
begin
	case(state)//the saturation of the frog 
		s0: frog <= 19'b0000000000000000001;
		s1: frog <= 19'b0000000000000000010;
		s2: frog <= 19'b0000000000000000100;
		s3: frog <= 19'b0000000000000001000;
		s4: frog <= 19'b0000000000000010000;
		s5: frog <= 19'b0000000000000100000;
		s6: frog <= 19'b0000000000001000000;
		s7: frog <= 19'b0000000000010000000;
		s8: frog <= 19'b0000000000100000000;
		s9: frog <= 19'b0000000001000000000;
		s10:frog <= 19'b0000000010000000000;
		s11:frog <= 19'b0000000100000000000;
		s12:frog <= 19'b0000001000000000000;
		s13:frog <= 19'b0000010000000000000;
		s14:frog <= 19'b0000100000000000000;
		s15:frog <= 19'b0001000000000000000;
		s16:frog <= 19'b0010000000000000000;
		s17:frog <= 19'b0100000000000000000;
		s18:frog <= 19'b1000000000000000000;
	endcase
end
//endmodule
endmodule
