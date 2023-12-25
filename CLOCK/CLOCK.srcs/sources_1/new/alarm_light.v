`timescale 1ns / 1ps
`include "params.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 16:58:57
// Design Name: 
// Module Name: alarm_light
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


module alarm_light #( parameter n = 60 ) (
    input CLK_20Hz,
    input runAlarm,
    output reg Out
    ); 
    reg [`Bus64] counter;
    always @ ( posedge CLK_20Hz or posedge runAlarm ) begin
        if( runAlarm ) begin
            counter <= n;
            Out <= 0; end
        else if( counter > 0 ) begin
            counter <= counter - 1;
            Out <= ~Out; end
    end
endmodule
