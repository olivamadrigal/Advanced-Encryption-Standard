`timescale 1ns / 1ps
/**************************************************************************************

	MIT License

	Copyright (c) 2016 Samira C. Oliva

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

        Engineer: Samira C. Oliva
	
	Create Date:  04/23/2016 11:08:59 PM
	Project Name: AES hardware implementation
	Description:
	
        CMPE 297    

*************************************************************************************/

/*-------------------------------------------------------------------------
    SubByte -- byte substition lookup table
-------------------------------------------------------------------------*/
module SubByte(s, sprime);

input  [7:0]s;
output [7:0]sprime;

reg [7:0] sbox[15:0][15:0];//byte lookup table

assign sbox[0][0] = 8'h63; assign sbox[0][1] = 8'h7c; assign sbox[0][2] = 8'h77; assign sbox[0][3] = 8'h7b; 
assign sbox[0][4] = 8'hf2; assign sbox[0][5] = 8'h6b; assign sbox[0][6] = 8'h6f; assign sbox[0][7] = 8'hc5; 
assign sbox[0][8] = 8'h30; assign sbox[0][9] = 8'h1; assign sbox[0][10] = 8'h67; assign sbox[0][11] = 8'h2b; 
assign sbox[0][12] = 8'hfe; assign sbox[0][13] = 8'hd7; assign sbox[0][14] = 8'hab; assign sbox[0][15] = 8'h76; 
assign sbox[1][0] = 8'hca; assign sbox[1][1] = 8'h82; assign sbox[1][2] = 8'hc9; assign sbox[1][3] = 8'h7d; 
assign sbox[1][4] = 8'hfa; assign sbox[1][5] = 8'h59; assign sbox[1][6] = 8'h47; assign sbox[1][7] = 8'hf0; 
assign sbox[1][8] = 8'had; assign sbox[1][9] = 8'hd4; assign sbox[1][10] = 8'ha2; assign sbox[1][11] = 8'haf; 
assign sbox[1][12] = 8'h9c; assign sbox[1][13] = 8'ha4; assign sbox[1][14] = 8'h72; assign sbox[1][15] = 8'hc0; 
assign sbox[2][0] = 8'hb7; assign sbox[2][1] = 8'hfd; assign sbox[2][2] = 8'h93; assign sbox[2][3] = 8'h26; 
assign sbox[2][4] = 8'h36; assign sbox[2][5] = 8'h3f; assign sbox[2][6] = 8'hf7; assign sbox[2][7] = 8'hcc; 
assign sbox[2][8] = 8'h34; assign sbox[2][9] = 8'ha5; assign sbox[2][10] = 8'he5; assign sbox[2][11] = 8'hf1; 
assign sbox[2][12] = 8'h71; assign sbox[2][13] = 8'hd8; assign sbox[2][14] = 8'h31; assign sbox[2][15] = 8'h15; 
assign sbox[3][0] = 8'h4; assign sbox[3][1] = 8'hc7; assign sbox[3][2] = 8'h23; assign sbox[3][3] = 8'hc3; 
assign sbox[3][4] = 8'h18; assign sbox[3][5] = 8'h96; assign sbox[3][6] = 8'h5; assign sbox[3][7] = 8'h9a; 
assign sbox[3][8] = 8'h7; assign sbox[3][9] = 8'h12; assign sbox[3][10] = 8'h80; assign sbox[3][11] = 8'he2; 
assign sbox[3][12] = 8'heb; assign sbox[3][13] = 8'h27; assign sbox[3][14] = 8'hb2; assign sbox[3][15] = 8'h75; 
assign sbox[4][0] = 8'h9; assign sbox[4][1] = 8'h83; assign sbox[4][2] = 8'h2c; assign sbox[4][3] = 8'h1a; 
assign sbox[4][4] = 8'h1b; assign sbox[4][5] = 8'h6e; assign sbox[4][6] = 8'h5a; assign sbox[4][7] = 8'ha0; 
assign sbox[4][8] = 8'h52; assign sbox[4][9] = 8'h3b; assign sbox[4][10] = 8'hd6; assign sbox[4][11] = 8'hb3; 
assign sbox[4][12] = 8'h29; assign sbox[4][13] = 8'he3; assign sbox[4][14] = 8'h2f; assign sbox[4][15] = 8'h84; 
assign sbox[5][0] = 8'h53; assign sbox[5][1] = 8'hd1; assign sbox[5][2] = 8'h0; assign sbox[5][3] = 8'hed; 
assign sbox[5][4] = 8'h20; assign sbox[5][5] = 8'hfc; assign sbox[5][6] = 8'hb1; assign sbox[5][7] = 8'h5b; 
assign sbox[5][8] = 8'h6a; assign sbox[5][9] = 8'hcb; assign sbox[5][10] = 8'hbe; assign sbox[5][11] = 8'h39; 
assign sbox[5][12] = 8'h4a; assign sbox[5][13] = 8'h4c; assign sbox[5][14] = 8'h58; assign sbox[5][15] = 8'hcf; 
assign sbox[6][0] = 8'hd0; assign sbox[6][1] = 8'hef; assign sbox[6][2] = 8'haa; assign sbox[6][3] = 8'hfb; 
assign sbox[6][4] = 8'h43; assign sbox[6][5] = 8'h4d; assign sbox[6][6] = 8'h33; assign sbox[6][7] = 8'h85; 
assign sbox[6][8] = 8'h45; assign sbox[6][9] = 8'hf9; assign sbox[6][10] = 8'h2; assign sbox[6][11] = 8'h7f; 
assign sbox[6][12] = 8'h50; assign sbox[6][13] = 8'h3c; assign sbox[6][14] = 8'h9f; assign sbox[6][15] = 8'ha8; 
assign sbox[7][0] = 8'h51; assign sbox[7][1] = 8'ha3; assign sbox[7][2] = 8'h40; assign sbox[7][3] = 8'h8f; 
assign sbox[7][4] = 8'h92; assign sbox[7][5] = 8'h9d; assign sbox[7][6] = 8'h38; assign sbox[7][7] = 8'hf5; 
assign sbox[7][8] = 8'hbc; assign sbox[7][9] = 8'hb6; assign sbox[7][10] = 8'hda; assign sbox[7][11] = 8'h21; 
assign sbox[7][12] = 8'h10; assign sbox[7][13] = 8'hff; assign sbox[7][14] = 8'hf3; assign sbox[7][15] = 8'hd2; 
assign sbox[8][0] = 8'hcd; assign sbox[8][1] = 8'hc; assign sbox[8][2] = 8'h13; assign sbox[8][3] = 8'hec; 
assign sbox[8][4] = 8'h5f; assign sbox[8][5] = 8'h97; assign sbox[8][6] = 8'h44; assign sbox[8][7] = 8'h17; 
assign sbox[8][8] = 8'hc4; assign sbox[8][9] = 8'ha7; assign sbox[8][10] = 8'h7e; assign sbox[8][11] = 8'h3d; 
assign sbox[8][12] = 8'h64; assign sbox[8][13] = 8'h5d; assign sbox[8][14] = 8'h19; assign sbox[8][15] = 8'h73; 
assign sbox[9][0] = 8'h60; assign sbox[9][1] = 8'h81; assign sbox[9][2] = 8'h4f; assign sbox[9][3] = 8'hdc; 
assign sbox[9][4] = 8'h22; assign sbox[9][5] = 8'h2a; assign sbox[9][6] = 8'h90; assign sbox[9][7] = 8'h88; 
assign sbox[9][8] = 8'h46; assign sbox[9][9] = 8'hee; assign sbox[9][10] = 8'hb8; assign sbox[9][11] = 8'h14; 
assign sbox[9][12] = 8'hde; assign sbox[9][13] = 8'h5e; assign sbox[9][14] = 8'hb; assign sbox[9][15] = 8'hdb; 
assign sbox[10][0] = 8'he0; assign sbox[10][1] = 8'h32; assign sbox[10][2] = 8'h3a; assign sbox[10][3] = 8'ha; 
assign sbox[10][4] = 8'h49; assign sbox[10][5] = 8'h6; assign sbox[10][6] = 8'h24; assign sbox[10][7] = 8'h5c; 
assign sbox[10][8] = 8'hc2; assign sbox[10][9] = 8'hd3; assign sbox[10][10] = 8'hac; assign sbox[10][11] = 8'h62; 
assign sbox[10][12] = 8'h91; assign sbox[10][13] = 8'h95; assign sbox[10][14] = 8'he4; assign sbox[10][15] = 8'h79; 
assign sbox[11][0] = 8'he7; assign sbox[11][1] = 8'hc8; assign sbox[11][2] = 8'h37; assign sbox[11][3] = 8'h6d; 
assign sbox[11][4] = 8'h8d; assign sbox[11][5] = 8'hd5; assign sbox[11][6] = 8'h4e; assign sbox[11][7] = 8'ha9; 
assign sbox[11][8] = 8'h6c; assign sbox[11][9] = 8'h56; assign sbox[11][10] = 8'hf4; assign sbox[11][11] = 8'hea; 
assign sbox[11][12] = 8'h65; assign sbox[11][13] = 8'h7a; assign sbox[11][14] = 8'hae; assign sbox[11][15] = 8'h8; 
assign sbox[12][0] = 8'hba; assign sbox[12][1] = 8'h78; assign sbox[12][2] = 8'h25; assign sbox[12][3] = 8'h2e; 
assign sbox[12][4] = 8'h1c; assign sbox[12][5] = 8'ha6; assign sbox[12][6] = 8'hb4; assign sbox[12][7] = 8'hc6; 
assign sbox[12][8] = 8'he8; assign sbox[12][9] = 8'hdd; assign sbox[12][10] = 8'h74; assign sbox[12][11] = 8'h1f; 
assign sbox[12][12] = 8'h4b; assign sbox[12][13] = 8'hbd; assign sbox[12][14] = 8'h8b; assign sbox[12][15] = 8'h8a; 
assign sbox[13][0] = 8'h70; assign sbox[13][1] = 8'h3e; assign sbox[13][2] = 8'hb5; assign sbox[13][3] = 8'h66; 
assign sbox[13][4] = 8'h48; assign sbox[13][5] = 8'h3; assign sbox[13][6] = 8'hf6; assign sbox[13][7] = 8'he; 
assign sbox[13][8] = 8'h61; assign sbox[13][9] = 8'h35; assign sbox[13][10] = 8'h57; assign sbox[13][11] = 8'hb9; 
assign sbox[13][12] = 8'h86; assign sbox[13][13] = 8'hc1; assign sbox[13][14] = 8'h1d; assign sbox[13][15] = 8'h9e; 
assign sbox[14][0] = 8'he1; assign sbox[14][1] = 8'hf8; assign sbox[14][2] = 8'h98; assign sbox[14][3] = 8'h11; 
assign sbox[14][4] = 8'h69; assign sbox[14][5] = 8'hd9; assign sbox[14][6] = 8'h8e; assign sbox[14][7] = 8'h94; 
assign sbox[14][8] = 8'h9b; assign sbox[14][9] = 8'h1e; assign sbox[14][10] = 8'h87; assign sbox[14][11] = 8'he9; 
assign sbox[14][12] = 8'hce; assign sbox[14][13] = 8'h55; assign sbox[14][14] = 8'h28; assign sbox[14][15] = 8'hdf; 
assign sbox[15][0] = 8'h8c; assign sbox[15][1] = 8'ha1; assign sbox[15][2] = 8'h89; assign sbox[15][3] = 8'hd; 
assign sbox[15][4] = 8'hbf; assign sbox[15][5] = 8'he6; assign sbox[15][6] = 8'h42; assign sbox[15][7] = 8'h68; 
assign sbox[15][8] = 8'h41; assign sbox[15][9] = 8'h99; assign sbox[15][10] = 8'h2d; assign sbox[15][11] = 8'hf; 
assign sbox[15][12] = 8'hb0; assign sbox[15][13] = 8'h54; assign sbox[15][14] = 8'hbb; assign sbox[15][15] = 8'h16; 

assign sprime = sbox[s[7:4]][s[3:0]];

endmodule

/*-------------------------------------------------------------------------
    Subbytes applies the S-box to current state
-------------------------------------------------------------------------*/
module SubBytes(s, sprime);

input  [7:0]  s[3:0][3:0];
output [7:0]  sprime[3:0][3:0];

    SubByte u1(s[0][0],sprime[0][0]);
    SubByte u2(s[0][1],sprime[0][1]);
    SubByte u3(s[0][2],sprime[0][2]);
    SubByte u4(s[0][3],sprime[0][3]);
    SubByte u5(s[1][0],sprime[1][0]);
    SubByte u6(s[1][1],sprime[1][1]);
    SubByte u7(s[1][2],sprime[1][2]);
    SubByte u8(s[1][3],sprime[1][3]);
    SubByte u9(s[2][0],sprime[2][0]);
    SubByte u10(s[2][1],sprime[2][1]);
    SubByte u11(s[2][2],sprime[2][2]);
    SubByte u12(s[2][3],sprime[2][3]);
    SubByte u13(s[3][0],sprime[3][0]);
    SubByte u14(s[3][1],sprime[3][1]);
    SubByte u15(s[3][2],sprime[3][2]);
    SubByte u16(s[3][3],sprime[3][3]);

endmodule


/*-------------------------------------------------------------------------
	SubWord applies the S-box to a four-byte input
-------------------------------------------------------------------------*/
module SubWord(s, sprime);

input  [31:0]s;
output [31:0]sprime;

	SubByte u1(s[31:24],sprime[31:24]);
	SubByte u2(s[23:16],sprime[23:16]);
	SubByte u3(s[15:8],sprime[15:8]);
	SubByte u4(s[7:0],sprime[7:0]);

endmodule

//Mux2to1     mux2(mSel, cs, sprime, outmux2); 
/*-------------------------------------------------------------------------
    2 to 1 mux
-------------------------------------------------------------------------*/
// if s = 1, C = A, esle C = B
module Mux2to1(s, A, B, C);
input s;
input [7:0] A[3:0][3:0];
input [7:0] B[3:0][3:0];
output[7:0] C[3:0][3:0];

        assign C = s ? A: B;
         
endmodule

//Mux2to1     mux2(mSel, cs, sprime, outmux2); 
/*-------------------------------------------------------------------------
    2 to 1 mux
-------------------------------------------------------------------------*/
// if s = 1, C = A, esle C = B
module Mux2to1W(s, A, B, C);
input s;
input [31:0] A;
input [31:0] B;
output[31:0] C;

        assign C = s ? A: B;
         
endmodule

/*-------------------------------------------------------------------------
    D-Reg --- for the state
-------------------------------------------------------------------------*/
module dReg(clk, en, d, q);

input  clk, en;
input  [7:0] d[3:0][3:0];
output reg [7:0] q[3:0][3:0];

     always@(posedge clk)
        q <= en ? d:q;
        
endmodule

/*-------------------------------------------------------------------------
    D-Reg --- for the roundkeys array w
-------------------------------------------------------------------------*/
module floper #(parameter WIDTH = 32)
             (clk, en, d, q);

input  clk, en;
input  [WIDTH-1:0]d;
output reg [WIDTH-1:0]q;

        always@(posedge clk)
             q <= en ? d:q;

endmodule

/*-------------------------------------------------------------------------
    Counter 
-------------------------------------------------------------------------*/
module counterAES(clk, loadEn, countEn, cnt);

input  clk, loadEn, countEn;
output reg [3:0] cnt;

	always @(posedge clk)
	begin
		if(loadEn)
			cnt <= 4'b1;//set counter
		else if(countEn)
			cnt <= cnt + 4'd1;//count up
		else
			cnt <= cnt; //hold
	end
	
endmodule

/*-------------------------------------------------------------------------
    Counter 
-------------------------------------------------------------------------*/
module counterKE #(parameter n = 4)(clk, loadEn, countEn, cnt);

input  clk, loadEn, countEn;
output reg [5:0] cnt;

	always @(posedge clk)
	begin
		if(loadEn)
			cnt <= n;//set counter
		else if(countEn)
			cnt <= cnt + 4'd1;//count up
		else
			cnt <= cnt; //hold
	end
	
endmodule


/*-------------------------------------------------------------------------
  ShiftRows:
  performs cyclic shift on rows 1, 2, 3
-------------------------------------------------------------------------*/
module ShiftRows(s, sprime);

input  [7:0]  s[3:0][3:0];
output [7:0]  sprime[3:0][3:0];

assign {sprime[0][0],sprime[0][1],sprime[0][2],sprime[0][3]} =  {s[0][0],s[0][1],s[0][2],s[0][3]}; 
assign {sprime[1][0],sprime[1][1],sprime[1][2],sprime[1][3]} =  {s[1][1],s[1][2],s[1][3],s[1][0]};
assign {sprime[2][0],sprime[2][1],sprime[2][2],sprime[2][3]} =  {s[2][2],s[2][3],s[2][0],s[2][1]}; 
assign {sprime[3][0],sprime[3][1],sprime[3][2],sprime[3][3]} =  {s[3][3],s[3][0],s[3][1],s[3][2]}; 

endmodule


/*-------------------------------------------------------------------------
  shift Left One
  m(x) = 00011011;
-------------------------------------------------------------------------*/
module shiftLeftOne(a, out);

input [7:0] a;
output [7:0]out;

wire [7:0]ap, ap1;

assign ap  = {a[6:0], 1'b0}; 
assign ap1 = ap ^ 8'b00011011; 
assign out = a[7]? ap1: ap;

endmodule

/*-------------------------------------------------------------------------
  GF Multiplication
-------------------------------------------------------------------------*/
module GF(a,b,out);

input [7:0] a, b;
output [7:0] out;


wire [7:0] r1, r2, r3, r4, r5, r6, r7;
wire [7:0] m0, m1, m2, m3, m4, m5, m6, m7;

shiftLeftOne u1(a, r1);  
shiftLeftOne u2(r1, r2);
shiftLeftOne u3(r2, r3);
shiftLeftOne u4(r3, r4);
shiftLeftOne u5(r4, r5);
shiftLeftOne u6(r5, r6);
shiftLeftOne u7(r6, r7);

assign m0 = b[0]? a:8'd0; 
assign m1 = b[1]? r1:8'd0; 
assign m2 = b[2]? r2:8'd0; 
assign m3 = b[3]? r3:8'd0; 
assign m4 = b[4]? r4:8'd0; 
assign m5 = b[5]? r5:8'd0; 
assign m6 = b[6]? r6:8'd0; 
assign m7 = b[7]? r7:8'd0; 

assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7;

 
endmodule
/*-------------------------------------------------------------------------
  vector multiplication
-------------------------------------------------------------------------*/
module vectorMultiplication(a,b,e);

input  [7:0] a[3:0];//row from a
input  [7:0] b[3:0];//column from state
output [7:0] e; //element for sprime

wire [7:0] r1, r2, r3, r4;

GF u1(a[0],b[0],r1);
GF u2(a[1],b[1],r2);
GF u3(a[2],b[2],r3);
GF u4(a[3],b[3],r4);

assign e = r1 ^ r2 ^ r3 ^ r4;

endmodule

/*-------------------------------------------------------------------------
  MixColumns
  
  operates on the state column-wise, each column is treated as a 4-term
  polynomials over GF(2^8) and multiplied modulo x^4 + 1 with
  fixed polynomial a(x) = {03}x^3   + {01}x^2  + {01}x + {02}
-------------------------------------------------------------------------*/
module MixColumns(s, sprime);

// I/O  signals
input  [7:0]  s[3:0][3:0];
output [7:0]  sprime[3:0][3:0];

//internal signals
reg    [7:0]  a[3:0][3:0]; 

genvar c;

wire [7:0] a0[3:0];
wire [7:0] a1[3:0];
wire [7:0] a2[3:0];
wire [7:0] a3[3:0];
wire [7:0] s0[3:0];
wire [7:0] s1[3:0];
wire [7:0] s2[3:0];
wire [7:0] s3[3:0];

//initialize fixed polynomial
assign a[0][0] = 8'h02;
assign a[0][1] = 8'h03;
assign a[0][2] = 8'h01;
assign a[0][3] = 8'h01;
assign a[1][0] = 8'h01;
assign a[1][1] = 8'h02;
assign a[1][2] = 8'h03;
assign a[1][3] = 8'h01;
assign a[2][0] = 8'h01;
assign a[2][1] = 8'h01;
assign a[2][2] = 8'h02;
assign a[2][3] = 8'h03;
assign a[3][0] = 8'h03;
assign a[3][1] = 8'h01;
assign a[3][2] = 8'h01;
assign a[3][3] = 8'h02;


for(c = 0; c < 4; c = c + 1)
begin
    assign a0[c] = a[0][c];
end

for(c = 0; c < 4; c = c + 1)
begin
    assign a1[c] = a[1][c];
end

for(c = 0; c < 4; c = c + 1)
begin
    assign a2[c] = a[2][c];
end

for(c = 0; c < 4; c = c + 1)
begin
    assign a3[c] = a[3][c];
end

//
for(c = 0; c < 4; c = c + 1)
begin
    assign s0[c] = s[c][0];
end

for(c = 0; c < 4; c = c + 1)
begin
    assign s1[c] = s[c][1];
end

for(c = 0; c < 4; c = c + 1)
begin
    assign s2[c] = s[c][2];
end

for(c = 0; c < 4; c = c + 1)
begin
    assign s3[c] = s[c][3];
end

vectorMultiplication u0(a0,s0,sprime[0][0]);
vectorMultiplication u1(a1,s0,sprime[1][0]);
vectorMultiplication u2(a2,s0,sprime[2][0]);
vectorMultiplication u3(a3,s0,sprime[3][0]);
vectorMultiplication u4(a0,s1,sprime[0][1]);
vectorMultiplication u5(a1,s1,sprime[1][1]);
vectorMultiplication u6(a2,s1,sprime[2][1]);
vectorMultiplication u7(a3,s1,sprime[3][1]);
vectorMultiplication u8(a0,s2,sprime[0][2]);
vectorMultiplication u9(a1,s2,sprime[1][2]);
vectorMultiplication u10(a2,s2,sprime[2][2]);
vectorMultiplication u11(a3,s2,sprime[3][2]);
vectorMultiplication u12(a0,s3,sprime[0][3]);
vectorMultiplication u13(a1,s3,sprime[1][3]);
vectorMultiplication u14(a2,s3,sprime[2][3]);
vectorMultiplication u15(a3,s3,sprime[3][3]);

endmodule

/*-------------------------------------------------------------------------
    Tri-state Buffer
-------------------------------------------------------------------------*/
module triStateBuffer #(parameter WIDTH = 16)(P,done,result);

input  [7:0] P[WIDTH-1:0];
input  done;
output reg [7:0] result[WIDTH-1:0];

genvar a;

for (a =0; a <16; a= a+1 )
begin
    assign result[a] = done ? P[a] : 8'dZ; //P or High-Z
end
endmodule


/*-------------------------------------------------------------------------
    KeySelect used in KeyExpansion
-------------------------------------------------------------------------*/
module KeySelect #(parameter WIDTH = 16, WIDTH2 = 44, Nk = 4)
        (key, result, rSel, wSel, wSel2, clk, en, out, out2,w);
   
   input  clk, en;
   input  [7:0] key[WIDTH-1:0];//cipher key 
   input  [31:0] result;  //result to store
   input  [5:0]  rSel;//result index select
   input  [5:0]  wSel, wSel2;//word select index
   output [31:0] out, out2;//either w[i-1] or w[Nk-1]
   output [31:0] w[WIDTH2-1:0];
   
   reg[31:0] temp[WIDTH2-1:0];
     
   genvar i;

   for(i = 0; i < Nk; i = i + 1)
   begin
       assign w[i] = {key[(4*i)+3],key[(4*i) + 2],key[(4*i) +1],key[4*i]};
   end
   
   for(i = Nk; i < WIDTH2; i = i + 1)
   begin
        assign w[i] = temp[i];
   end
   //demux
  always@(posedge clk)
  begin
    temp[rSel] = en? result:w[rSel];       //write address
  end
  
   assign out     = w[wSel]; //read1       
   assign out2    = w[wSel2];//read2

   
endmodule


/*-------------------------------------------------------------------------
    key Expansion
-------------------------------------------------------------------------*/
module keyExpansion #(parameter Nk = 4, Nr = 10)(clk,GO, RST,key,w,done);

//constants
//Nk = columns of key (4, 6, or 8)
// Nr number of rounds (10, 12, or 14)
parameter Nb = 4;
parameter wWidth = (Nb * (Nr + 1));
parameter kWidth = (4*Nk);


// I/O signals
input   clk, GO, RST;
input   [7:0] key[kWidth -1:0]; //128, 192, or 256-bit key
output  reg[31:0] w[wWidth-1:0];//array of round keys
output  done;

//control unit signals
wire   en;
wire[5:0]  rSel;                   //result select index 
wire[5:0]  wSel, wSel2;           //word select index
wire[5:0]  countStatus;
wire    tSel1, tSel2, tSel3; 
 
//key control signals
wire  [31:0] out, out2;
wire  [31:0] result, sKey, rKey, rword, outMux1, outMux2, outMux3;//array of round keys

//internal signals
reg[7:0] Rcon[9:0];  //Round Constant -- array of bytes 

//initialize round constant
assign Rcon[0] = 8'h01;
assign Rcon[1] = 8'h02;
assign Rcon[2] = 8'h04;
assign Rcon[3] = 8'h08;
assign Rcon[4] = 8'h10;
assign Rcon[5] = 8'h20;
assign Rcon[6] = 8'h40;
assign Rcon[7] = 8'h80;
assign Rcon[8] = 8'h1b;
assign Rcon[9] = 8'h36;

KeySelect #(kWidth,wWidth,Nk) keyCtrl(key,result,rSel,wSel,wSel2,clk,en,out,out2,w);    
Mux2to1W  mux1(tSel1,out,{out[7:0],out[31:8]},outMux1);//RotateWord
SubWord   sbox(outMux1, sKey);
assign    rKey = sKey ^ {24'd0,Rcon[((countStatus)/Nk) - 1]}; 
Mux2to1W  mux2(tSel2,sKey,rKey,outMux2);
Mux2to1W  mux3(tSel3,outMux2,out,outMux3);
assign    result = outMux3 ^ out2;

counterKE #(Nk) countUp(clk,loadEn,countEn,countStatus);                                    
keyExpansionControlUnit #(Nk,Nr) controller(GO, RST,clk,countStatus, tSel1,tSel2,tSel3,wSel,wSel2,rSel,en,countEn,loadEn,done);

endmodule


/*-------------------------------------------------------------------------
	Key Expansion Control Unit
-------------------------------------------------------------------------*/
module keyExpansionControlUnit #(parameter Nk = 4, Nr = 10)
                            	(GO, RST,clk,counterStatus,tsel1,tsel2,tsel3,wSel,wSel2,rSel,en,countEn,loadEn,done);
                            	
parameter Nb = 4;
// I/O signals
input   GO;
input   RST, clk;
input   [5:0] counterStatus;
output reg  tsel1,tsel2,tsel3,en,countEn,loadEn,done;//en-- enable write to temp register
output reg  [5:0] wSel,wSel2,rSel;

//internals signals
reg [3:0] NS, CS;

//Next State Logic
always@(CS,GO,counterStatus)
    begin
    case(CS)
   	 0: NS = GO ? 4'b0001:4'b0000;
   	 1: NS =  4'b00010;
   	 2:
   	 begin
   	 if(counterStatus < (4* (Nr + 1)))
   		NS = 4'b0010;
   	 else
   		NS = 4'b0011;
   	 end
   	 3: NS = GO? 4'd0011: 4'b0000;
	 
   	 default:
   	 NS = 4'b0000;
    endcase
end

//State Register
always@(posedge clk, posedge RST)
    begin
   	 CS <= RST? 0:NS;
    end

//Output Logic
always@(*)
    begin
   	 case(CS)
   	 0: 
   	 begin 
   	    {tsel1,tsel2,tsel3,en,countEn,loadEn,done} <= 7'b000_0_01_0;
   	 end
     1:
     begin
        {tsel1,tsel2,tsel3,en,countEn,loadEn, done} <= 7'b000_0_00_0;
        wSel  <= counterStatus - 1;//read address 1
        wSel2 <= counterStatus - Nk;//read address 2
        rSel  <= counterStatus;//write address
   	 end
    2:  
    begin
   	   	wSel  <= counterStatus - 1;//read address 1
       	wSel2 <= counterStatus - Nk;//read address 2
       	rSel  <= counterStatus;//write address
       	done  <= 1'b0;
     	if(counterStatus % Nk == 0) // if tSel1 or tSel2 is 1, then tSel3 is 1
      	begin                                      	 
           	{tsel1,tsel2,tsel3,en,countEn,loadEn} <= 6'b001_1_10;//tsel1 = 1
        end           	 
        else if(Nk > 6 && (counterStatus % Nk == 4))      	 
          	{tsel1,tsel2,tsel3,en,countEn,loadEn} <= 6'b111_1_10;//tSel2 =1
        else                                         	 
           	{tsel1,tsel2,tsel3,en,countEn,loadEn} <= 6'b100_1_10;//only tSel1 = 1
   end
   	 
   3: {tsel1,tsel2,tsel3,en,countEn,loadEn,done} <= 7'b000_0_01_1;
   default:
       {tsel1,tsel2,tsel3,en,countEn,loadEn,done} <= 7'b000_0_01_0;//S0
   endcase
end
    
endmodule


/*-------------------------------------------------------------------------
    AddRoundKey
-------------------------------------------------------------------------*/
module AddRoundKey(s,w,sprime);

parameter Nb = 4;

input reg [7:0] s[3:0][Nb-1: 0];
input reg [31:0] w[3:0];//round key (array of 4 elements) each at 32-bits
output reg [7:0] sprime[3:0][Nb-1: 0];

genvar c, r;

for( c = 0; c < Nb; c = c + 1)
begin
       assign sprime[0][c] = s[0][c] ^ w[c][7:0];
       assign sprime[1][c] = s[1][c] ^ w[c][15:8];
       assign sprime[2][c] = s[2][c] ^ w[c][23:16];
       assign sprime[3][c] = s[3][c] ^ w[c][31:24];
end

endmodule

/*-------------------------------------------------------------------------
    GetRoundKey -- used in AES module
-------------------------------------------------------------------------*/
module GetRoundKey #(parameter Nr = 10)(w,ctrl,rKey);

parameter Nb = 4;//the same for all key lengths

input  [31:0] w[(Nb*(Nr+1))-1: 0];
input  [3:0]  ctrl;
output [31:0] rKey[3:0];

genvar j;

//no variable input mux :.
        for( j = 0; j < 4; j = j + 1)
        begin
             assign rKey[j] = w[(ctrl*4) + j];
        end
   

endmodule

/*-------------------------------------------------------------------------
    Control Unit for AES
-------------------------------------------------------------------------*/
module  CU #(parameter ROUNDS = 10)
        (GO, RST, clk, counterStatus, sSel, aSel, rSel, loadEn, countEn, enS, done);

parameter Nr = ROUNDS;
input   GO, RST, clk;
input   [3:0] counterStatus;
output  reg sSel, aSel, rSel, enS;
output  reg loadEn, countEn, done;
//output  [3:0] ctrl;

reg      [3:0] NS;
reg      [3:0]CS;
//Next State Logic
always@(CS,GO,counterStatus)
    begin
    case(CS)
        0: NS = GO ? 4'b0001:4'b0000;
        1: NS = 4'b0010; //S2
        2: NS = 4'b0011 ;//S3
        3: 
        begin
        if(counterStatus < Nr-1)
             NS = 4'b0011;//S3
        else
             NS = 4'b0100;//S4
        end
        4: NS = 4'b0101;//S5
        5: NS = 4'b0000;
        default: 
        NS = 4'b0000;
    endcase
end

//State Register
always@(posedge clk, posedge RST)
    begin
        CS <= RST? 0:NS;
    end
    

//Output Logic
always@(CS)
    begin
        case(CS)
        0: {sSel,enS,aSel,rSel,  loadEn, countEn, done} <= 7'b1101_10_0;
        1: {sSel,enS,aSel,rSel,  loadEn, countEn, done} <= 7'b1101_10_0;
        2: {sSel,enS,aSel,rSel,  loadEn, countEn, done} <= 7'b0101_01_0;
        3: {sSel,enS,aSel, rSel, loadEn, countEn, done} <= 7'b0111_01_0;
        4: {sSel,enS,aSel, rSel, loadEn, countEn, done} <= 7'b0110_01_0;
        5: {sSel,enS,aSel, rSel, loadEn, countEn, done} <= 7'b0110_01_1;
        default:
           {sSel,enS,aSel,rSel,  loadEn, countEn, done} <= 7'b1101_10_0;
       endcase
    end
    
endmodule


/*-------------------------------------------------------------------------
    AES
-------------------------------------------------------------------------*/
module AES  #(parameter Nr = 10)
                      (clk, GO, RST, in, w, out, done);

//Nb = state columns
//Nr = number of rounds 10, 12, 14
parameter Nb = 4;
parameter pWIDTH = (4*Nb);
parameter wWIDTH = (Nb*(Nr+1));

input  clk, GO, RST;
input  [7:0]    in[pWIDTH-1:0];     // 128-bit plaintext
input  [31:0]   w[wWIDTH-1:0]; //array of round keys
output reg [7:0]    out[pWIDTH-1:0];//cipher text
output done;

//state arrays of bytes (4 rows by Nb-1 columns)
wire [7:0] csa [pWIDTH-1:0];
wire [7:0] s[3:0][3:0];
reg [7:0]  sprime[3:0][3:0];
reg [7:0]  state[3:0][3:0];
reg [7:0]  cs[3:0][3:0];
reg [7:0]  outMux1[3:0][3:0];
reg [7:0]  outMux2[3:0][3:0];
reg [7:0]  outMux3[3:0][3:0];
reg [7:0]  A[3:0][3: 0];
reg [7:0]  B[3:0][3: 0];
reg [7:0]  C[3:0][3: 0];
reg [31:0] rKey[3:0];
wire [3:0] counterStatus;
wire loadEn, countEn, sSel, aSel, rSel, enS;   //mux select inputs
wire [1:0] CS;

genvar r, c;//rows, columns

//initialize state array
for(r = 0; r < 4; r = r + 1)
begin
    for(c = 0; c < Nb; c = c + 1)
    begin
        assign s[r][c] = in[r + 4*c];
    end
end

Mux2to1  	  mux1(sSel, s, state, outMux1);
dReg          sReg(clk, enS, outMux1, cs);
AddRoundKey   u1(cs, {w[3],w[2],w[1],w[0]}, sprime);
Mux2to1       mux2(aSel, cs, sprime, outMux2);
SubBytes      u2(outMux2,A);    
ShiftRows     u3(A,B);
MixColumns    u4(B,C);
Mux2to1       mux3(rSel, C, B, outMux3);
GetRoundKey  #(Nr)key(w, counterStatus, rKey);
AddRoundKey   u5(outMux3, rKey, state); 

counterAES  upCounter(clk, loadEn, countEn, counterStatus); 
CU #(Nr) controller(GO, RST, clk, counterStatus, sSel, aSel, rSel, loadEn, countEn, enS, done);
   
// output array
for(r = 0; r < 4; r = r + 1)
begin  //cipher text
    for (c = 0; c < Nb; c = c + 1)
    begin
       assign csa[r + 4*c] = cs[r][c];
    end
end

triStateBuffer #(pWIDTH) buffer(csa,done,out);

endmodule


/*-------------------------------------------------------------------------
    AES cipher Top Level Module
-------------------------------------------------------------------------*/
module ENCRYPTION #(parameter Nk=4,Nr=10)
                   (clk,RST,GO,plaintext,ciphertext,key,done);

input  clk, RST, GO;
input  [7:0]   plaintext[15:0];//plaintext
input  [7:0]   key[(4*Nk)-1:0]; //128, 192, or 256-bit key
output [7:0]   ciphertext[15:0];
output done;

wire done2, GOAES;
wire [31:0] w[(4*(Nr+1))-1:0]; //round keys array of 32-bit words

keyExpansion #(Nk,Nr) keyExp(clk,GO, RST,key,w,done2);
AES  #(Nr) cipher(clk, GOAES, RST, plaintext, w, ciphertext, done);

assign GOAES = done2 & GO;

endmodule
