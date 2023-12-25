`ifndef __PARAMS_HEADER__
    `define __PARAMS_HEADER__
    
//    `default_nettype none 
    
    /*signal level*/
    `define HIGH 1'b1
    `define LOW 1'b0
    
    /*logic value*/
    `define TRUE 1'b1     
    `define FALSE 1'b0
    
    /*frequency*/
    `define Clk_Freq 100000000 // 100MHz
    `define SClock 1000 // 7 Segment 1kHz
    `define CClock 1    // Clock 1Hz
    
    /*7 Seg*/
    `define Seg7Bus 6:0
    `define NUM_0 7'b0000001
    `define NUM_1 7'b1001111
    `define NUM_2 7'b0010010
    `define NUM_3 7'b0000110
    `define NUM_4 7'b1001100
    `define NUM_5 7'b0100100
    `define NUM_6 7'b0100000
    `define NUM_7 7'b0001111
    `define NUM_8 7'b0000000
    `define NUM_9 7'b0000100
    `define ALPHA_A 7'b0001000
    `define ALPHA_E 7'b0110000
    `define ALPHA_L 7'b1110001
    `define ALPHA_S 7'b0110100
    `define ALPHA_T 7'b1110000
    `define SYM__ 7'b1111110
    `define None 7'b1111111
    
    /*char ID*/
    `define IDBus 3:0
    `define _0 4'h0
    `define _1 4'h1
    `define _2 4'h2
    `define _3 4'h3
    `define _4 4'h4
    `define _5 4'h5
    `define _6 4'h6
    `define _7 4'h7
    `define _8 4'h8
    `define _9 4'h9
    `define _a 4'ha
    `define _e 4'hb
    `define _l 4'hc
    `define _s 4'hd
    `define _t 4'he
    `define __ 4'hf
    
    /*Bus*/
    `define ContentBus 31:0
    `define SwitchBus 7:0
    `define DotBus 7:0
    `define TimeBus 23:0
    `define DirLightsBus 3:0
    `define Bus32 4:0
    `define Bus64 5:0
    
    /*status*/
    `define StatusBus 1:0
    `define showTime24 2'b00
    `define showTime12 2'b01
    `define setTime 2'b10
    `define setAlarm 2'b11
    
    /*second lights*/
    `define LightBus 5:0   // use 6 lights
    
`endif