`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 15:25:35
// Design Name: 
// Module Name: Mode_Sim
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


module Mode_Sim(

    );
    reg CLK;
    reg nCR;
    reg Enter;
    wire [1:0] status;
    
    Mode U0(CLK, nCR, Enter, status);
    
    parameter PERIOD = 10;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end
    
    initial begin
        nCR = 0;
        Enter = 0;
        #10;
        
        nCR = 1;
        #10
        
        Enter = 1;
        #10
        
        Enter = 0;
        #10
        
        Enter = 1;
        #10
        Enter = 0;
        
        #100
        $stop;
    
    end
	 
endmodule
