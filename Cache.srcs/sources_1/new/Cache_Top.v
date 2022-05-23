module Cache_Top(
    input clk,
    input clk_bram,
    input rst,
    input [31:0] address,
    input [144:0] write_block,
    //input [11:0] write_index, //没有必要输入write_index,因为write_index可在address中被解码
    //input [3:0] write_enable_a,
    input ena,
	input read_en,
    output [31:0] real_data

);


wire [15:0]	tag;
wire [11:0]	index;
wire [3:0]	offset;

Address_Decoder u_Address_Decoder(
	//ports
	.address 		( address 		),
	.tag     		( tag     		),
	.index   		( index   		),
	.offset  		( offset  		)
);



    wire [144:0]	doutb1;
    wire [144:0]	doutb2;
    wire [144:0]	doutb3;
    wire [144:0]	doutb4;
    wire [3:0]	valids;

BRAMs u_BRAMs(
	//ports
	.clk      		( clk      		),
	.clk_bram 		( clk_bram 		),
	.rst      		( rst      		),
	.addra    		( index         ),  //from testbench
	.dina     		( write_block	),  //from testbench
	.wea1     		( select_signals[0]	),  //from Write_Select
	.wea2     		( select_signals[1]	),
	.wea3     		( select_signals[2]	),
	.wea4     		( select_signals[3]	),
	.ena			( ena			),
	.addrb    		( index    		),  //from address decoder
	.doutb1   		( doutb1   		),  //to data select
	.doutb2   		( doutb2   		),
	.doutb3   		( doutb3   		),
	.doutb4   		( doutb4   		),
	.valids   		( valids   		)   //4 valid bits to write select
);

wire [127:0]	cache_out_data;
wire 	valid_out;

Data_Select u_Data_Select(
	//ports
	.doutb1         		( doutb1         		),
	.doutb2         		( doutb2         		),
	.doutb3         		( doutb3         		),
	.doutb4         		( doutb4         		),
	.tag            		( tag            		),
	.cache_out_data 		( cache_out_data 		),  //to offset mux
	.valid_out      		( valid_out      		)
);

//wire [31:0]	real_data;

Offset_Mux u_Offset_Mux(
	//ports
	.offset         		( offset         		),
	.cache_out_data 		( cache_out_data 		),
	.real_data      		( real_data      		)   //the real data to be used
);

wire [3:0]	select_signals;
assign wea1 = select_signals[0];
assign wea2 = select_signals[1];
assign wea3 = select_signals[2];
assign wea4 = select_signals[3];

Write_Select u_Write_Select(
	//ports
	.valids         		( valids         		),
	.clk            		( clk            		),
	.rst            		( rst            		),
	.select_signals 		( select_signals 		)   //to BRAMs
);



endmodule