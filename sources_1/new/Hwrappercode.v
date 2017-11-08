`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2016 12:06:09 AM
// Design Name: 
// Module Name: Hwrappercode
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


module Hwrappercode(
    output reg [31:0] Hin,
    //input [31:0] k,
    input clock,
    input reset
    );
    
    //h = (1-k)*h
    wire [31:0] h1wire ,subout,multout;
    reg [31:0] k;
    wire r1,rf;
    
     subtractorip dutsub (
               .aclk(clock),                                  // input wire aclk
               .s_axis_a_tvalid(1'b1),            // input wire s_axis_a_tvalid
              // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
               .s_axis_a_tdata(32'h0x3f800000),              // input wire [31 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(1'b1),            // input wire s_axis_b_tvalid
               //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
               .s_axis_b_tdata(k),              // input wire [31 : 0] s_axis_b_tdata
               .m_axis_result_tvalid(rf),  // output wire m_axis_result_tvalid
       //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
               .m_axis_result_tdata(subout)    // output wire [31 : 0] m_axis_result_tdata
             );
             
             multip dutmut (
                            .aclk(clock),                                  // input wire aclk
                            .s_axis_a_tvalid(rf),            // input wire s_axis_a_tvalid
                           // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
                            .s_axis_a_tdata(subout),              // input wire [31 : 0] s_axis_a_tdata
                            .s_axis_b_tvalid(1'b1),            // input wire s_axis_b_tvalid
                            //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
                            .s_axis_b_tdata(Hin),              // input wire [31 : 0] s_axis_b_tdata
                            .m_axis_result_tvalid(r1),  // output wire m_axis_result_tvalid
                    //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
                            .m_axis_result_tdata(multout)    // output wire [31 : 0] m_axis_result_tdata
                          );
    
     always@(posedge clock or reset) 
     begin
     
   
     if (reset)
         begin
            Hin <= 32'h0x3e99999a;
              k <= 32'h0x3f000000;
         end
         // If not resetting, update the register output on the busy's falling edge
         else
         begin
             Hin <=multout;
         end
  end                                       // rg <= r;
                                              
      
    
    
endmodule
