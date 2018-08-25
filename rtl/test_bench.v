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
    go_1 = 0;
    go_2 = 0;
	back_1 = 0;
	back_2 = 0;	
end

//**************************** main **********************//
reg [13:0]index_2;
initial begin

	RESET;

/*	for(index_2 = 14'd0; index_2 < 14'd4; index_2 = index_2 + 14'd1) begin 
        #1000;
        $display("send : 0x%h, 0x%h" , index_2, index_2 + 14'd1);

        end
*/

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