`timescale 1ns / 1ps
`include "params.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 11:47:03
// Design Name: 
// Module Name: Mode
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


module Mode(
    input CLK,
    input nCR,
    input Enter,
    output reg [`StatusBus] status
    );
    parameter S0 = `showTime24, S1 = `showTime12, S2 = `setTime, S3 = `setAlarm;
    reg [`StatusBus] currentStatus, nextStatus;
    
    always @ ( posedge CLK, negedge nCR ) begin
        if( ~nCR ) currentStatus <= S0;
        else currentStatus <= nextStatus;
    end
    
    always @ ( posedge Enter ) begin
        case(currentStatus)
            S0: nextStatus = S1;
            S1: nextStatus = S2;
            S2: nextStatus = S3;
            S3: nextStatus = S0;
            default: nextStatus = S0;
        endcase
    end
    
    always @ ( posedge CLK or negedge nCR ) begin
        if( ~nCR ) begin
            status <= S0;
            $display("1"); end
        else begin 
            status <= currentStatus;
            $display("2"); end
    end
endmodule
