`timescale 1ns / 1ps
// Convolution
module Conv3D#(parameter M=32,N=0,Ma=16,S_f=5,N_f=6)(
// Declaration Block
// Inputs
input clk,rst,a,
[Ma-1:0]S_in,N_ch, 
[M-1:0]I10,I11,I12,I13,I14,
       W10,W11,W12,W13,W14,
       W20,W21,W22,W23,W24,
       W30,W31,W32,W33,W34,
       W40,W41,W42,W43,W44,
       W50,W51,W52,W53,W54,
       W60,W61,W62,W63,W64,
// Outputs
output [Ma-1:0]Ai0,Ai1,Ai2,Ai3,Ai4,
              Aw0,Aw1,Aw2,Aw3,Aw4,
              Aw5,Aw6,Aw7,Aw8,Aw9,
              Aw10,Aw11,Aw12,Aw13,
              Aw14,Aw15,Aw16,Aw17,
              Aw18,Aw19,Aw20,Aw21,
              Aw22,Aw23,Aw24,Aw25,
              Aw26,Aw27,Aw28,Aw29,
output [M-1:0]Po1,Po2,Po3,Po4,Po5,Po6,
reg[Ma-1:0]A,Fri,Fi, 
reg rstp,finish);
// Addressing & Control Signals
reg Frd;
wire [M-1:0]Pi;
wire [Ma-1:0]w;
reg [Ma-1:0]D2,D3,D4,D5;
assign Pi = 0,w = (Fi*S_f+Fri)*S_f;
// Convolution and Pooling Output Sizes
wire [Ma-1:0]S_C_o=S_in-S_f+1,S_P_o=S_C_o/2;

// Address_Generation _Block
always @(posedge clk)
begin 
   D2 <= A  + 1;
   D3 <= D2 + 1;
   D4 <= D3 + 1;
   D5 <= D4 + 1;
end
always @(posedge clk,posedge rstp)//)
if (rstp)
   A <= (S_in*Fi + Fri)*S_in; 
else if(A == S_in*(Fi*S_in+Fri+S_C_o)-S_f || Fi>= N_ch) 
   A <= A;
else if((A%S_in==S_C_o-1)) 
   A <= A + S_f; 
else 
   A <= A + 1;
// Convolution Finish Block
always @(posedge clk)
if(rst)
   finish <= 0;
else if(a && A == N_ch*S_in*S_in-S_f)
   finish <= 1;
// Filter_Index (Fi) Block
always @(posedge clk)
if(rst)
   Fi <= 0;
else if(Frd && Fri == S_f-1 && a && Fi< N_ch-1) 
   Fi <= Fi+1;
// Filter_Row_Index (Fri) Block
always @(posedge clk)
if(rst || (Frd && Fri == S_f-1 && a && Fi< N_ch-1)) 
   Fri <= 0;
else if(Frd && Fri<S_f-1 && a) 
   Fri <= Fri+1;
// Filter_Row_Done Block
always @(posedge clk)
if (rstp)
   Frd <= 0;
else if(A == S_in*(Fi*S_in+Fri+S_C_o)-S_f)
   Frd <= 1;
// rstp Block
always @(posedge clk)
if(rst || A != N_ch*S_in*S_in-S_f && Frd && Fri<=S_f-1 && a)
   rstp<=1;
else
   rstp<=0;


// PE Array (5 rows X 6 columns)
assign Ai0=A,
       Ai1=D2,
       Ai2=D3,
       Ai3=D4,
       Ai4=D5;
assign Aw0 =0*S_f*S_f*N_ch+w+0,
       Aw1 =0*S_f*S_f*N_ch+w+1,
       Aw2 =0*S_f*S_f*N_ch+w+2,
       Aw3 =0*S_f*S_f*N_ch+w+3,
       Aw4 =0*S_f*S_f*N_ch+w+4,
       Aw5 =1*S_f*S_f*N_ch+w+0,
       Aw6 =1*S_f*S_f*N_ch+w+1,
       Aw7 =1*S_f*S_f*N_ch+w+2,
       Aw8 =1*S_f*S_f*N_ch+w+3,
       Aw9 =1*S_f*S_f*N_ch+w+4,
       Aw10=2*S_f*S_f*N_ch+w+0,
       Aw11=2*S_f*S_f*N_ch+w+1,
       Aw12=2*S_f*S_f*N_ch+w+2,
       Aw13=2*S_f*S_f*N_ch+w+3,
       Aw14=2*S_f*S_f*N_ch+w+4,
       Aw15=3*S_f*S_f*N_ch+w+0,
       Aw16=3*S_f*S_f*N_ch+w+1,
       Aw17=3*S_f*S_f*N_ch+w+2,
       Aw18=3*S_f*S_f*N_ch+w+3,
       Aw19=3*S_f*S_f*N_ch+w+4,
       Aw20=4*S_f*S_f*N_ch+w+0,
       Aw21=4*S_f*S_f*N_ch+w+1,
       Aw22=4*S_f*S_f*N_ch+w+2,
       Aw23=4*S_f*S_f*N_ch+w+3,
       Aw24=4*S_f*S_f*N_ch+w+4,
       Aw25=5*S_f*S_f*N_ch+w+0,
       Aw26=5*S_f*S_f*N_ch+w+1,
       Aw27=5*S_f*S_f*N_ch+w+2,
       Aw28=5*S_f*S_f*N_ch+w+3,
       Aw29=5*S_f*S_f*N_ch+w+4;

// Calling PE_Matrix for Six Filters
       PE_Matrix6F#(M,N) PE(
       rstp,clk,
       W10,W11,W12,W13,W14,
       W20,W21,W22,W23,W24,
       W30,W31,W32,W33,W34,
       W40,W41,W42,W43,W44,
       W50,W51,W52,W53,W54,
       W60,W61,W62,W63,W64,
       Pi,
       I10,I11,I12,I13,I14,
       Po1,Po2,Po3,Po4,Po5,Po6);
endmodule
// PE_Matrix for Six Filters
module PE_Matrix6F #(parameter M=32,N=0)(
// Declaration Block
input rst,clk,
[M-1:0]W10,W11,W12,W13,W14,
       W20,W21,W22,W23,W24,
       W30,W31,W32,W33,W34,
       W40,W41,W42,W43,W44,
       W50,W51,W52,W53,W54,
       W60,W61,W62,W63,W64,
       Pi,
       I10,I11,I12,I13,I14,
output [M-1:0]Po1,Po2,Po3,Po4,Po5,Po6);
wire [M-1:0]I20,I21,I22,I23,I24,
            I30,I31,I32,I33,I34,
            I40,I41,I42,I43,I44,
            I50,I51,I52,I53,I54,
            I60,I61,I62,I63,I64;
PE_Array#(M,N) A1(
clk,rst,
W10,W11,W12,W13,W14,
I10,I11,I12,I13,I14,
Pi,Po1,
I20,I21,I22,I23,I24);
PE_Array#(M,N) A2(
clk,rst,
W20,W21,W22,W23,W24,
I20,I21,I22,I23,I24,
Pi,Po2,
I30,I31,I32,I33,I34);
PE_Array#(M,N) A3(
clk,rst,
W30,W31,W32,W33,W34,
I30,I31,I32,I33,I34,
Pi,Po3,
I40,I41,I42,I43,I44);
PE_Array#(M,N) A4(
clk,rst,
W40,W41,W42,W43,W44,
I40,I41,I42,I43,I44,
Pi,Po4,
I50,I51,I52,I53,I54);
PE_Array#(M,N) A5(
clk,rst,
W50,W51,W52,W53,W54,
I50,I51,I52,I53,I54,
Pi,Po5,
I60,I61,I62,I63,I64);
PE_Array#(M,N) A6(
clk,rst,
W60,W61,W62,W63,W64,
I60,I61,I62,I63,I64,
Pi,Po6);
endmodule
