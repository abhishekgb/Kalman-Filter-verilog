`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2016 03:44:33 PM
// Design Name: 
// Module Name: adderwrapper
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


module adderwrapper(
    input [31:0] dataa,
    input [31:0] datab,
    input validdataa,validdatab,//,readyo ,
       output reg [31:0] result,
    input clock
    );
     wire r;//,readyo;
       wire [31:0] resultw;
       
       always@(posedge clock) begin
           result <= resultw;
           
         end
      floating_point_1 dutadd (
           .aclk(clock),                                  // input wire aclk
           .s_axis_a_tvalid(validdataa),            // input wire s_axis_a_tvalid
          // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
           .s_axis_a_tdata(dataa),              // input wire [31 : 0] s_axis_a_tdata
           .s_axis_b_tvalid(validdatab),            // input wire s_axis_b_tvalid
           //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
           .s_axis_b_tdata(datab),              // input wire [31 : 0] s_axis_b_tdata
           .m_axis_result_tvalid(r),  // output wire m_axis_result_tvalid
   //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
           .m_axis_result_tdata(resultw)    // output wire [31 : 0] m_axis_result_tdata
         );
       
   endmodule


