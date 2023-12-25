`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 19:13:02
// Design Name: 
// Module Name: _set_time_top_Sim
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


module _set_time_top_Sim(

    );
    
    reg CLK;
    reg nCR;
    reg Enter, Up, Down, Right, Left;
    reg [1:0] status;
    
    wire [6:0] Seg7OUT;
    wire DP;
    wire [7:0] Valid;
    
    wire [1:0] status_lights;
    wire [3:0] direction_lights;
    
    _set_time_top_ U0(CLK, nCR, Enter, Up, Down, Right, Left, Seg7OUT, DP, Valid, status_lights, direction_lights);
    
    parameter PERIOD = 10;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end
    
    initial begin
        nCR = 0;
        status = 2'b00;
        #10
        nCR = 1;
        #10
        status = 2'b10;
        #10
    
        Up = 0;
        #30
        Up = 1;
        #30
        Up = 0;
        #30
        Up = 1;
        #30
        Up = 0;
        #30
        Up = 1;
        #30
        Up = 0;
        #10

        $stop;
    
    end
endmodule
