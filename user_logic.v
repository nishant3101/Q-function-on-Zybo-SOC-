`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2018 10:33:04
// Design Name: 
// Module Name: user_logic
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


module user_logic(
input clk,
input [31:0]X,N,T,output [31:0]Q

   );
    q_func q1(.clk(clk),.X(X),.N(N),.T(T),.Qfixed(Q));
   
endmodule
