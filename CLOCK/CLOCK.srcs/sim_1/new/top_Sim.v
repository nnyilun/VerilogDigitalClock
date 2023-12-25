`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 18:02:38
// Design Name: 
// Module Name: top_Sim
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


module top_Sim(

    );
    reg CLK;
    reg nCR;
    reg EN;
    reg Enter, Up, Down, Right, Left;
    reg AlarmOn;
    
    wire [6:0] Seg7OUT;
    wire DP;
    wire [7:0] Valid;
    
    wire flicker_light;
    wire Alarm_light;
    wire PM_light;
    wire AlarmOn_light;
    wire [1:0] status_lights; 
    wire [4:0] second_lights;
    
    parameter PERIOD = 10;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end
    
    top U0(CLK, nCR, EN, Enter, Up, Down, Right, Left, AlarmOn,
        Seg7OUT, DP, Valid,
        flicker_light, Alarm_light, PM_light, AlarmOn_light, status_lights, second_lights);
        
    defparam U0.CLK1K.CLK_FREQ = 100, U0.CLK1K.NEED_FREQ = 100;
    defparam U0.CLK20.CLK_FREQ = 100, U0.CLK20.NEED_FREQ = 20;
    defparam U0.CLK1.CLK_FREQ = 100, U0.CLK1.NEED_FREQ = 10;
    
    initial begin
        nCR = 0;
        #10
        nCR = 1;
        EN = 1;
        #10000
        
        Enter = 1;
        #100
        Enter = 0;
        #100
        
        Enter = 1;
        #100
        Enter = 0;
        #100
        
        Up = 1;
        #100
        Up = 0;
        #100
        
        Enter = 1;
        #100
        Enter = 0;
        #100
        
        Enter = 1;
        #100
        Enter = 0;
        #100
        
        #10000
        $stop;
    
    end
    
endmodule
