`timescale 1ns / 1ps
`include "params.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 18:09:03
// Design Name: 
// Module Name: ID_to_Seg7
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


module Seg7_driver(
    input Clk,
    input nCR,
    input [`ContentBus] content,
    input [`SwitchBus] Switch,
    input [`DotBus] Dot,
    output reg [`SwitchBus] Valid,
    output reg [`Seg7Bus] Out,
    output reg DP 
    );
    reg [2:0] count = 0;
    wire [`Seg7Bus] OutTmp;
    ID_to_Seg7 _(content[count*4+:4], OutTmp);
    always @ ( posedge Clk or negedge nCR ) begin
        if( ~nCR ) begin
            count <= 0;
            DP = 1'b1;
            Out <= 8'b11111111;    
            Valid <= 8'b11111111; end
        else begin
            Out <= OutTmp;
            DP <= Dot[count];
            if( count == 7 ) count <= 0;
            else count <= count + 1;
            if(Switch[count]) begin
                Valid = 8'b11111111;
                Valid[count] = 1'b0; end
            else Valid = 8'b11111111;
        end
    end
endmodule
