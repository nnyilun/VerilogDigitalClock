`timescale 1ns / 1ps
`include "params.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 17:05:47
// Design Name: 
// Module Name: hour_flicker
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


module hour_flicker(
    input CLK_1Hz,
    input run,
    input [`Bus32] Hour,
    output reg Out
    );
    reg [`Bus64] counter;
    always @ ( posedge CLK_1Hz ) begin
        if( run ) begin
            counter = Hour * 2 + 1; 
            Out = 0; end
    
        if(counter > 01) begin
            counter <= counter - 1;
            Out <= ~Out; end
    end
endmodule
