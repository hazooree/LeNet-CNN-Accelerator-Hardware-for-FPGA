`timescale 1ns / 1ps
// Processing Element
module PE #(parameter M=32,N=0)(
// Declaration Block
input rst,clk,
[M-1:0]W,Ii,Pi,
output reg[M-1:0]Po,Io);
wire [M-1:0]P;
// Calculation Block
Multiplication #(M,N) mult(Ii,W,P);
always@(posedge clk)
if(!rst)
begin 
   Io <= Ii;
   Po <= Pi+P;
end
endmodule
