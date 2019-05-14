`timescale 1ns / 1ps
// Array of Processing Elements for Row of Filter
module PE_Array #(parameter M=32,N=0)(
// Declaration Block
input clk,rst,
[M-1:0]Wi0,Wi1,Wi2,Wi3,Wi4,
       Ii0,Ii1,Ii2,Ii3,Ii4,
       Pi,
output [M-1:0]Po,IoO,Io1,Io2,Io3,Io4);
wire [M-1:0] P0, P1, P2, P3;
// Assigning PE I/Os
PE #(M,N)PE0(rst,clk,Wi0,Ii0,Pi,P0,IoO);
PE #(M,N)PE1(rst,clk,Wi1,Ii1,P0,P1,Io1);
PE #(M,N)PE2(rst,clk,Wi2,Ii2,P1,P2,Io2);
PE #(M,N)PE3(rst,clk,Wi3,Ii3,P2,P3,Io3);
PE #(M,N)PE4(rst,clk,Wi4,Ii4,P3,Po,Io4);
endmodule
