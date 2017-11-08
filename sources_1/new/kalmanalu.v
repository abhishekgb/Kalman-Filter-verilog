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


module kalmanalu(
    output reg [31:0] Yout,
    //input [31:0] k,
    input  clock,
    input  [31:0] uofk,
    input  [31:0] vrefofk,
    input  uvalid,
    input  Vrefofkvalid,
    input reset
    );
	
	
	
	
	
	
	
	reg   mvalid,Qvalid,Rvalid;
    //h = (1-k)*h
    wire [31:0] h1wire,subout,multout;
   // reg [31:0] k;
    wire vhatofkplusoneminusvalid,vrefminusvhatofkplusonevalid,kofkvalid,kvrefvhatvalid;
	wire vhatofkvalid,hofkplusoneminusvalid,hofkplusoneandrminusvalid,kvalid,ksuboutvalid;
	wire  muvalid,hofkvalid,multdvarvalid;
	reg i;
	
	
	wire [31:0] vhatofkplusoneminus,vrefminusvhatofkplusone,kofk,kvrefvhat;
	wire [31:0]vhatofk,hofkplusoneandrminus,ksubout,hofkplusoneminus,MandU,hofk,multdvar;
	reg [31:0] R,Mslope,k,Q,vnoise,Dvar;
	
	
	//measure update or correct
	
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Vhatofk = vhatofkplusoneminus + kofk(vrefofk - vhatofkplusoneminus)*Dvar////////////////////////////////////////////////////////////////////////////////////////
///.......................................................................................................................................///////
//subtractor

     subtractorip dutsub11 (
               .aclk(clock),                                  // input wire aclk
               .s_axis_a_tvalid(Vrefofkvalid),            // input wire s_axis_a_tvalid
              // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
               .s_axis_a_tdata(vrefofk),              // input wire [31 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(vhatofkplusoneminusvalid),            // input wire s_axis_b_tvalid
               //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
               .s_axis_b_tdata(vhatofkplusoneminus),              // input wire [31 : 0] s_axis_b_tdata
               .m_axis_result_tvalid(vrefminusvhatofkplusonevalid),  // output wire m_axis_result_tvalid
       //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
               .m_axis_result_tdata(vrefminusvhatofkplusone)    // output wire [31 : 0] m_axis_result_tdata
             );	
	
	
	multip kvrefvhat1 (
                            .aclk(clock),                                  // input wire aclk
                            .s_axis_a_tvalid(kofkvalid),            // input wire s_axis_a_tvalid
                           // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
                            .s_axis_a_tdata(kofk),              // input wire [31 : 0] s_axis_a_tdata
                            .s_axis_b_tvalid(vrefminusvhatofkplusonevalid),            // input wire s_axis_b_tvalid
                            //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
                            .s_axis_b_tdata(vrefminusvhatofkplusone),              // input wire [31 : 0] s_axis_b_tdata
                            .m_axis_result_tvalid(kvrefvhatvalid),  // output wire m_axis_result_tvalid
                    //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
                            .m_axis_result_tdata(kvrefvhat)    // output wire [31 : 0] m_axis_result_tdata
                          );
	multip multdvar1 (
                            .aclk(clock),                                  // input wire aclk
                            .s_axis_a_tvalid(kvrefvhatvalid),            // input wire s_axis_a_tvalid
                           // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
                            .s_axis_a_tdata(kvrefvhat),              // input wire [31 : 0] s_axis_a_tdata
                            .s_axis_b_tvalid(1'b1),            // input wire s_axis_b_tvalid
                            //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
                            .s_axis_b_tdata(Dvar),              // input wire [31 : 0] s_axis_b_tdata
                            .m_axis_result_tvalid(multdvarvalid),  // output wire m_axis_result_tvalid
                    //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
                            .m_axis_result_tdata(multdvar)    // output wire [31 : 0] m_axis_result_tdata
                          );
	
		floating_point_1 vhatpluskvrefvhat1 (
               .aclk(clock),                                  // input wire aclk
               .s_axis_a_tvalid(vhatofkplusoneminusvalid),            // input wire s_axis_a_tvalid
              // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
               .s_axis_a_tdata(vhatofkplusoneminus),              // input wire [31 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(multdvarvalid),            // input wire s_axis_b_tvalid
               //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
               .s_axis_b_tdata(multdvar),              // input wire [31 : 0] s_axis_b_tdata
               .m_axis_result_tvalid(vhatofkvalid),  // output wire m_axis_result_tvalid
       //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
               .m_axis_result_tdata(vhatofk)    // output wire [31 : 0] m_axis_result_tdata
             );
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//kalman gain k[k] = h[k+1]minus/(h[k+1]minus + r)
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//add hkminus with r
	
	floating_point_1 hofkplusr1 (
               .aclk(clock),                                  // input wire aclk
               .s_axis_a_tvalid(Rvalid),            // input wire s_axis_a_tvalid
              // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
               .s_axis_a_tdata(R),              // input wire [31 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(hofkplusoneminusvalid),            // input wire s_axis_b_tvalid
               //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
               .s_axis_b_tdata(hofkplusoneminus),              // input wire [31 : 0] s_axis_b_tdata
               .m_axis_result_tvalid(hofkplusoneandrminusvalid),  // output wire m_axis_result_tvalid
       //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
               .m_axis_result_tdata(hofkplusoneandrminus)    // output wire [31 : 0] m_axis_result_tdata
             );
	
	
	//Hofkminus /hofkplusoneminusandr
	
	
	
	 floating_point_0 hofkplusoneminus1 (
           .aclk(clock),                                  // input wire aclk
           .s_axis_a_tvalid(hofkplusoneminusvalid),            // input wire s_axis_a_tvalid
          // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
           .s_axis_a_tdata(hofkplusoneminus),              // input wire [31 : 0] s_axis_a_tdata
           .s_axis_b_tvalid(hofkplusoneandrminusvalid),            // input wire s_axis_b_tvalid
           //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
           .s_axis_b_tdata(hofkplusoneandrminus),              // input wire [31 : 0] s_axis_b_tdata
           .m_axis_result_tvalid(kofkvalid),  // output wire m_axis_result_tvalid
   //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
           .m_axis_result_tdata(kofk)    // output wire [31 : 0] m_axis_result_tdata
         );
		 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//// H[K] = (1-K[k])*H[k plusone minus]/////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
     subtractorip dutsub12 (
               .aclk(clock),                                  // input wire aclk
               .s_axis_a_tvalid(1'b1),            // input wire s_axis_a_tvalid
              // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
               .s_axis_a_tdata(32'h3f800000),              // input wire [31 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(kvalid),            // input wire s_axis_b_tvalid
               //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
               .s_axis_b_tdata(kofk),              // input wire [31 : 0] s_axis_b_tdata
               .m_axis_result_tvalid(ksuboutvalid),  // output wire m_axis_result_tvalid
       //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
               .m_axis_result_tdata(ksubout)    // output wire [31 : 0] m_axis_result_tdata
             );
             
             multip hofk1 (
                            .aclk(clock),                                  // input wire aclk
                            .s_axis_a_tvalid(ksuboutvalid),            // input wire s_axis_a_tvalid
                           // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
                            .s_axis_a_tdata(ksubout),              // input wire [31 : 0] s_axis_a_tdata
                            .s_axis_b_tvalid(hofkplusoneminusvalid),            // input wire s_axis_b_tvalid
                            //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
                            .s_axis_b_tdata(hofkplusoneminus),              // input wire [31 : 0] s_axis_b_tdata
                            .m_axis_result_tvalid(hofkvalid),  // output wire m_axis_result_tvalid
                    //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
                            .m_axis_result_tdata(hofk)    // output wire [31 : 0] m_axis_result_tdata
                          );
	
	
	
	
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//time update predict///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /// Vhat[k+1]- = vhat[k] + M * u[k];
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  

   
	//first multiply the m and uofk
	
	 multip manduk1 (
                            .aclk(clock),                                  // input wire aclk
                            .s_axis_a_tvalid(mvalid),            // input wire s_axis_a_tvalid
                           // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
                            .s_axis_a_tdata(Mslope),              // input wire [31 : 0] s_axis_a_tdata
                            .s_axis_b_tvalid(uvalid),            // input wire s_axis_b_tvalid
                            //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
                            .s_axis_b_tdata(uofk),              // input wire [31 : 0] s_axis_b_tdata
                            .m_axis_result_tvalid(muvalid),  // output wire m_axis_result_tvalid
                    //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
                            .m_axis_result_tdata(MandU)    // output wire [31 : 0] m_axis_result_tdata
                          );
						  
						  
	//second add multiplied op and vhat[k]

 floating_point_1 vhatminusofkplusone1 (
               .aclk(clock),                                  // input wire aclk
               .s_axis_a_tvalid(vhatofkvalid),            // input wire s_axis_a_tvalid
              // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
               .s_axis_a_tdata(vhatofk),              // input wire [31 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(muvalid),            // input wire s_axis_b_tvalid
               //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
               .s_axis_b_tdata(MandU),              // input wire [31 : 0] s_axis_b_tdata
               .m_axis_result_tvalid(vhatofkplusoneminusvalid),  // output wire m_axis_result_tvalid
       //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
               .m_axis_result_tdata(vhatofkplusoneminus)    // output wire [31 : 0] m_axis_result_tdata
             );	
						  
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////-----------------------------------------Hofkplusoneminus=hofk plus Q --------------------------//////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	 floating_point_1 hofkpluseoneminus1 (
               .aclk(clock),                                  // input wire aclk
               .s_axis_a_tvalid(hofkvalid),            // input wire s_axis_a_tvalid
              // .s_axis_a_tready(readya),            // output wire s_axis_a_tready
               .s_axis_a_tdata(hofk),              // input wire [31 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(Qvalid),            // input wire s_axis_b_tvalid				
               //.s_axis_b_tready(readyb),            // output wire s_axis_b_tready
               .s_axis_b_tdata(Q),              // input wire [31 : 0] s_axis_b_tdata
               .m_axis_result_tvalid(hofkplusoneminusvalid),  // output wire m_axis_result_tvalid
       //        .m_axis_result_tready(readyo),  // input wire m_axis_result_tready
               .m_axis_result_tdata(hofkplusoneminus)    // output wire [31 : 0] m_axis_result_tdata
             );	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	

    
     always@(posedge clock or reset) 
     begin
     
   
     if (reset)
         begin
            
              k <= 32'h3f000000;
			  R<=32'h3eafd220;
			  Mslope<=32'h3aa3d70a;
			  vnoise <= 32'h3f0a3d71;
			  Dvar <= 32'hf800000;
			  i <= 1'b0;
			   mvalid <= 1'b1;
			   Qvalid <= 1'b1;
			   Rvalid <= 1'b1;
         end
         // If not resetting, update the register output on the busy's falling edge
         else
         begin
             Yout <=vhatofk;
			 if(uofk == 32'd0)
			 begin
				if(i)
				begin
				Dvar <= 32'hbf800000;
				i <= i+1;
				end
				else
				begin
				 Dvar <= 32'hf800000;
				 i <= i+1;
				 end
				end
				else
				begin
				Dvar <= 32'hf800000;
				end
			end
				
				
		
			 
			 
        
  end                                       // rg <= r;
                                              
      
    
    
endmodule
