`timescale 1ns / 1ps
`include "params.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 16:39:08
// Design Name: 
// Module Name: alarm
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


module alarm(
    input CLK_1kHz,
    input nCR,
    input [`StatusBus] status,
    input AlarmOn,
    input Up,
    input Down,
    input Right,
    input Left,
    input [`TimeBus] currentTime,
    output AlarmOnLight,
    output reg ring,
    output reg [`TimeBus] alarmShow
    );
    reg [`TimeBus] _alarm_time, next_alarmTime;
    reg [1:0] Upos, Dpos, Rpos, Lpos;
    reg symbol;
    reg [2:0] bit;
    assign AlarmOnLight = AlarmOn;
    always @ ( posedge CLK_1kHz or negedge nCR ) begin
        if( ~nCR ) begin
            _alarm_time <= 24'h000000;
            ring <= 0;
            alarmShow <= 24'hffffff; 
            symbol <= 0;
            bit <= 3'b000; end
        else begin
            if( AlarmOn == 1 && currentTime == _alarm_time - 1 && ring == 0 ) ring <= 1;
            else if( ring == 1 ) ring <= 0;
            
            if(status == `setAlarm && symbol == 0) begin
                next_alarmTime <= currentTime;
                symbol <= 1;
                bit <= 3'b000;
                alarmShow <= currentTime; end
            else if(status == `setAlarm && symbol == 1) begin
                alarmShow <= next_alarmTime;
                if( Upos == 2'b01 )
                    case(bit) 
                        0: if(next_alarmTime[3:0] < 9) next_alarmTime[3:0] = next_alarmTime[3:0] + 1;
                        1: if(next_alarmTime[7:4] < 5) next_alarmTime[7:4] = next_alarmTime[7:4] + 1;
                        2: if(next_alarmTime[11:8] < 9) next_alarmTime[11:8] = next_alarmTime[11:8] + 1;
                        3: if(next_alarmTime[15:12] < 5) next_alarmTime[15:12] = next_alarmTime[15:12] + 1;
                        4: if(next_alarmTime[19:16] < 9 && next_alarmTime[23:20] < 2 || next_alarmTime[19:16] < 3 && next_alarmTime[23:20] == 2) next_alarmTime[19:16] = next_alarmTime[19:16] + 1;
                        5: if(next_alarmTime[23:20] < 2 && next_alarmTime[19:16] <= 3 || next_alarmTime[23:20] < 1 && next_alarmTime[19:16] <= 9) next_alarmTime[23:20] = next_alarmTime[23:20] + 1;
                        default: next_alarmTime = 24'h000000;
                    endcase
                else if( Dpos  == 2'b01 )
                    case(bit) 
                        0: if(next_alarmTime[3:0] > 0) next_alarmTime[3:0] = next_alarmTime[3:0] - 1;
                        1: if(next_alarmTime[7:4] > 0) next_alarmTime[7:4] = next_alarmTime[7:4] - 1;
                        2: if(next_alarmTime[11:8] > 0) next_alarmTime[11:8] = next_alarmTime[11:8] - 1;
                        3: if(next_alarmTime[15:12] > 0) next_alarmTime[15:12] = next_alarmTime[15:12] - 1;
                        4: if(next_alarmTime[19:16] > 0) next_alarmTime[19:16] = next_alarmTime[19:16] - 1;
                        5: if(next_alarmTime[23:20] > 0) next_alarmTime[23:20] = next_alarmTime[23:20] - 1;
                        default: next_alarmTime = 24'h000000;
                    endcase
                else if( Rpos == 2'b01 && bit > 0) bit = bit - 1;
                else if( Lpos == 2'b01 && bit < 5) bit = bit + 1;
            
            end
            else if(status != `setAlarm && symbol == 1) begin
                symbol <= 0;
                _alarm_time <= alarmShow; end
        end
    end
    
    always @ ( posedge CLK_1kHz ) begin
        Upos = {Upos[0], Up};
        Dpos = {Dpos[0], Down};
        Rpos = {Rpos[0], Right};
        Lpos = {Lpos[0], Left};
    end
    
//    always @ ( posedge Up, posedge Down, posedge Right, posedge Left ) begin
//        if( status == `setAlarm && symbol == 1 ) begin
//            if( Up )
//                case(bit) 
//                    0: if(alarmShow[3:0] < 9) alarmShow[3:0] = alarmShow[3:0] + 1;
//                    1: if(alarmShow[7:4] < 5) alarmShow[7:4] = alarmShow[7:4] + 1;
//                    2: if(alarmShow[11:8] < 9) alarmShow[11:8] = alarmShow[11:8] + 1;
//                    3: if(alarmShow[15:12] < 5) alarmShow[15:12] = alarmShow[15:12] + 1;
//                    4: if(alarmShow[19:16] < 9 && alarmShow[23:20] < 2 || alarmShow[19:16] < 3 && alarmShow[23:20] == 2) alarmShow[19:16] = alarmShow[19:16] + 1;
//                    5: if(alarmShow[23:20] < 2) alarmShow[23:20] = alarmShow[23:20] + 1;
//                    default: alarmShow = 24'h000000;
//                endcase
//            else if( Down )
//                case(bit) 
//                    0: if(alarmShow[3:0] > 0) alarmShow[3:0] = alarmShow[3:0] - 1;
//                    1: if(alarmShow[7:4] > 0) alarmShow[7:4] = alarmShow[7:4] - 1;
//                    2: if(alarmShow[11:8] > 0) alarmShow[11:8] = alarmShow[11:8] - 1;
//                    3: if(alarmShow[15:12] > 0) alarmShow[15:12] = alarmShow[15:12] - 1;
//                    4: if(alarmShow[19:16] > 0) alarmShow[19:16] = alarmShow[19:16] - 1;
//                    5: if(alarmShow[23:20] > 0) alarmShow[23:20] = alarmShow[23:20] - 1;
//                    default: alarmShow = 24'h000000;
//                endcase
//            else if( Right && bit > 0) bit = bit - 1;
//            else if( Left && bit < 5) bit = bit + 1;
//        end
//    end
endmodule
