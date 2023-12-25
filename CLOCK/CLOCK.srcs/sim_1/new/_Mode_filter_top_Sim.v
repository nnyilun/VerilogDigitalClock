`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 01:11:09
// Design Name: 
// Module Name: _Mode_filter_top_Sim
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


module _Mode_filter_top_Sim(

    );
    reg CLK;
    reg nCR;
    reg Enter;
    wire [1:0] status;
    
    parameter PERIOD = 10;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end
    
    _Mode_filter_top U0(CLK, nCR, Enter, status);
    
    initial begin
        nCR = 0;
        #10
        nCR = 1;
        Enter = 1;
        #1
        Enter = 0;
        #50
        
        Enter = 1;
        #20
        Enter = 0;
        #50
        $stop;
    
    end
endmodule
