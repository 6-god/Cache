`timescale 1ns / 1ps
/*
	4路组相连的BRAM，故需要创建4个BRAM实例。
*/


module BRAMs(
		input clk,
		input clk_bram,
		input rst,
		input [11:0] addra,	//RAM PORT A 写地址
		input [144:0] dina,	//RAM PORT  A 写数据
		input wea1,				//RAM PORT  A 写使能，高电平有效
		input wea2,
		input wea3,
		input wea4,
		input ena,
		input [11:0] addrb,	//RAM PORT  B 读地址
		output [144:0] doutb1,	//RAM PORT   B 读数据
		output [144:0] doutb2,
		output [144:0] doutb3,
		output [144:0] doutb4,
		output [3:0] valids
    );
    
	assign valids[0] = doutb1[144];
	assign valids[1] = doutb2[144];
	assign valids[2] = doutb3[144];
	assign valids[3] = doutb4[144];
  
    
blk_mem_1 bram1(
	//ports
	.clka  		( clk_bram		),
	.wea   		( wea1   		),
	.addra 		( addra 		),
	.ena  		( ena			),
	.dina  		( dina  		),
	.clkb  		( clk_bram		),
	.addrb 		( addrb 		),
	.doutb 		( doutb1 		)
);


blk_mem_1 bram2(
	//ports
	.clka  		( clk_bram 		),
	.wea   		( wea2   		),
	.addra 		( addra 		),
	.ena  		( ena			),
	.dina  		( dina  		),
	.clkb  		( clk_bram   	),
	.addrb 		( addrb 		),
	.doutb 		( doutb2 		)
);

blk_mem_1 bram3(
	//ports
	.clka  		( clk_bram 		),
	.wea   		( wea3   		),
	.addra 		( addra 		),
	.ena  		( ena			),
	.dina  		( dina  		),
	.clkb  		( clk_bram   	),
	.addrb 		( addrb 		),
	.doutb 		( doutb3 		)
);

blk_mem_1 bram4(
	//ports
	.clka  		( clk_bram 		),
	.wea   		( wea4   		),
	.addra 		( addra 		),
	.ena  		( ena			),
	.dina  		( dina  		),
	.clkb  		( clk_bram   	),
	.addrb 		( addrb 		),
	.doutb 		( doutb4 		)
);




endmodule
