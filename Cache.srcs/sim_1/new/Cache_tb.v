`timescale 1ns / 1ps

module Cache_tb(
        
    );

    wire [31:0]	real_data;
    reg clk,rst,clk_bram,ena;
    reg [31:0] address;
    reg [144:0] write_block;
    //reg [3:0] write_enable_a;
    reg [7:0] count;
    reg read_en;

Cache_Top u_Cache_Top(
	//ports
	.clk            		( clk            		),
	.clk_bram       		( clk_bram       		),
	.rst            		( rst            		),
	.address        		( address        		),
	.write_block    		( write_block    		),
	//.write_enable_a 		( write_enable_a 		),
	.ena                    ( ena                   ),
	.real_data      		( real_data      		),
    .read_en         		( read_en         		)
);


initial begin
    clk = 0;
    clk_bram = 0;
    rst = 1;
    #10;
    rst = 0;
    #10;
    rst = 1;
    forever begin   // clk 变化1次，clk_bram变化四次。可以解决bram读取时clk会延迟的问题       
        #10;
        clk_bram = ~clk_bram;
        #10;
        clk_bram = ~clk_bram;
        #10;
        clk_bram = ~clk_bram;
        #10;
        clk_bram = ~clk_bram;
        clk = ~clk;
    end
end

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        address <= 0;
        write_block <= 0;
        count <= 0;
        ena <= 0;
        read_en <= 0;
    end
    else begin
        case(count)
            1: begin    //写入�?1路，index = 03A，tag = a011
                address <= 32'hA01103A0;
                write_block <= 145'h1A011ABC0B3D11D0D00C031C0E1D4A1B22041;
                ena <= 1;
            end
            2: begin    //写入�?2路，index = 03A，tag = 0041
                address <= 32'hA01103A0;    //仅index部分会被用到，tag在writeblock�?
                write_block <= 145'h100410BB220410A0D00C000D0B3D50001B11D;
                ena <= 1;
            end
            3: begin    //写入�?3路，index = 03A ，tag = 0124
                address <= 32'hA01103A0;
                write_block <= 145'h100040001B11D104110F0001A20F5AA31C0E1;
                ena <= 1;
            end
            4: begin    //写入�?4路，index = 03A
                address <= 32'hA01103A0;
                write_block <= 145'h101240B1041100C11D0B300D0D52001ABC0B3;
                ena <= 1;
            end
            5: begin    //写入�?5路，index = 42B
                address <= 32'h000042B8;
                write_block <= 145'h00000AA20D521CA2011F40D10F4B3F000245F;
                ena <= 1;
            end
            6:begin     //读取tag=0041，index=03A处的数据
                address <= 32'h004103A0;
                read_en <= 1;
                ena <= 0;
            end
            6:begin     //读取tag=0000，index=42B处的数据
                address <= 32'h000042B8;
                read_en <= 1;
                ena <= 0;
            end
        endcase
        count <= count+1;
    end
end

endmodule
