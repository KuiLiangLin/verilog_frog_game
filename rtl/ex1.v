module ex1(clk, rst, go_1, go_2, back_1, back_2,
			outview, light_1, light_2);
input wire clk, go_1, go_2, back_1, back_2, rst;
output wire [17:0]outview;//real output
output reg [3:0]light_1,light_2;

wire [18:0]frog_1, frog_2, block;
wire [18:0]byoutview;//common lights
wire [18:0]die_1,die_2;
wire [13:0]random_out;
wire oclk;
reg reset_1,reset_2;//let the frog saturation back to original

division division(oclk, clk, rst);//divided freq. to 1 second
frogg frogg_1(clk,rst,go_1,back_1,frog_1,reset_1);
frogg frogg_2(clk,rst,go_2,back_2,frog_2,reset_2);
random random(rst,oclk,random_out);//random 0.5 second

assign block = {1'b0,random_out[3],1'b0,random_out[7],
				1'b0,random_out[1],1'b0,random_out[5],
				1'b0,random_out[4],1'b0,random_out[8],
				1'b0,random_out[2],1'b0,random_out[6],
				1'b0,random_out[0],1'b0};//random block
assign die_1 = frog_1 & block;//whether frog1 bomb into block or not
assign die_2 = frog_2 & block;//whether frog2 bomb into block or not
assign byoutview = frog_1 | block | frog_2 ;//common lights
assign outview = byoutview[17:0];//real output

always@(posedge clk, posedge rst)
begin
	if(rst)
		light_1 <= 4'b0111;
	else if(die_1!=19'd0)//bomb into block
		light_1 <= {1'b0,light_1[3:1]};//decrease a light1
	else if(frog_1==19'b1000000000000000000)
		light_1 <= 4'b1111;//frog1 win
	else 
		light_1 <= light_1;
end

always@(posedge clk, posedge rst)
begin
	if(rst)
		light_2 <= 4'b0111;
	else if(die_1!=19'd0)//bomb into block
		light_2 <= {1'b0,light_2[3:1]};//decrease a light2
	else if(frog_1==19'b1000000000000000000)
		light_2 <= 4'b1111;//frog2 win
	else 
		light_2 <= light_2;
end

always@(posedge clk, posedge rst)
begin
	if(rst)
		reset_1 <= 1'b0;
	else if(die_1!=19'd0)//bomb into block
		reset_1 <= 1'b1;//frog1 back to original
	else
		reset_1 <= 1'b0;//frog1 can go or back
end

always@(posedge clk, posedge rst)
begin
	if(rst)
		reset_2 <= 1'b0;
	else if(die_1!=19'd0)//bomb into block
		reset_2 <= 1'b1;//frog2 back to original
	else
		reset_2 <= 1'b0;//frog2 can go or back
end

//endmodule
endmodule
