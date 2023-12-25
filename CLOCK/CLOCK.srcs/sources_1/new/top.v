`timescale 1ns / 1ps
`include "params.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 14:21:34
// Design Name: 
// Module Name: top
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


module top(
    input CLK_100MHz,
    input nCR,
    input EN,
    input Enter, Up, Down, Right, Left,
    input AlarmOn,
    
    output [`Seg7Bus] Seg7OUT,
    output DP,
    output [`SwitchBus] Valid,
    
    output flicker_light,
    output Alarm_light,
    output PM_light,
    output AlarmOn_light,
    output [`StatusBus] status_lights, 
    output [`Bus64] second_lights,
    
    output [`DirLightsBus] direction_lights
    );
    wire CLK_1Hz, CLK_1kHz, CLK_20Hz;
    wire _Enter, _Up, _Down, _Right, _Left;
    wire [`StatusBus] status;
    
    wire setTime;
    wire [`TimeBus] currentTime, alarmShow, setShow, nextTime;
    wire [`Bus32] Hour;
    wire [`Bus64] Second;
    wire ring, runAlarm, PM, onTimeAlarm, runFlicker;
    
    wire [`ContentBus] content;
    wire [`SwitchBus] Switch;
    wire [`DotBus] Dot;
    
    assign direction_lights = {onTimeAlarm, onTimeAlarm, onTimeAlarm, onTimeAlarm};
    
    frequency_div#(.NEED_FREQ(1000)) CLK1K(CLK_100MHz, nCR, CLK_1kHz);
    frequency_div#(.NEED_FREQ(20)) CLK20(CLK_100MHz, nCR, CLK_20Hz);
    frequency_div#(.NEED_FREQ(1)) CLK1(CLK_100MHz, nCR, CLK_1Hz);
    
    filter _enter(Enter, CLK_1kHz, _Enter);
    filter _up(Up, CLK_1kHz, _Up);
    filter _down(Down, CLK_1kHz, _Down);
    filter _right(Right, CLK_1kHz, _Right);
    filter _left(Left, CLK_1kHz, _Left);
    
    Mode M0(CLK_1kHz, nCR, _Enter, status);
    Output O0(nCR, status, currentTime, alarmShow, setShow, ring, onTimeAlarm,
        content, Switch, Dot, Hour, Second, runAlarm, PM_light, runFlicker, status_lights);       
    Seg7_driver SD0(CLK_1kHz, nCR, content, Switch, Dot, Valid, Seg7OUT, DP);
    Second_Lights SL0(Second, second_lights);
    
    time_counter TC0(CLK_1Hz, EN, nCR, setTime, nextTime, currentTime, onTimeAlarm);
    set_time ST0(CLK_1kHz, nCR, status, currentTime, 
        _Up, _Down, _Right, _Left,
        setTime, nextTime, setShow);
        
    alarm A0(CLK_1kHz, nCR, status, AlarmOn, 
        _Up, _Down, _Right, _Left,
        currentTime, AlarmOn_light, ring, alarmShow);
    alarm_light AL0(CLK_20Hz, runAlarm, Alarm_light);
    
    hour_flicker HF0(CLK_1Hz, runFlicker, Hour, flicker_light);
endmodule
