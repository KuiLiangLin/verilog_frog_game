module ex1(clk,rst,go_1,go_2,back_1,back_2,
			outview,light_1,light_2,);
input clk,go_1,go_2,back_1,back_2,rst;
output [17:0]outview;//real output
output reg [3:0]light_1,light_2;
wire [18:0]frog_1,frog_2,block;
wire [18:0]byoutview;//common lights
wire [18:0]die_1,die_2;
wire [13:0] random_out;
wire oclk;
division division(oclk, clk, rst);//divided freq. to 1 second
frogg f1(clk,rst,go_1,back_1,frog_1,reset_1);
frogg f2(clk,rst,go_2,back_2,frog_2,reset_2);
random rr1(rst,oclk,random_out);//random 0.5 second
assign block={1'b0,random_out[3],1'b0,random_out[7],
				1'b0,random_out[1],1'b0,random_out[5],
				1'b0,random_out[4],1'b0,random_out[8],
				1'b0,random_out[2],1'b0,random_out[6],
				1'b0,random_out[0],1'b0};//random block
assign die_1=frog_1&block;//whether frog1 bomb into block or not
assign die_2=frog_2&block;//whether frog2 bomb into block or not
assign byoutview = frog_1 | block | frog_2 ;//common lights
assign outview=byoutview[17:0];//real output
reg reset_1,reset_2;//let the frog saturation back to original
always@(posedge clk, posedge rst)
begin
if(rst==1'b1)
	begin//initialize
	light_1=4'b0111;
	light_2=4'b0111;
	reset_1=1'b0;
	reset_2=1'b0;
	end
if(die_1!=19'd0)
	begin//frog1 bomb into block
	light_1={1'b0,light_1[3:1]};//decrease a light1
	reset_1=1'b1;//frog1 back to original
	end
else if(die_1==19'd0)
	reset_1=1'b0;//frog1 can go or back
if(die_2!=19'd0)
	begin//frog2 bomb into block
	light_2={1'b0,light_2[3:1]};//decrease a light2
	reset_2=1'b1;//frog2 back to original
	end
else if(die_2==19'd0)
	reset_2=1'b0;//frog2 can go or back
if(frog_1==19'b1000000000000000000)
begin
light_1=4'b1111;//frog1 win
light_2=4'b0000;
end
if(frog_2==19'b1000000000000000000)
begin
light_1=4'b0000;
light_2=4'b1111;//frog2 win
end
end
endmodule
