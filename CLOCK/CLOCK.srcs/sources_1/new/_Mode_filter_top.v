`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 00:49:29
// Design Name: 
// Module Name: _Mode_filter_top
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


module _Mode_filter_top(
    input CLK_100MHz,
//    input CLK,
    input nCR,
    input Enter,
    input button,
    output [1:0] status,
    output light,
    output light2
    );
    wire CLK_1kHz, _Enter, CLK_1Hz;
    assign light2 = button;
    frequency_div#(.NEED_FREQ(1000)) U1(CLK_100MHz, nCR, CLK_1kHz);
    frequency_div#(.NEED_FREQ(1)) U2(CLK_100MHz, nCR, CLK_1Hz);
    assign light = CLK_1Hz;
    filter F_Enter(Enter, CLK_1kHz, _Enter);
    Mode U0(CLK_1kHz, nCR, _Enter, status);
endmodule
