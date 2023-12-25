`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 19:06:16
// Design Name: 
// Module Name: frequency_div
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


module frequency_div # ( parameter CLK_FREQ = 100000000, NEED_FREQ = 1 )(
    input Clk, nCR,
    output reg CLK_Out
    );
    reg [31:0] counter;
    always @ ( posedge Clk or negedge nCR ) begin
        if(~nCR) begin
            counter <= 32'h00000000;
            CLK_Out <= 1'b0;    end
        else 
            if(counter == CLK_FREQ / (NEED_FREQ * 2) - 1) begin
                counter <= 32'h00000000;
                CLK_Out <= ~CLK_Out; end
            else counter <= counter + 1;
    end
endmodule
