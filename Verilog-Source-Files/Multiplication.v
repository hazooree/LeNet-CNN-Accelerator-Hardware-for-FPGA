`timescale 1ns / 1ps
// Signed Multiplication
module Multiplication #(parameter M=32,N = 0)(
// Declaration Block
input [M-1:0]I1,I2,
output [M-1:0]O);
// Calculation Block
wire [M-1:0]Ia,Ib;
wire [2*M-1:0]R;
assign Ia=(I1[M-1])?~I1+1:I1,
       Ib=(I2[M-1])?~I2+1:I2,
       R=Ia*Ib,
       O=(I1[M-1]==I2[M-1])?R[M+N-1:N]:~R[M+N-1:N]+1;
endmodule