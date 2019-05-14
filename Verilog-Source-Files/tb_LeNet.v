`timescale 1ns / 1ps
`define TS 10 
`define DELAY `TS*2 
`define RunTime `TS*8798
module tb_LeNet;

reg clk, rst;
wire [31:0]LeNet_Out;
LeNet uut (clk,rst,LeNet_Out);
//always @(LeNet_Out) $display("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d",O0,O1,O2,O3,O4,O5,O6,O7,O8,O9);
initial begin clk=0;forever #(`TS) clk=~clk;end
initial begin rst=1; #(`DELAY) rst=0; #(`RunTime);$finish;end
endmodule