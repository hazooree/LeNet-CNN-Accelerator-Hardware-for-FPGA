`timescale 1ns / 1ps
module LeNet
#(parameter M=32,N=0,Ma = 16,S_in1=28,N_ch1=1,S_f1=5,N_f1=6,S_C1=S_in1-S_f1+1,S_P1=S_C1/2,
S_in2=S_P1,N_ch2=N_f1,S_f2=5,N_f2=12,S_C2=S_in2-S_f2+1,S_P2=S_C2/2,
S_fc=N_f2*S_P2*S_P2,C=10,
N_Weights=N_ch1*S_f1*S_f1*N_f1+N_ch2*S_f2*S_f2*N_f2+S_fc*C)(
// Declaration Block
input clk, rst,
output [M-1:0]LeNet_Out);
// Control Signals
wire [M-1:0]O0,O1,O2,O3,O4,O5,O6,O7,O8,O9,I10,I11,I12,I13,I14;
wire [Ma-1:0]A;
reg [Ma-1:0]A1,A2,A3,A4,A5,A6,
           A11,A12,A13,A14,A15,
           ori,CA,C_c,S_in,N_ch,S_P,S_C;
wire a,C_finish,FC_finish,rstp;

reg rstc,rstf;
// Control Signals
reg [Ma-1:0]Wi;
// Convolution Reg/Wire
wire [Ma-1:0]Ai0,Ai1,Ai2,Ai3,Ai4;
wire [Ma-1:0]Fri,Fi;
wire [M-1:0]Po1,Po2,Po3,Po4,Po5,Po6;
wire [M-1:0]W10,W11,W12,W13,W14,
            W20,W21,W22,W23,W24,
            W30,W31,W32,W33,W34,
            W40,W41,W42,W43,W44,
            W50,W51,W52,W53,W54,
            W60,W61,W62,W63,W64;
wire [Ma-1:0]Aw0,Aw1,Aw2,Aw3,Aw4,
            Aw5,Aw6,Aw7,Aw8,Aw9,
            Aw10,Aw11,Aw12,Aw13,
            Aw14,Aw15,Aw16,Aw17,
            Aw18,Aw19,Aw20,Aw21,
            Aw22,Aw23,Aw24,Aw25,
            Aw26,Aw27,Aw28,Aw29;
// Convolution Control Signals
wire [Ma-1:0]FCi,FcFi;
// Fully Connected Reg/Wire
wire [M-1:0]W0,W1,W2,W3,W4,W5,W6,W7,W8,W9;
wire [M-1:0]Ii;
//wire [M-1:0]O0,O1,O2,O3,O4,O5,O6,O7,O8,O9;
// Memory
reg [M-1:0]W[0:N_Weights-1],I[0:S_in1*S_in1*N_ch1-1],
           P1[0:(S_P1*S_P1-1)][0:N_f1-1],P2[0:(S_P2*S_P2-1)][0:N_f2-1];

// Fully Connected Control Signals
wire [Ma-1:0]Wfi,Wf;
reg [Ma-1:0]Poolif;

// Initialization Block
initial 
begin
   $readmemb("W.mem",W);
   $readmemb("I3.mem",I);
end
integer i,j,m,n;
initial
for(i=0;i<=S_P1*S_P1-1;i=i+1)
   for(j=0;j<=N_f1-1;j=j+1)
      P1[i][j]=0;
initial
for(m=0;m<=S_P2*S_P2-1;m=m+1)
   for(n=0;n<=N_f2-1;n=n+1)
      P2[m][n]=0;
// Layer Control Block
always@(posedge clk) 
if(rst||(C_finish&&C_c<2))
   rstc<=1;
else
   rstc<=0;
always@(posedge clk) 
if(C_finish&&C_c==3)
   rstf<=1; 
else if(FCi==0)
   rstf<=0;
always@(posedge clk) 
if(rst)
   C_c<=0;
else if(!rstc && C_finish && C_c<=3)
   C_c<=C_c+1;
// Conv3D: Assigning Weights and Inputs & Calling Conv3D Module
// Address Generation Block
always@(posedge clk) 
   Wi<=(C_c>=1)*N_ch1*S_f1*S_f1*N_f1+
       (C_c>=2)*N_ch2*S_f2*S_f2*N_f2/2+
       (C_c>=3)*N_ch2*S_f2*S_f2*N_f2/2;
wire [M-1:0]SP0,SP1,SP2,SP3,SP4;
assign SP0 = (P1[Ai0%(S_in2*S_in2)][Fi][M-1])?
             {10'b1111111111,P1[Ai0%(S_in2*S_in2)][Fi][M-1:10]}:
             {10'b0000000000,P1[Ai0%(S_in2*S_in2)][Fi][M-1:10]};
assign SP1 = (P1[Ai1%(S_in2*S_in2)][Fi][M-1])?
             {10'b1111111111,P1[Ai1%(S_in2*S_in2)][Fi][M-1:10]}:
             {10'b0000000000,P1[Ai1%(S_in2*S_in2)][Fi][M-1:10]};
assign SP2 = (P1[Ai2%(S_in2*S_in2)][Fi][M-1])?
             {10'b1111111111,P1[Ai2%(S_in2*S_in2)][Fi][M-1:10]}:
             {10'b0000000000,P1[Ai2%(S_in2*S_in2)][Fi][M-1:10]};
assign SP3 = (P1[Ai3%(S_in2*S_in2)][Fi][M-1])?
             {10'b1111111111,P1[Ai3%(S_in2*S_in2)][Fi][M-1:10]}:
             {10'b0000000000,P1[Ai3%(S_in2*S_in2)][Fi][M-1:10]};
assign SP4 = (P1[Ai4%(S_in2*S_in2)][Fi][M-1])?
             {10'b1111111111,P1[Ai4%(S_in2*S_in2)][Fi][M-1:10]}:
             {10'b0000000000,P1[Ai4%(S_in2*S_in2)][Fi][M-1:10]};
// Assigning Weights & Inputs
assign I10=(C_c==0)?I[Ai0]:SP0,
       I11=(C_c==0)?I[Ai1]:SP1,
       I12=(C_c==0)?I[Ai2]:SP2,
       I13=(C_c==0)?I[Ai3]:SP3,
       I14=(C_c==0)?I[Ai4]:SP4;
assign 
W10=W[Aw0 +Wi],W11=W[Aw1 +Wi],W12=W[Aw2 +Wi],W13=W[Aw3 +Wi],W14=W[Aw4 +Wi],
W20=W[Aw5 +Wi],W21=W[Aw6 +Wi],W22=W[Aw7 +Wi],W23=W[Aw8 +Wi],W24=W[Aw9 +Wi],
W30=W[Aw10+Wi],W31=W[Aw11+Wi],W32=W[Aw12+Wi],W33=W[Aw13+Wi],W34=W[Aw14+Wi],
W40=W[Aw15+Wi],W41=W[Aw16+Wi],W42=W[Aw17+Wi],W43=W[Aw18+Wi],W44=W[Aw19+Wi],
W50=W[Aw20+Wi],W51=W[Aw21+Wi],W52=W[Aw22+Wi],W53=W[Aw23+Wi],W54=W[Aw24+Wi],
W60=W[Aw25+Wi],W61=W[Aw26+Wi],W62=W[Aw27+Wi],W63=W[Aw28+Wi],W64=W[Aw29+Wi];
always@(posedge clk) 
   S_in<=(C_c==0)?S_in1:S_in2;
always@(posedge clk) 
   N_ch<=(C_c==0)?N_ch1:N_ch2;
always@(posedge clk) 
   S_P <=(C_c==0)?S_P1:S_P2;
always@(posedge clk) 
   S_C <=(C_c==0)?S_C1:S_C2;
// Calling Conv3D
Conv3D #(M,N,Ma,S_f1,N_f1) conv(
clk,rstc,
a,S_in,N_ch,
I10,I11,I12,I13,I14,
W10,W11,W12,W13,W14,
W20,W21,W22,W23,W24,
W30,W31,W32,W33,W34,
W40,W41,W42,W43,W44,
W50,W51,W52,W53,W54,
W60,W61,W62,W63,W64,
Ai0,Ai1,Ai2,Ai3,Ai4,
Aw0,Aw1,Aw2,Aw3,Aw4,
Aw5,Aw6,Aw7,Aw8,Aw9,
Aw10,Aw11,Aw12,Aw13,
Aw14,Aw15,Aw16,Aw17,
Aw18,Aw19,Aw20,Aw21,
Aw22,Aw23,Aw24,Aw25,
Aw26,Aw27,Aw28,Aw29,
Po1,Po2,Po3,Po4,Po5,Po6,
A,Fri,Fi,rstp,C_finish);
// Output Accumulation Block
assign a=(A1&A2&A3&A4&A5&A6)==S_P*S_P;
always@(posedge clk)
if(rstp)
begin 
   A11 <= 0;
   A12 <= 0;
   A13 <= 0;
   A14 <= 0;
   A15 <= 0;
end 
else 
begin 
   A11 <= A;
   A12 <= A11;
   A13 <= A12;
   A14 <= A13;
   A15 <= A14; 
end
always@(posedge clk)
if(A >S_in*(S_in*Fi+Fri)+(S_f1-1) && A1<S_P*S_P)
begin 
      CA <= CA + 1;
   if((CA+1)%(2*S_C)==0)
      ori<=ori+1;
   if(CA%2==0)
      A1<=A1;
   else if(CA-S_C+1==2*S_C*ori) 
      A1<=S_P*ori;
   else 
      A1<=A1+1;
   if(C_c==0)
      P1[A1][0]<=P1[A1][0]+Po1;
   else if (C_c==1)
      P2[A1][0]<=P2[A1][0]+Po1;
   else if(C_c==2)
      P2[A1][6]<=P2[A1][6]+Po1;
end
else if(rstp)
begin 
   ori<=0;
   CA<=0;
   A1<=0;
end
always@(posedge clk)
if(A11>S_in*(S_in*Fi+Fri)+(S_f1-1)&&A2<S_P*S_P)
begin 
   A2<=A1;
   if(C_c==0)
      P1[A2][1]<=P1[A2][1]+Po2;
   else if (C_c==1)
      P2[A2][1]<=P2[A2][1]+Po2;
   else if(C_c==2)
      P2[A2][7]<=P2[A2][7]+Po2;
end 
else if(rstp)
   A2<=0;
always@(posedge clk)
if(A12>S_in*(S_in*Fi+Fri)+(S_f1-1)&&A3<S_P*S_P)
begin 
   A3<=A2;
   if(C_c==0)
      P1[A3][2]<=P1[A3][2]+Po3;
   else if (C_c==1)
      P2[A3][2]<=P2[A3][2]+Po3;
   else if(C_c==2)
      P2[A3][8]<=P2[A3][8]+Po3;
end 
else if(rstp)
   A3<=0;
always@(posedge clk)
if(A13>S_in*(S_in*Fi+Fri)+(S_f1-1)&&A4<S_P*S_P)
begin 
   A4<=A3;
   if(C_c==0)
      P1[A4][3]<=P1[A4][3]+Po4;
   else if (C_c==1)
      P2[A4][3]<=P2[A4][3]+Po4;
   else if(C_c==2)
      P2[A4][9]<=P2[A4][9]+Po4;
end
else if(rstp)
   A4<=0;
always@(posedge clk)
if(A14>S_in*(S_in*Fi+Fri)+(S_f1-1)&&A5<S_P*S_P)
begin
   A5<=A4;
   if(C_c==0)
      P1[A5][4]<=P1[A5][4]+Po5;
   else if (C_c==1)
      P2[A5][4]<=P2[A5][4]+Po5;
   else if(C_c==2)
      P2[A5][10]<=P2[A5][10]+Po5;
end 
else if(rstp)
   A5<=0;
always@(posedge clk)
if(A15>S_in*(S_in*Fi+Fri)+(S_f1-1)&&A6<S_P*S_P)
begin
   A6<=A5;
   if(C_c==0)
      P1[A6][5]<=P1[A6][5]+Po6;
   else if (C_c==1)
         P2[A6][5]<=P2[A6][5]+Po6;
      else if(C_c==2)
         P2[A6][11]<=P2[A6][11]+Po6;
end 
else if(rstp)
   A6<=0;
// Assigning Weights and Inputs & Calling Fully Connected Module
assign Wfi = Poolif*S_P2+(FCi%S_P2);
always@(posedge clk)
if(rstf)
   Poolif<=0;
else if(FCi%S_P2==S_P2-1 && FcFi==N_f2-1 && Poolif<S_P2-1) 
   Poolif<=Poolif+1;
assign Ii=(P2[Wfi][FcFi][M-1])?{10'b1111111111,P2[Wfi][FcFi][M-1:10]}:
                               {10'b0000000000,P2[Wfi][FcFi][M-1:10]};
assign Wf = FCi*N_f2+FcFi+Wi;
assign W0=W[0*S_fc+Wf],
       W1=W[1*S_fc+Wf],
       W2=W[2*S_fc+Wf],
       W3=W[3*S_fc+Wf],
       W4=W[4*S_fc+Wf],
       W5=W[5*S_fc+Wf],
       W6=W[6*S_fc+Wf],
       W7=W[7*S_fc+Wf],
       W8=W[8*S_fc+Wf],
       W9=W[9*S_fc+Wf];
FC#(M,N,Ma,N_f2,C,S_P2)uut(
clk,rstf,
W0,W1,W2,W3,W4,W5,W6,W7,W8,W9,
Ii,FCi,FcFi,
O0,O1,O2,O3,O4,O5,O6,O7,O8,O9,
LeNet_Out,FC_finish);
endmodule