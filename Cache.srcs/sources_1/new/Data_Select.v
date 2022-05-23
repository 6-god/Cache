/*
    从4路BRAM中读取的数据里选取tag对应的一路，或输出valid_out信号，代表miss了。
*/

module Data_Select(
        input [144:0] doutb1,
        input [144:0] doutb2,
        input [144:0] doutb3,
        input [144:0] doutb4,
        input [15:0] tag,

        output [127:0] cache_out_data,
        output wire valid_out
    );
    wire [15:0] tag1;
    wire [15:0] tag2;
    wire [15:0] tag3;
    wire [15:0] tag4;

    wire tag_equal1;
    wire tag_equal2;
    wire tag_equal3;
    wire tag_equal4;

    assign tag1 = doutb1[143:128];
    assign tag2 = doutb2[143:128];
    assign tag3 = doutb3[143:128];
    assign tag4 = doutb4[143:128];

    assign tag_equal1 = tag1 == tag ;
    assign tag_equal2 = tag2 == tag ;
    assign tag_equal3 = tag3 == tag ;
    assign tag_equal4 = tag4 == tag ;

    assign valid_out = (tag_equal1&&doutb1[144])||(tag_equal2&&doutb2[144])||(tag_equal3&&doutb3[144])||(tag_equal4&&doutb4[144]);
    assign cache_out_data =  tag_equal1?doutb1[127:0]:tag_equal2?doutb2[127:0]:tag_equal3?doutb3[127:0]:tag_equal4?doutb4[127:0]:0;

endmodule
