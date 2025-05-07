`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2025 21:36:31
// Design Name: 
// Module Name: clkdiv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:+

// 
//////////////////////////////////////////////////////////////////////////////////


module clkdiv(
    input clk_100,
    output clk_200,
    output clk1
    );
    assign clk1=clk_100;
    reg [15:0]count = 16'h0;
    reg clkres=1'b0;
    
    always @(posedge clk_100) begin
    if (count==16'hFA) begin
    count<=0;
    clkres<=~clkres;
    end
    
    else begin
    count<=count+1;
    end
    end
    assign clk_200=clkres;
endmodule
