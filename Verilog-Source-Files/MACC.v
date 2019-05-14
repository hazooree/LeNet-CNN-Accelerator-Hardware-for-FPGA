`timescale 1ns / 1ps
// Multiplication and Accumulation (MACC) Unit for Fully Connected Layer
module MACC #(parameter M=32,N=0)(
input finish, [M-1:0]W,Ii,Pi,
output [M-1:0]Po);
wire [M-1:0]P;
Multiplication #(M,N) mult(Ii,W,P);
assign Po = (!finish)? Pi+P : Pi;
endmodule
