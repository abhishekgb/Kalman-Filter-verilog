
`timescale 1ns/1ps
module kalmantb();

wire signed [31:0] Hin,resultd,resulta,resultm,results,resultf,uofk,vrefofk;
reg signed [31:0] dataa,datab,datac;
reg clock,reset,validdataa,validdatab,validdatac,readyo,readyb;
reg uvalid,Vrefofkvalid;



/*  equationfile  tbf(
    .clock(clock),
    .dataa(dataa),
    .validdataa(validdataa),
    .validdatab(validdatab),
    .validdatac(validdatac),
   // .readyo(readyo),
    //.readyb(readyb),
    .datab(datab),
    .datac(datac),
    .result(resultf));
/*dividerwrapper  tb2(
    .clock(clock),
    .dataa(dataa),
    .validdataa(validdataa),
    .validdatab(validdatab),
   // .readyo(readyo),
    //.readyb(readyb),
    .datab(datab),
    .result(resultd));
    
	adderwrapper  tb212(
        .clock(clock),
        .dataa(dataa),
        .validdataa(validdataa),
        .validdatab(validdatab),
       // .readyo(readyo),
        //.readyb(readyb),
        .datab(datab),
        .result(resulta));			

multwrapper  tb3(
    .clock(clock),
    .dataa(dataa),
    .validdataa(validdataa),
    .validdatab(validdatab),
   // .readyo(readyo),
    //.readyb(readyb),
    .datab(datab),
    .result(resultm));
    				
subtractorwrapper  tb4(
        .clock(clock),
        .dataa(dataa),
        .validdataa(validdataa),
        .validdatab(validdatab),
       // .readyo(readyo),
        //.readyb(readyb),
        .datab(datab),
        .result(results));
	*/
	
/*Hwrappercode dut11
(
        .Hin(Hin),
        .clock(clock),
        .reset(reset)
        );	
	*/
kalmanalu testunit1(
        .Yout(Yout),
        //input [31:0] k,
       .clock(clock),
        .uofk(uofk),
        .vrefofk(vrefofk),
        .uvalid(uvalid),
       .Vrefofkvalid(Vrefofkvalid),
        .reset(reset)
        );	

       
	
	
	
	
initial 
begin
clock = 1'b0;
/*datab = 32'd0;
dataa = 32'd0;
datac = 32'd0;
//readyo= 1'b0;
validdataa = 1'b0;
validdatab = 1'b0;
validdatac = 1'b0;
//readya = 1'b0;
//readyb = 1'b0;*/

/*
dataa = 32'h0x40066666;//2.1
datab = 32'h0x4059999a;//3.4
datac = 32'h0x3dcccccd;//0.1
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1;
//readyo = 1'b0;
//readya = 1'b1;
//readyb = 1'b1;


#50
dataa = 32'h0x3e4ccccd;//0.2
datab = 32'h0x3e99999a;//0.3
datac = 32'h0x3f000000;//0.5
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1; 
#50
dataa = 32'h0x40066666;//2.1
datab = 32'h0x4059999a;//3.4
datac = 32'h0x3dcccccd;//0.1
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1;
#50
dataa = 32'h0x3e4ccccd;//0.2
datab = 32'h0x3e99999a;//0.3
datac = 32'h0x3f000000;//0.5
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1;
#50
dataa = 32'h0x40066666;//2.1
datab = 32'h0x4059999a;//3.4
datac = 32'h0x3dcccccd;//0.1
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1;
#50
dataa = 32'h0x3e4ccccd;//0.2
datab = 32'h0x3e99999a;//0.3
datac = 32'h0x3f000000;//0.5
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1;
#50
dataa = 32'h0x40066666;//2.1
datab = 32'h0x4059999a;//3.4
datac = 32'h0x3dcccccd;//0.1
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1;
#50
dataa = 32'h0x3e4ccccd;//0.2
datab = 32'h0x3e99999a;//0.3
datac = 32'h0x3f000000;//0.5
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1;
#50
dataa = 32'h0x40066666;//2.1
datab = 32'h0x4059999a;//3.4
datac = 32'h0x3dcccccd;//0.1
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1;
#50
dataa = 32'h0x3e4ccccd;//0.2
datab = 32'h0x3e99999a;//0.3
datac = 32'h0x3f000000;//0.5
validdataa = 1'b1;
validdatab = 1'b1;
validdatac = 1'b1;
/*dataa = 32'b01000000100001100110011001100110;
datab = 32'b01000000000001100110011001100110;
validdataa = 1'b1;
validdatab = 1'b1;
//readya = 1'b0;
//readyb = 1'b0;*/
reset = 1'b1;
#1000
reset = 1'b0;

//interation one 
#20
uvalid <= 1'b1;
Vrefofkvalid <= 1'b1;
vrefofk <= 32'h3f0a3d71; //0.54

uofk <=32'd0;//0

#20
uvalid <= 1'b1;
Vrefofkvalid <= 1'b1;
vrefofk <= 32'h3f0a3d71; //0.54

uofk <=32'd0;//0

#20
uvalid <= 1'b1;
Vrefofkvalid <= 1'b1;
vrefofk <= 32'h3f0a3d71; //0.54

uofk <=32'h40751d15;//3.83
#20
uvalid <= 1'b1;
Vrefofkvalid <= 1'b1;
vrefofk <= 32'h3f4aacda; //0.79

uofk <=32'h40751d15;//3.83

#20
uvalid <= 1'b1;
Vrefofkvalid <= 1'b1;
vrefofk <= 32'h3f8ccccd; //1.1

uofk <=32'h40751d15;//3.83
//readya = 1'b0;
//readyb = 1'b0;
$finish;



end
always 
begin 
#10 clock = ~clock;
end 
endmodule 
