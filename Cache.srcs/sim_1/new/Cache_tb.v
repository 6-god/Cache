`timescale 1ns / 1ps

module Cache_tb(
        output [31:0] real_data
    );

    reg clk,rst,clk_bram,ena;
    reg [31:0] address;
    reg [144:0] write_block;
    //reg [3:0] write_enable_a;
    reg [7:0] count;
    reg read_en;
    reg [7:0] count_times2;

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
    #100;
    rst = 0;
    #100;
    rst = 1;
    forever begin   // clk 变化1次，clk_bram变化四次。可以解决bram读取时clk会延迟的问题       
        #100;
        clk_bram = ~clk_bram;
        #100;
        clk_bram = ~clk_bram;
        #100;
        clk_bram = ~clk_bram;
        #100;
        clk_bram = ~clk_bram;
        #100;
        clk_bram = ~clk_bram;
        #100;
        clk_bram = ~clk_bram;
        #100;
        clk_bram = ~clk_bram;
        #100;
        clk_bram = ~clk_bram;
        clk = ~clk;
    end
end

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        address <= 0;
        write_block <= 0;
        count_times2 <= 0;
        ena <= 0;
        read_en <= 0;
    end
    else begin
        count_times2 <= count_times2 +1;
        count <= count_times2/2;
        case(count)
            1: begin    //write，index = 03A，tag = a011
                address <= 32'hA01103A0;
                write_block <= 145'h1A011ABC0B3D11D0D00C031C0E1D4A1B22041;
                ena <= 1;
            end
            2: begin    //write，index = 03A，tag = 0041
                address <= 32'hA01103A0;    //仅index部分会被用到，tag在writeblock�??
                write_block <= 145'h100410BB220410A0D00C000D0B3D50001B11D;
                ena <= 1;
            end
            3: begin    //write，index = 03A ，tag = 0124
                address <= 32'hA01103A0;
                write_block <= 145'h100040001B11D104110F0001A20F5AA31C0E1;
                ena <= 1;
            end
            4: begin    //write，index = 03A
                address <= 32'hA01103A0;
                write_block <= 145'h101240B1041100C11D0B300D0D52001ABC0B3;
                ena <= 1;
            end
            5: begin    //write，index = 42B
                address <= 32'h000042B8;
                write_block <= 145'h00000AA20D521CA2011F40D10F4B3F000245F;
                ena <= 1;
            end
            6:begin     //read,tag=0041，index=03A
                address <= 32'h004103A0;
                read_en <= 1;
                ena <= 0;
            end
            7:begin     //read,tag=0000，index=42B result:v=0
                address <= 32'h000042B8;
                read_en <= 1;
                ena <= 0;
            end
            8:begin     //read,tag=0030，index=D01 result:miss
                address <= 32'h0030D018;
                read_en <= 1;
                ena <= 0;
            end
            9:begin     //write, index=03A,tag= 1111,验证cache丢弃的随机算�?
                address <= 32'h111103A1;
                write_block <= 145'h11111AAAABBBBCCCCDDDDEEEEFFFF00001111;
                ena <= 1;
                read_en <= 0;
            end
            10:begin    //read,tag=1111，index=03A,验证9是否被写入
                address <= 32'h111103A0;
                read_en <= 1;
                ena <= 0;
            end
            default:begin
                address <= 0;
                write_block <= 0;
                ena <= 0;
                read_en <= 0;
            end
        endcase
        
    end
end

endmodule
