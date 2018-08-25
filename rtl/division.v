/*module division (oclk, clk);//1 second
input clk;
output oclk;
reg oclk;
integer i;//a parameter								
always @ (negedge clk)
	if (i<=25000000)//1st 0.5 period 						
		begin
		i=i+1;
		oclk=oclk;//original
		end
	else if(i==25000001)//2nd 0.5 period 					
		begin
		oclk=~oclk;//change
		i=0;//reset parameter 
		end
endmodule
*/
module division (oclk, clk, rst);//1 second
input clk, rst;
output oclk;
reg oclk;

reg [24:0]counter;

always @ (posedge clk, posedge rst)
begin
	if (rst)
		counter <= 25'd0;
	else if (counter == 25'd250)
		counter <= 25'd0;
	else
		counter <= counter + 25'd1;
end

always@ (posedge clk, posedge rst)
begin
	if(rst)
		oclk <= 1'd0;
	else if (counter == 25'd249)
		oclk <= ~oclk;
	else
		oclk <= oclk;
end


endmodule
