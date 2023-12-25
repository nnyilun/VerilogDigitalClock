`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 18:47:25
// Design Name: 
// Module Name: Seg7_driver_Sim
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


module Seg7_driver_Sim(

    );
    reg Clk;
    reg reset;
    reg [31:0] content;
    reg [7:0] Switch;
    reg [7:0] Dot;
    wire [7:0] Valid;
    wire [6:0] Out;
    wire DP;
    
    Seg7_driver U0(Clk, reset, content, Switch, Dot, Valid, Out, DP);
    
    parameter PERIOD = 10;

    always begin
        Clk = 1'b0;
        #(PERIOD/2) Clk = 1'b1;
        #(PERIOD/2);
     end
    
    initial begin
        reset = 0;
        #10
        reset = 1;
        Switch = 8'b11111111;
        Dot = 8'b11001110;
        content = 32'h87654321;
        #10000;
        $stop;
    end
    
endmodule
