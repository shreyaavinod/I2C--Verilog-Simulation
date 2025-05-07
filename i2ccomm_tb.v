`timescale 1ns / 1ps

module i2ccomm_tb;

    reg clk;
    wire sda;
    wire scl;
    wire [7:0] temp;
    wire [11:0]counter;
    wire clk200;
    wire [4:0]c1;

    // Instantiate the DUT (Device Under Test)
    i2ccomm uut (
        .clk(clk),
        .sda(sda),
        .scl(scl),
        .temp(temp),
        .counter(counter),
        .clk200(clk200),
        .c1(c1)
    );

    // Clock generation (100MHz clock -> 10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | SDA=%b | SCL=%b | Temp=%h", $time, sda, scl, temp);
    end

    // Simulation runtime
    initial begin
        #2000; // Run the simulation for a while
        $finish;
    end

endmodule
