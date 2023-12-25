`timescale 1ns / 1ps
`include "params.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 11:47:03
// Design Name: 
// Module Name: time_counter
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


module time_counter(
    input Clk_1Hz,
    input EN, nCR, 
    input setTime,
    input [`TimeBus] nextTime,
    output [`TimeBus] currentTime,
    output reg runFlicker
    );
    reg [4:0] Carry; // C_H0, C_Min1, C_Min0, C_Sec1, C_Sec0
    reg [`TimeBus] _Time, next_time;
    reg symbol;
    assign currentTime = _Time;
    always @ ( posedge Clk_1Hz or negedge nCR or posedge setTime ) begin
        if( ~nCR ) begin
            runFlicker = 0;
            symbol <= 0;
            next_time <= 24'hffffff;
            _Time <= 24'h000000;
            Carry <= 5'b00000; end
        else if( setTime ) begin 
            next_time <= nextTime;
            symbol <= 1; end
        else if( symbol == 1 ) begin
            _Time <= next_time;
            symbol <= 0; end
        else if( EN && symbol == 0 ) begin
                if(_Time[3:0] == 9) begin
                    _Time[3:0] = 4'b0000;
                    Carry[0] = 1; end
                else begin 
                    _Time[3:0] = _Time[3:0] + 1;
                    runFlicker = 0; end
                
                if(Carry[0] == 1) begin
                    Carry[0] = 0;
                    if( _Time[7:4] == 5 ) begin
                        _Time[7:4] = 4'b0000;
                        Carry[1] = 1; end
                    else _Time[7:4] = _Time[7:4] + 1;
                end
                
                if(Carry[1] == 1) begin
                    Carry[1] = 0;
                    if( _Time[11:8] == 9 ) begin
                        _Time[11:8] = 4'b0000;
                        Carry[2] = 1; end
                    else _Time[11:8] = _Time[11:8] + 1;
                end
    
                if(Carry[2] == 1) begin
                    Carry[2] = 0;
                    if( _Time[15:12] == 5 ) begin
                        _Time[15:12] = 4'b0000;
                        Carry[3] = 1; 
                        runFlicker = 1; end
                    else _Time[15:12] = _Time[15:12] + 1;
                end  
                
                if(Carry[3] == 1) begin
                    Carry[3] = 0;
                    if( _Time[19:16] == 9 && _Time[23:20] != 2 || _Time[19:16] == 3 && _Time[23:20] == 2) begin
                        _Time[19:16] = 4'b0000;
                        Carry[4] = 1; end
                    else _Time[19:16] = _Time[19:16] + 1;
                end
                
                if(Carry[4] == 1) begin
                    Carry[4] = 0;
                    if( _Time[23:20] == 2 ) begin
                        _Time[23:20] = 4'b0000; end
                    else _Time[23:20] = _Time[23:20] + 1;
                end
        end
    end
endmodule
