`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 15:43:56
// Design Name: 
// Module Name: set_time_Sim
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


module set_time_Sim(

    );
    reg CLK;
    reg nCR;
    reg [1:0] status;
    reg [23:0] currentTime;
    reg Up;
    reg Down;
    reg Right;
    reg Left;
    wire setTime;
    wire [23:0] nextTime;
    wire [23:0] setShow;
    
    parameter PERIOD = 10;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end
    
    set_time U0(CLK, nCR, status, currentTime, Up, Down, Right, Left, setTime, nextTime, setShow);
    
    initial begin
        nCR = 0;
        status = 2'b01;
        #10
        nCR = 1;
        Up = 0;
        Down = 0;
        Right = 0;
        Left = 0;
        
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6};
        #10
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd7};
        #10
        status = 2'b10;
        currentTime = {4'd1, 4'd2, 4'd5, 4'd0, 4'd0, 4'd0};
        #30
        Up = 1;
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd9};
        #30
        currentTime = {4'd1, 4'd2, 4'd3, 4'd5, 4'd0, 4'd0};
        #30
        Up = 0;
        
        Left = 1;
        #30
        Left = 0;
        #30
        Left = 1;
        #30
        Left = 0;
        #30
        Left = 1;
        #30
        Left = 0;
        #30
        Left = 1;
        #30
        Left = 0;
        #30
        Left = 1;
        #30
        Left = 0;
        #30
        Left = 1;
        #30
        Left = 0;
        #30
        
        Right = 1;
        #30
        Right = 0;
        #30
        Right = 1;
        #30
        Right = 0;
        #30
        Down = 1;
        #30
        Down = 0;
        #30
        Down = 1;
        #30
        Down = 0;
        #30
        Down = 1;
        #30
        Down = 0;
        #30
        Down = 1;
        #30
        Down = 0;
        #30
        Down = 1;
        #30
        Down = 0;
        #30
        Down = 1;
        #30
        Down = 0;
        #30
        Down = 1;
        #30
        Down = 0;
        #30
        
        status = 2'b11;
        #10
        status = 2'b00;
        #10
        $stop;
        
    
    end
endmodule
