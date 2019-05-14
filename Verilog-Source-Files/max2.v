`timescale 1ns / 1ps
// Finiding Maximum of Two Munbers
module max2#(parameter M=32)(
input [M-1:0]in1,in2, 
output [M-1:0]out);
assign out = (in1[M-1]==in2[M-1])?(in1>in2?in1:in2):(in1[M-1]?in2:in1);
endmodule