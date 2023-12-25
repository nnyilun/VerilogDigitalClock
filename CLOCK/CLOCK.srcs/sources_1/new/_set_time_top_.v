`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 19:06:17
// Design Name: 
// Module Name: _set_time_top_
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


module _set_time_top_(
    input CLK_100MHz,
    input nCR,
    input Enter, Up, Down, Right, Left,
    
    
    output [`Seg7Bus] Seg7OUT,
    output DP,
    output [`SwitchBus] Valid,
    
    output [`StatusBus] status_lights, 
    output [`DirLightsBus] direction_lights
    );
    wire CLK_1kHz;
    wire _Enter, _Up, _Down, _Right, _Left;
    
    wire setTime;
    wire [`TimeBus] setShow, nextTime;
    wire [`Bus32] Hour;
    wire [`Bus64] Second;
    wire ring, runAlarm, PM;
    wire [1:0] status;
    
    wire [`ContentBus] content;
    wire [`SwitchBus] Switch;
    wire [`DotBus] Dot;
    
    frequency_div#(.NEED_FREQ(1000)) CLK1K(CLK_100MHz, nCR, CLK_1kHz);
    
    filter _enter(Enter, CLK_1kHz, _Enter);
    filter _up(Up, CLK_1kHz, _Up);
    filter _down(Down, CLK_1kHz, _Down);
    filter _right(Right, CLK_1kHz, _Right);
    filter _left(Left, CLK_1kHz, _Left);
    
    assign direction_lights = {_Up, _Down, _Left, _Right};
    
    Mode M0(CLK_1kHz, nCR, _Enter, status);
    set_time ST0(CLK_1kHz, nCR, status, 24'h000000, 
        _Up, _Down, _Right, _Left,
        setTime, nextTime, setShow);
    
    Output O0(nCR, status, 24'h000000, 24'h000000, setShow, ring, 
        content, Switch, Dot, Hour, Second, runAlarm, PM, status_lights);
    Seg7_driver SD0(CLK_1kHz, nCR, content, Switch, Dot, Valid, Seg7OUT, DP);
    
endmodule
