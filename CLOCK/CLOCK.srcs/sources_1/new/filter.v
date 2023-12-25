`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 14:39:30
// Design Name: 
// Module Name: filter
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


module filter # ( parameter n = 5 )(
    input In,
    input CLK,
    output Out
    );
    reg [2:0] counter;
    assign Out = (counter == n);
    always @ ( posedge CLK or posedge In ) begin 
        if( In ) counter <= n;
        else if( counter > 0 ) counter <= counter - 1;
//        $display("counter:%d", counter);
    end
endmodule
