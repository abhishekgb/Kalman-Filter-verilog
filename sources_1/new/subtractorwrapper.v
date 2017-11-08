module subtractorwrapper(
    input clock,
    input [31:0] dataa,
    input [31:0] datab,
    input validdataa,validdatab,//,readyo ,
   output reg [31:0] result
    );
    wire r;//,readyo;
    wire [31:0] resultw;
    
    always@(posedge clock) begin
        result <= resultw;
        
      end
  subtractorip dutsub (
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