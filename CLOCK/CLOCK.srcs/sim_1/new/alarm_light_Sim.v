`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 17:12:24
// Design Name: 
// Module Name: alarm_light_Sim
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


module alarm_light_Sim(

    );
    reg CLK;
    reg runAlarm;
    wire Out;
    alarm_light U0(CLK, runAlarm, Out);
    
    parameter PERIOD = 10;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end
    
    initial begin
        runAlarm = 0;
        #10
        
        #1
        runAlarm = 1;
        #1;
        runAlarm = 0;
        #10000
        $stop;
    end
endmodule
