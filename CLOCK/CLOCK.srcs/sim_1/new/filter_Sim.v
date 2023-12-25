`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 14:42:13
// Design Name: 
// Module Name: filter_Sim
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


module filter_Sim(

    );
    reg In;
    reg CLK;
    wire Out;
    
    parameter PERIOD = 10;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end
    
    filter U0(In, CLK, Out);
    
    initial begin
        In = 1;
        #2
        In = 0;
        #1
        In = 1;
        #2
        In = 0;
        #200
        
        In = 1;
        #1
        In = 0;
        #1
        In = 1;
        #2
        In = 0;
        #1
        In = 1;
        #1
        In = 0;
        #100
        $stop;
    end
endmodule
