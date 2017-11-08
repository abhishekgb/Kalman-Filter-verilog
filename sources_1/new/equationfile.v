`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2016 06:00:16 PM
// Design Name: 
// Module Name: equationfile
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


module equationfile(
    input clock,
    input [31:0] dataa,
    input [31:0] datab,
    input [31:0] datac,
    input validdataa,validdatab,validdatac,
    output reg [31:0] result
    );
    
    wire [31:0] result1,result2,result3,resultf;
    wire r,r1,r2,r3,rf;//,rg;
    reg rg;
    
    
    /// (a+b)-((a/b)*c)
    subtractorip dutsub (
            .aclk(clock),                                  // input wire aclk
            .s_axis_a_tvalid(r3),            // input wire s_axis_a_tvalid
           // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
            .s_axis_a_tdata(result3),              // input wire [31 : 0] s_axis_a_tdata
            .s_axis_b_tvalid(r1),            // input wire s_axis_b_tvalid
            //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
            .s_axis_b_tdata(result2),              // input wire [31 : 0] s_axis_b_tdata
            .m_axis_result_tvalid(rf),  // output wire m_axis_result_tvalid
    //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
            .m_axis_result_tdata(resultf)    // output wire [31 : 0] m_axis_result_tdata
          );
    
    //adder a+b
    floating_point_1 dutadd (
               .aclk(clock),                                  // input wire aclk
               .s_axis_a_tvalid(validdataa),            // input wire s_axis_a_tvalid
              // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
               .s_axis_a_tdata(dataa),              // input wire [31 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(validdatab),            // input wire s_axis_b_tvalid
               //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
               .s_axis_b_tdata(datab),              // input wire [31 : 0] s_axis_b_tdata
               .m_axis_result_tvalid(r3),  // output wire m_axis_result_tvalid
       //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
               .m_axis_result_tdata(result3)    // output wire [31 : 0] m_axis_result_tdata
             );
           
    //multiplication---(a/b)*c
     multip dutmut (
               .aclk(clock),                                  // input wire aclk
               .s_axis_a_tvalid(rg),            // input wire s_axis_a_tvalid
              // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
               .s_axis_a_tdata(result1),              // input wire [31 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(validdatac),            // input wire s_axis_b_tvalid
               //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
               .s_axis_b_tdata(datac),              // input wire [31 : 0] s_axis_b_tdata
               .m_axis_result_tvalid(r1),  // output wire m_axis_result_tvalid
       //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
               .m_axis_result_tdata(result2)    // output wire [31 : 0] m_axis_result_tdata
             );
   //division a/b
    floating_point_0 dut123 (
           .aclk(clock),                                  // input wire aclk
           .s_axis_a_tvalid(validdataa),            // input wire s_axis_a_tvalid
          // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
           .s_axis_a_tdata(dataa),              // input wire [31 : 0] s_axis_a_tdata
           .s_axis_b_tvalid(validdatab),            // input wire s_axis_b_tvalid
           //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
           .s_axis_b_tdata(datab),              // input wire [31 : 0] s_axis_b_tdata
           .m_axis_result_tvalid(r),  // output wire m_axis_result_tvalid
   //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
           .m_axis_result_tdata(result1)    // output wire [31 : 0] m_axis_result_tdata
         ); 
    
    always@(posedge clock) begin
                     result <= resultf;
                     rg <= r;
                     
                   end
    
    
    
    
    
endmodule
