`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/27 13:50:29
// Design Name: 
// Module Name: time_clock_Sim
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


module time_clock_Sim(

    );
    reg CLK, EN, nCR, setTime;
    reg [23:0] nextTime;
    wire [23:0] currentTime;
    
    parameter PERIOD = 10;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end
    
    time_counter U0(CLK, EN, nCR, setTime, nextTime, currentTime);
    
    initial begin
        setTime = 0;
        nextTime = 0;
        nCR = 0;
        #20
        
        EN = 1;
        nCR = 1;
        #100
        
        setTime = 1;
        nextTime = {4'd2, 4'd3, 4'd5, 4'd9, 4'd5, 4'd0};
        #1
        setTime = 0;
        #1
        #10000
        
        $stop;
    end
    
endmodule
