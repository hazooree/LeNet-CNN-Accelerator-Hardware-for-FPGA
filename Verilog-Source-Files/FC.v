`timescale 1ns / 1ps
// Fully Connected Layer
module FC#(parameter M=32,N=0,Ma=16,N_f=12,C=10,S_P_o=4)(
// Declaration Block
input clk,rst,
[M-1:0]W0,W1,W2,W3,W4,W5,W6,W7,W8,W9,
Ii,
output reg [Ma-1:0]FCi,Fi, 
[M-1:0]O0,O1,O2,O3,O4,O5,O6,O7,O8,O9,LeNet_Out, 
reg finish);
wire [M-1:0]Po0,Po1,Po2,Po3,Po4,Po5,Po6,Po7,Po8,Po9;
wire Ps0,Ps1,Ps2,Ps3,Ps4,Ps5,Ps6,Ps7,Ps8,Ps9;
reg [M-1:0]Pi0,Pi1,Pi2,Pi3,Pi4,Pi5,Pi6,Pi7,Pi8,Pi9;
// Index for Columns
always @(posedge clk)
if(rst || FCi<S_P_o*S_P_o && Fi==N_f-1 && ~finish)
   Fi<=0;
else if(FCi<S_P_o*S_P_o && Fi<N_f-1 && ~finish)
   Fi<=Fi+1;
// Index for Rows
always @(posedge clk)
if(rst)
   FCi<=0;
else if(FCi<S_P_o*S_P_o-1 && Fi==N_f-1)
   FCi<=FCi+1;
// FC Finish Block
always @(posedge clk)
if(rst)
   finish<=0;
else if(FCi==S_P_o*S_P_o-1 && Fi==N_f-1)
   finish <= 1;
// Applying Softmax at FC Finish
softmax max(Po0,Po1,Po2,Po3,Po4,Po5,Po6,Po7,Po8,Po9,
            Ps0,Ps1,Ps2,Ps3,Ps4,Ps5,Ps6,Ps7,Ps8,Ps9);
// Assigning Output Values after FC Finish
assign O0=(Po0[M-1])?{16'hffff,Po0[M-1:16]}:{16'h0000,Po0[M-1:16]};
assign O1=(Po1[M-1])?{16'hffff,Po1[M-1:16]}:{16'h0000,Po1[M-1:16]};
assign O2=(Po2[M-1])?{16'hffff,Po2[M-1:16]}:{16'h0000,Po2[M-1:16]};
assign O3=(Po3[M-1])?{16'hffff,Po3[M-1:16]}:{16'h0000,Po3[M-1:16]};
assign O4=(Po4[M-1])?{16'hffff,Po4[M-1:16]}:{16'h0000,Po4[M-1:16]};
assign O5=(Po5[M-1])?{16'hffff,Po5[M-1:16]}:{16'h0000,Po5[M-1:16]};
assign O6=(Po6[M-1])?{16'hffff,Po6[M-1:16]}:{16'h0000,Po6[M-1:16]};
assign O7=(Po7[M-1])?{16'hffff,Po7[M-1:16]}:{16'h0000,Po7[M-1:16]};
assign O8=(Po8[M-1])?{16'hffff,Po8[M-1:16]}:{16'h0000,Po8[M-1:16]};
assign O9=(Po9[M-1])?{16'hffff,Po9[M-1:16]}:{16'h0000,Po9[M-1:16]};
// Assigning Output Digit Value
assign LeNet_Out =(finish)?
                  (0*Ps0+1*Ps1+2*Ps2+3*Ps3+4*Ps4+5*Ps5+6*Ps6+7*Ps7+8*Ps8+9*Ps9):
                  -1;
always@(posedge clk)
if(rst)
begin 
   Pi0<=0;
   Pi1<=0;
   Pi2<=0;
   Pi3<=0;
   Pi4<=0;
   Pi5<=0;
   Pi6<=0;
   Pi7<=0;
   Pi8<=0;
   Pi9<=0;
end
else if(!finish) 
begin 
    Pi0<=Po0;
    Pi1<=Po1;
    Pi2<=Po2;
    Pi3<=Po3;
    Pi4<=Po4;
    Pi5<=Po5;
    Pi6<=Po6;
    Pi7<=Po7;
    Pi8<=Po8;
    Pi9<=Po9;
end
MACC #(M,N)M0(finish,W0,Ii,Pi0,Po0);
MACC #(M,N)M1(finish,W1,Ii,Pi1,Po1);
MACC #(M,N)M2(finish,W2,Ii,Pi2,Po2);
MACC #(M,N)M3(finish,W3,Ii,Pi3,Po3);
MACC #(M,N)M4(finish,W4,Ii,Pi4,Po4);
MACC #(M,N)M5(finish,W5,Ii,Pi5,Po5);
MACC #(M,N)M6(finish,W6,Ii,Pi6,Po6);
MACC #(M,N)M7(finish,W7,Ii,Pi7,Po7);
MACC #(M,N)M8(finish,W8,Ii,Pi8,Po8);
MACC #(M,N)M9(finish,W9,Ii,Pi9,Po9);
endmodule
