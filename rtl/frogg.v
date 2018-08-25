module frogg(clk,rst,go,back,frog,reset);
input reset,clk,go,rst,back;
output reg [18:0]frog;
parameter s0=5'd0,s1=5'd1,s2=5'd2,s3=5'd3,s12=5'd12;
parameter s4=5'd4,s5=5'd5,s6=5'd6,s7=5'd7,s13=5'd13;
parameter s8=5'd8,s9=5'd9,s10=5'd10,s17=5'd17,s11=5'd11;
parameter s14=5'd14,s15=5'd15,s16=5'd16,s18=5'd18;
reg [4:0]state;
integer i;//a parameter	
always@(posedge clk)
begin
if(rst==1'b1||reset==1'b1)
	state=5'b00000;//initialize
if(go==1'b0&&i==1)
	begin//when go_bottom run
	state=state+5'b00001;
	i=2;//prevent repeat actions
	end
if(back==1'b0&&i==1)
	begin//when back_bottom run
	state=state-5'b00001;
	i=2;//prevent repeat actions
	end
if(back==1'b1&&go==1'b1)
	i=1;//the next bottom is available
case(state)//the saturation of the frog 
	s0: frog=19'b0000000000000000001;
	s1: frog=19'b0000000000000000010;
	s2: frog=19'b0000000000000000100;
	s3: frog=19'b0000000000000001000;
	s4: frog=19'b0000000000000010000;
	s5: frog=19'b0000000000000100000;
	s6: frog=19'b0000000000001000000;
	s7: frog=19'b0000000000010000000;
	s8: frog=19'b0000000000100000000;
	s9: frog=19'b0000000001000000000;
	s10:frog=19'b0000000010000000000;
	s11:frog=19'b0000000100000000000;
	s12:frog=19'b0000001000000000000;
	s13:frog=19'b0000010000000000000;
	s14:frog=19'b0000100000000000000;
	s15:frog=19'b0001000000000000000;
	s16:frog=19'b0010000000000000000;
	s17:frog=19'b0100000000000000000;
	s18:frog=19'b1000000000000000000;
endcase
end
endmodule
