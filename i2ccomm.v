`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2025 21:35:24
// Design Name: 
// Module Name: i2ccomm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module i2ccomm(
    input clk,
    inout sda,
    output scl,
    output [7:0] temp,
    output[11:0]counter,
    output clk200,
    output [4:0]c1
    );
    
    wire clk1,clk_200;
    
    clkdiv clkd(clk,clk_200,clk1);
    
    assign clk200=clk_200;
    
    reg [7:0]slaveread= 8'b10010111;
    reg [7:0]tmsb=8'b0;
    reg [7:0]tlsb=8'b0;
    reg op=1'b1;
    wire ip;
    reg [7:0]tempreg;
    
    localparam [4:0]idle=5'h00;
    localparam [4:0]start=5'h01;
    localparam [4:0]slave7=5'h02;
    localparam [4:0]slave6=5'h03;
    localparam [4:0]slave5=5'h04;
    localparam [4:0]slave4=5'h05;
    localparam [4:0]slave3=5'h06;
    localparam [4:0]slave2=5'h07;
    localparam [4:0]slave1=5'h08;
    localparam [4:0]slave0=5'h09;
    localparam [4:0]rxack=5'h0A;
    localparam [4:0]msb1=5'h0B;
    localparam [4:0]msb2=5'h0C;
    localparam [4:0]msb3=5'h0D;
    localparam [4:0]msb4=5'h0E;
    localparam [4:0]msb5=5'h0F;
    localparam [4:0]msb6=5'h10;
    localparam [4:0]msb7=5'h11;
    localparam [4:0]msb0=5'h12;
    localparam [4:0]sendack=5'h13;
    localparam [4:0]lsb1=5'h14;
    localparam [4:0]lsb2=5'h15;
    localparam [4:0]lsb3=5'h16;
    localparam [4:0]lsb4=5'h17;
    localparam [4:0]lsb5=5'h18;
    localparam [4:0]lsb6=5'h19;
    localparam [4:0]lsb7=5'h1A;
    localparam [4:0]lsb0=5'h1B;
    localparam [4:0]sendack1=5'h1C;
    
    reg [4:0]state=idle;
    
    reg [11:0]count=12'b0;
    reg clockres=1'b1;
    reg [4:0]c=5'd0;
 //scl generation 
 always @(posedge clk_200)begin
 if (c==5'd9)begin
 clockres <=~clockres;
 c<=0;
 end
 else begin
 c<=c+1;
 end
 end
 assign scl=clockres;
 
 assign c1=c;
 
    
    
  always @(posedge clk_200)begin
    if (count == 0)begin
    op<=1;
    state<=start;
    count<=count+1;
    end
    else begin
    count<=count+1;
    case (state)
    
    start: begin
    if (count == 5)
    op<=1'b0;
    if (count == 13)
    state<=slave7;
    end
    
    slave7: begin
    op<=slaveread[7];
    if (count == 33)
    state<=slave6;
    end
    
    slave6: begin
    op<=slaveread[6];
    if (count == 54)
    state<=slave5;
    end   
    
    slave5: begin
    op<=slaveread[5];
    if (count == 74)
    state<=slave4;
    end 
    
    slave4: begin
    op<=slaveread[4];
    if (count == 94)
    state<=slave3;
    end
    
    slave3: begin
    op<=slaveread[3];
    if (count == 114)
    state<=slave2;
    end
    
    slave2: begin
    op<=slaveread[2];
    if (count == 134)
    state<=slave1;
    end
    
    slave1: begin
    op<=slaveread[1];
    if (count == 154)
    state<=slave0;
    end
    
    slave0: begin
    op<=slaveread[0];
    if (count == 174)
    state<=rxack;   
    end
    
    rxack: begin 
    if (count == 194)
    state <= msb7;
    end
    
    msb7: begin
    tmsb[7] <= ip;
    if (count == 214)
    state <= msb6;
    end
    
    msb6: begin
    tmsb[6] <= ip;
    if (count == 234)
    state <= msb5;
    end
    
    msb5: begin
    tmsb[5] <= ip;
    if (count == 254)
    state <= msb4;
    end
    
    msb4: begin
    tmsb[4] <= ip;
    if (count == 264)
    state <= msb3;
    end
    
    msb3: begin
    tmsb[3] <= ip;
    if (count == 274)
    state <= msb2;
    end
    
    msb2: begin
    tmsb[2] <= ip;
    if (count == 294)
    state <= msb1;
    end
    
    msb1: begin
    tmsb[1] <= ip;
    if (count == 314)
    state <= msb0;
    end
    
    msb0: begin
    tmsb[0] <= ip;
    if (count == 334)
    state <= sendack;
    end
    
    sendack:begin
    op<=1'b0;
    if(count == 354)
    state <= lsb7;
    end
    
    lsb7: begin
    tlsb[7] <= ip;
    if (count == 374)
    state <= lsb6;
    end    
    
    lsb6: begin
    tlsb[6] <= ip;
    if (count == 394)
    state <= lsb5;
    end   
    
    lsb5: begin
    tlsb[5] <= ip;
    if (count == 414)
    state <= lsb4;
    end   
    
    lsb4: begin
    tlsb[4] <= ip;
    if (count == 434)
    state <= lsb3;
    end   
    
    lsb3: begin
    tlsb[3] <= ip;
    if (count == 454)
    state <= lsb2;
    end   
    
    lsb2: begin
    tlsb[2] <= ip;
    if (count == 474)
    state <= lsb1;
    end   
    
    lsb1: begin
    tlsb[1] <= ip;
    if (count == 494)
    state <= lsb0;
    end   
    
    lsb0: begin
    op<=1'b1;    
    tlsb[0] <= ip;
    if (count == 514)
    state <= sendack1;
    end     
    
    sendack1: begin
    op<=1'b1;
    if(count == 534)
    state <= idle;
    end
    
    endcase
    end
    end
    
    
    assign sda_op =(state==idle || state==start || state==slave7 || state==slave6 ||state==slave5 ||state==slave4 ||state==slave3 ||state==slave2 ||state==slave1 ||state==slave0 || start==sendack || start==sendack1)?1:0;
    assign sda=sda_op?op:1'bz;
    assign ip=sda;
    assign counter=count;
    assign temp={tmsb[6:0],tlsb(7)};
  
    
    
endmodule
