`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 17:44:37
// Design Name: 
// Module Name: hour_flicker_Sim
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


module hour_flicker_Sim(

    );
    reg CLK, run;
    reg [4:0] Hour;
    wire Out;
    
    parameter PERIOD = 10;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end
    
    hour_flicker U0(CLK, run, Hour, Out);
    
    initial begin
        
        Hour = 5'd20;
        run = 1;
        #10
        run = 0;
        #500
        
        Hour = 5'd6;
        run = 1;
        #10
        run = 0;
        #500
        
        $stop;
    
    end
endmodule
