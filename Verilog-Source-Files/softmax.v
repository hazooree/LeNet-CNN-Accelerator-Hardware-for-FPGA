`timescale 1ns / 1ps
module softmax#(parameter M=32)(
input [M-1:0]A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,
output O0,O1,O2,O3,O4,O5,O6,O7,O8,O9);
wire [M-1:0]w1,w2,w3,w4,w5,w6,w7,w8,w9;
max2 #(M)m0(A0,A1,w1);
max2 #(M)m1(A2,A3,w2);
max2 #(M)m2(A4,A5,w3);
max2 #(M)m3(A6,A7,w4);
max2 #(M)m4(A8,A9,w5);
max2 #(M)m5(w1,w2,w6);
max2 #(M)m6(w3,w4,w7);
max2 #(M)m7(w6,w7,w8);
max2 #(M)m8(w8,w5,w9);
assign O0 = w9==A0,
       O1 = w9==A1,
       O2 = w9==A2,
       O3 = w9==A3,
       O4 = w9==A4,
       O5 = w9==A5,
       O6 = w9==A6,
       O7 = w9==A7,
       O8 = w9==A8,
       O9 = w9==A9;
endmodule
