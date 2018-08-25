/*module random(rst,clk,random_out);
input clk, rst;
output reg [13:0]random_out;
integer i;//a parameter		
always@(negedge clk)
begin
i=i+1;//random data precent times
if(rst==1'b1)
	random_out=14'd4;//original datas
else if(random_out<14'd3000)
	random_out=random_out/3+random_out;
	//generate equation of random datas
else if(random_out>14'd3000)
	random_out=i;
	//prevent random datas from largger
if(i>500)
i=1;//prevent times from largger
end
endmodule
*/
module random(rst,clk,random_out);
input clk, rst;
output reg [13:0]random_out;

reg [5:0] counter;
wire [5:0] temp = {counter[0], counter[5], counter[1], counter[4], counter[2], counter[3]};
wire [5:0] temp_1 = {counter[1], counter[4], counter[2], counter[3], counter[0], counter[5]};

always@(posedge clk, posedge rst)
begin

if(rst)
	random_out <= 14'd0;//original datas
else if (counter == 6'd32)
	random_out <= {random_out[13:0], counter[0]};
else 
	random_out <= {counter[0], counter[5],temp, temp_1} + random_out;

end

always@(posedge clk, posedge rst)
begin
	if(rst) 
		counter <= 6'd0;
	else 
		counter <= counter + 6'd3;
end
//endmodule
endmodule
