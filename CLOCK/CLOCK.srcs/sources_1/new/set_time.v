`timescale 1ns / 1ps
`include "params.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 02:24:12
// Design Name: 
// Module Name: set_time
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


module set_time(
    input CLK_1kHz,
    input nCR,
    input [`StatusBus] status,
    input [`TimeBus] currentTime,
    input Up,
    input Down,
    input Right,
    input Left,
    output reg setTime,
    output reg [`TimeBus] nextTime,
    output reg [`TimeBus] setShow
    );
    reg symbol;
    reg [`TimeBus] next_setTime;
    reg [1:0] Upos, Dpos, Rpos, Lpos;
    reg [2:0] bit;
    reg [9:0] counter;
    
    always @ ( posedge CLK_1kHz or negedge nCR ) begin
        if( ~nCR ) begin
            counter <= 10'b0000000000;
            bit <= 3'b000; 
            symbol <= 0;
            setTime <= 0;
            nextTime <= 24'hffffff;
            setShow <= 24'hffffff; end
        else begin
            if(status == `setTime && symbol == 0) begin
                next_setTime <= currentTime;
                symbol <= 1;
                bit <= 3'b000;
                setShow <= currentTime; end
            else if(status == `setTime && symbol == 1) begin
                setShow <= next_setTime;
                if( Upos == 2'b01 )
                    case(bit) 
                        0: if(next_setTime[3:0] < 9) next_setTime[3:0] = next_setTime[3:0] + 1;
                        1: if(next_setTime[7:4] < 5) next_setTime[7:4] = next_setTime[7:4] + 1;
                        2: if(next_setTime[11:8] < 9) next_setTime[11:8] = next_setTime[11:8] + 1;
                        3: if(next_setTime[15:12] < 5) next_setTime[15:12] = next_setTime[15:12] + 1;
                        4: if(next_setTime[19:16] < 9 && next_setTime[23:20] < 2 || next_setTime[19:16] < 3 && next_setTime[23:20] == 2) next_setTime[19:16] = next_setTime[19:16] + 1;
                        5: if(next_setTime[23:20] < 2 && next_setTime[19:16] <= 3 || next_setTime[23:20] < 1 && next_setTime[19:16] <= 9) next_setTime[23:20] = next_setTime[23:20] + 1;
                        default: next_setTime = 24'h000000;
                    endcase
                else if( Dpos == 2'b01 )
                    case(bit) 
                        0: if(next_setTime[3:0] > 0) next_setTime[3:0] = next_setTime[3:0] - 1;
                        1: if(next_setTime[7:4] > 0) next_setTime[7:4] = next_setTime[7:4] - 1;
                        2: if(next_setTime[11:8] > 0) next_setTime[11:8] = next_setTime[11:8] - 1;
                        3: if(next_setTime[15:12] > 0) next_setTime[15:12] = next_setTime[15:12] - 1;
                        4: if(next_setTime[19:16] > 0) next_setTime[19:16] = next_setTime[19:16] - 1;
                        5: if(next_setTime[23:20] > 0) next_setTime[23:20] = next_setTime[23:20] - 1;
                        default: next_setTime = 24'h000000;
                    endcase
                else if( Rpos == 2'b01  && bit > 0) bit = bit - 1;
                else if( Lpos == 2'b01  && bit < 5) bit = bit + 1;
                
            end
            else if(status != `setTime && symbol == 1) begin
                counter <= 10'd1000;
                symbol <= 0;
                setTime <= 1;
                nextTime <= setShow; end
            else if(status != `setTime && symbol == 0 && counter > 0) counter <= counter - 1;
            else if(status != `setTime && symbol == 0 && counter == 0) setTime <= 0;
        end
    end
    
    always @ ( posedge CLK_1kHz ) begin
        Upos = {Upos[0], Up};
        Dpos = {Dpos[0], Down};
        Rpos = {Rpos[0], Right};
        Lpos = {Lpos[0], Left};
    end
 
//    always @ ( posedge CLK_1kHz ) begin
//        if(status == `setTime && symbol == 1)
//        if( Upos == 2'b01 )
//            case(bit) 
//                0: if(next_setTime[3:0] < 9) next_setTime[3:0] = next_setTime[3:0] + 1;
//                1: if(next_setTime[7:4] < 5) next_setTime[7:4] = next_setTime[7:4] + 1;
//                2: if(next_setTime[11:8] < 9) next_setTime[11:8] = next_setTime[11:8] + 1;
//                3: if(next_setTime[15:12] < 5) next_setTime[15:12] = next_setTime[15:12] + 1;
//                4: if(next_setTime[19:16] < 9 && next_setTime[23:20] < 2 || next_setTime[19:16] < 3 && next_setTime[23:20] == 2) next_setTime[19:16] = next_setTime[19:16] + 1;
//                5: if(next_setTime[23:20] < 2) next_setTime[23:20] = next_setTime[23:20] + 1;
//                default: next_setTime = 24'h000000;
//            endcase
//        else if( Dpos == 2'b01 )
//            case(bit) 
//                0: if(next_setTime[3:0] > 0) next_setTime[3:0] = next_setTime[3:0] - 1;
//                1: if(next_setTime[7:4] > 0) next_setTime[7:4] = next_setTime[7:4] - 1;
//                2: if(next_setTime[11:8] > 0) next_setTime[11:8] = next_setTime[11:8] - 1;
//                3: if(next_setTime[15:12] > 0) next_setTime[15:12] = next_setTime[15:12] - 1;
//                4: if(next_setTime[19:16] > 0) next_setTime[19:16] = next_setTime[19:16] - 1;
//                5: if(next_setTime[23:20] > 0) next_setTime[23:20] = next_setTime[23:20] - 1;
//                default: next_setTime = 24'h000000;
//            endcase
//        else if( Rpos == 2'b01  && bit > 0) bit = bit - 1;
//        else if( Lpos == 2'b01  && bit < 5) bit = bit + 1;
//    end
endmodule
