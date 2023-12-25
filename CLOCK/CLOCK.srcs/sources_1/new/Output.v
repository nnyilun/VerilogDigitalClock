`timescale 1ns / 1ps
`include "params.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 11:47:03
// Design Name: 
// Module Name: Output
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


module Output(
    input reset_,
    input [`StatusBus] status,
    input [`TimeBus] currentTime,
    input [`TimeBus] alarmShow,
    input [`TimeBus] setShow,
    input ring,
    input onTimeAlarm,
    output reg [`ContentBus] content,
    output reg [`SwitchBus] Switch,
    output reg [`DotBus] Dot,
    output reg [`Bus32] Hour,
    output reg [`Bus64] Second,
    output runAlarm,
    output reg PM,
    output runFlicker,
    output [`StatusBus] StatusOut
    );
    assign runAlarm = ring;
    assign StatusOut = status;
    assign runFlicker = onTimeAlarm;
    reg [`Bus64] _min, _second;
    reg [`Bus32] _hour;
    always @ ( * ) begin
        if( ~reset_ ) begin
            Switch = 8'b11111111;
            Dot = 8'b00000000;
            content = 32'h88888888;
            Hour = 4'b0000;
            Second = 5'b00000;
            PM = 0; end
        else begin
            case(status)
                `showTime24: begin
                    content = {currentTime[23:16], 4'hf, currentTime[15:8], 4'hf, currentTime[7:0]};
                    Switch = 8'b11111111;
                    Dot = 8'b11111111;
                    _hour = currentTime[23:20] * 10 + currentTime[19:16];
                    _min = currentTime[15:12] * 10 + currentTime[11:8];
                    _second = currentTime[7:4] * 10 + currentTime[3:0];
                    Second = _second;
                    $display("_hour:%d, _min:%d, _second:%d, Second:%d", _hour, _min, _second, Second); 
                    /*if(_min == 0 && _second == 0)*/ Hour = _hour;
                    PM = 0;
                 end
                `showTime12: begin
                    _hour = currentTime[23:20] * 10 + currentTime[19:16];
                    _min = currentTime[15:12] * 10 + currentTime[11:8];
                    _second = currentTime[7:4] * 10 + currentTime[3:0]; 
                    Second = _second;
                    /*if(_min == 0 && _second == 0)*/ Hour = _hour - 12;
                    Switch = 8'b11111111;
                    Dot = 8'b11111111;
                    if(_hour == 0) begin // hour = 0
                        content = {8'h12, 4'hf, currentTime[15:8], 4'hf, currentTime[7:0]};
                        PM = 1; end
                    else if(_hour > 12) begin
                        content = {currentTime[23:20] - 4'h1, currentTime[19:16] - 4'h2, 4'hf, currentTime[15:8], 4'hf, currentTime[7:0]};
                        PM = 1; end
                    else begin 
                        content = {currentTime[23:16], 4'hf, currentTime[15:8], 4'hf, currentTime[7:0]};
                        PM = 0; end
                end
                `setTime: begin
                    _second = setShow[7:4] * 10 + setShow[3:0]; 
                    Second = _second;
                    Switch = 8'b11111111;
                    Dot = 8'b11111111;
                    if( setShow == 24'hffffff ) begin   
                        content = 32'hfffffdbe;
                        Switch = 8'b00000111; end
                    else content = {setShow[23:16], 4'hf, setShow[15:8], 4'hf, setShow[7:0]};
                end
                `setAlarm: begin
                    Switch = 8'b11111111;
                    Dot = 8'b11111111;
                    if( alarmShow == 24'hffffff ) begin
                        content = 32'hffffffac;
                        Switch = 8'b00000011; end
                    else content = {alarmShow[23:16], 4'hf, alarmShow[15:8], 4'hf, alarmShow[7:0]};
                end
                default: begin
                    Switch = 8'b11111111;
                    Dot = 8'b00000000;
                    content = 32'hefefefef;
                end
            endcase
        end
    end
endmodule
