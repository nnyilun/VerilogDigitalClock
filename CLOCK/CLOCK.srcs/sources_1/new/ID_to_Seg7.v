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


module ID_to_Seg7(
    input [`IDBus] ID,
    output reg [`Seg7Bus] Seg7Res
    );
    
    always @ ( * ) begin
        case( ID )
        `_0: Seg7Res = `NUM_0;
        `_1: Seg7Res = `NUM_1;
        `_2: Seg7Res = `NUM_2;
        `_3: Seg7Res = `NUM_3;
        `_4: Seg7Res = `NUM_4;
        `_5: Seg7Res = `NUM_5;
        `_6: Seg7Res = `NUM_6;
        `_7: Seg7Res = `NUM_7;
        `_8: Seg7Res = `NUM_8;
        `_9: Seg7Res = `NUM_9;
        `_a: Seg7Res = `ALPHA_A;
        `_e: Seg7Res = `ALPHA_E;
        `_l: Seg7Res = `ALPHA_L;
        `_s: Seg7Res = `ALPHA_S;
        `_t: Seg7Res = `ALPHA_T;
        `__: Seg7Res = `SYM__;
        default: Seg7Res = `None;
        endcase
    end
endmodule
