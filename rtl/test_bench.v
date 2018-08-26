`timescale 1ns/1ps
`define CYCLE 100
module test_bench ();

//**************************** wire & reg**********************//
initial begin
    $display("//***************************************");
    $display("//==top input : clk, go_1, go_2, back_1, back_2, rst");
    $display("//==top output : outview, light_1, light_2");
    $display("//***************************************");
end
reg clk,go_1,go_2,back_1,back_2,rst;
wire [17:0]outview;
wire [3:0]light_1,light_2;

//**************************** module **********************//
initial begin
    $display("===module : add");
end
ex1 ex1(.clk(clk),
		.rst(rst),
		.go_1(go_1),
		.go_2(go_2),
		.back_1(back_1),
		.back_2(back_2),
		.outview(outview),
		.light_1(light_1),
		.light_2(light_2)
);

//**************************** clock gen **********************//
initial begin
	$display("===starting generating clk");
	force clk = 1'b0;
	forever #(`CYCLE/2) force clk = ~clk;
end

//**************************** initial and wavegen **********************//
initial begin
	$display("===starting dump waveform");
	$dumpfile("dump.vcd");
	$dumpvars(0,ex1);
end

initial begin
    go_1 = 1;
    go_2 = 1;
	back_1 = 1;
	back_2 = 1;	
end

//**************************** main **********************//
//reg [13:0]index_2;
integer index_2;
initial begin

	RESET;
	#1_000_000;
	for(index_2 = 1; index_2 <= 17; index_2 = index_2 + 2) begin 
        //#1000;
        //$display("send : 0x%h, 0x%h" , index_2, index_2 + 14'd1);
		$display("%d", index_2);
		wait(ex1.block[index_2] == 0) begin 
			force go_1 = 0; 
			#(`CYCLE*24); 
			force go_1 = 1; 
			#(`CYCLE*24);
			force go_1 = 0; 
			#(`CYCLE*24); 
			force go_1 = 1; 
			#11_000_000;
		end
    end

	$display("===all done");
	#10_000_000; $finish;
end


task RESET;
begin
	force rst = 1'b0;
	#1_000;
	force rst = 1'b1;
	#1_000;
	force rst = 1'b0;
	#1_000;
end
endtask

//endmodule
endmodule