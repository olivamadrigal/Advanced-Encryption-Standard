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
	Description:  Test bench
	
        CMPE 297    

*************************************************************************************/

module aes_tb;

/* these parameters must be changed depending on the key size*/
parameter Nk = 8;  //cols of key (4, 6, or 8)
parameter Nr = 14; //rounds      10, 12, or 14

reg   clk, RST, GO;
reg   [127:0]  in, expected;
reg   [((8*4*Nk)-1):0]keyinput;
wire  [7:0]    key[(4*Nk)-1:0]; //128, 192, or 256-bit key
wire  [7:0]    expectedAry[15:0];
wire  [7:0]    plaintext[15:0];//plaintext
wire  [7:0]    ciphertext[15:0];
wire done;

genvar i;
//intialize control signals
initial
begin
    GO <=1'b0; RST <=1'b1; #10;
    GO <=1'b1; RST <=1'b0; #10;
end

//test vector for AES-128
/*
assign in       = 128'h00112233445566778899aabbccddeeff;
assign keyinput = 128'h000102030405060708090a0b0c0d0e0f;
assign expected = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
*/

//test vector for AES-192
/*
assign in       = 128'h00112233445566778899aabbccddeeff;
assign keyinput = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
assign expected = 128'hdda97ca4864cdfe06eaf70a0ec0d7191;
*/


//test vector for AES-256
assign in       = 128'h00112233445566778899aabbccddeeff;
assign keyinput = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
assign expected = 128'h8ea2b7ca516745bfeafc49904b496089;


//format inputs
    for(i = 0; i < (4*Nk); i = i + 1)
    begin  
        assign key[(4*Nk)-i-1]         = keyinput[(8*(i+1) -1):(8*i)];
    end
    
    for(i = 0; i < 16; i = i + 1)
    begin  
        assign plaintext[16-i-1]   = in[(8*(i+1) -1):(8*i)];
        assign expectedAry[16-i-1] = expected[(8*(i+1) -1):(8*i)];
    end

ENCRYPTION #(Nk,Nr) DUT(clk,RST,GO,plaintext,ciphertext,key,done);

//clock
always
begin
     clk <= 1'b1; #5;
     clk <= 1'b0; #5;
end


//verify result
always@(negedge clk)
begin
    if(done)
    begin
        if(ciphertext == expectedAry)
                begin
                $display("ENCRYPTION SUCCESSFUL CIPHERTEXT.\n");#5;
                $stop;      
                end
        else
                begin
                $display("ERROR: ciphertext does not match expected test vector\n");#5;
                $stop;
                end
     end
end


endmodule
