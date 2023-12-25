`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 00:23:05
// Design Name: 
// Module Name: Output_Sim
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


module Output_Sim(

    );
    reg reset_;
    reg [1:0] status;
    reg [23:0] currentTime;
    reg [23:0] alarmShow;
    reg [23:0] setShow;
    reg ring, onTimeAlarm;
    wire [31:0] content;
    wire [7:0] Switch;
    wire [7:0] Dot;
    wire [4:0] Hour;
    wire [5:0] Second;
    wire runAlarm;
    wire PM;
    wire runFlicker;
    wire [1:0] StatusOut;
    
    Output U0(reset_, status, currentTime, alarmShow, setShow, ring, onTimeAlarm, 
        content, Switch, Dot, Hour, Second, runAlarm, PM, runFlicker, StatusOut);
    
    initial begin
        reset_ = 0;
        #10
        reset_ = 1;
        #10
        status = 2'b00;
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6};
        #10
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd7};
        #10
        currentTime = {4'd1, 4'd2, 4'd0, 4'd0, 4'd0, 4'd0};
        #10
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd9};
        #10
        currentTime = {4'd1, 4'd2, 4'd3, 4'd5, 4'd0, 4'd0};
        #10
        
        status = 2'b01;
        currentTime = {4'd1, 4'd5, 4'd0, 4'd0, 4'd0, 4'd0};
        #10
        currentTime = {4'd1, 4'd5, 4'd3, 4'd4, 4'd0, 4'd2};
        #10
        currentTime = {4'd1, 4'd2, 4'd0, 4'd0, 4'd0, 4'd0};
        #10
        currentTime = {4'd0, 4'd0, 4'd3, 4'd4, 4'd5, 4'd9};
        #10
        currentTime = {4'd0, 4'd7, 4'd1, 4'd4, 4'd0, 4'd0};
        #10
        
        setShow = 24'hffffff;
        status = 2'b10;
        #10
        setShow = {4'd0, 4'd7, 4'd1, 4'd4, 4'd0, 4'd0};
        #10
        setShow = {4'd0, 4'd8, 4'd1, 4'd0, 4'd4, 4'd0};
        #10
        setShow = {4'd2, 4'd2, 4'd2, 4'd2, 4'd2, 4'd2};
        #10
        
        alarmShow = 24'hffffff;
        status = 2'b11;
        #10
        alarmShow = {4'd0, 4'd7, 4'd1, 4'd4, 4'd0, 4'd0};
        #10
        alarmShow = {4'd0, 4'd8, 4'd1, 4'd0, 4'd4, 4'd0};
        #10
        alarmShow = {4'd2, 4'd2, 4'd2, 4'd2, 4'd2, 4'd2};
        #10
        
        status = 2'b00;
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6};
        #10
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd7};
        #10
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd8};
        #10
        currentTime = {4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd9};
        #10
        currentTime = {4'd1, 4'd2, 4'd3, 4'd5, 4'd0, 4'd0};
        #10
        
        ring = 1;
        #10
        $stop;
    end
endmodule
