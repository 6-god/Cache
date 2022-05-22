/*
    从一整块cache（4*4Byte）中取出4Byte的数据。
    根据32位地址中的offset部分进行数据选择。
*/
module Offset_Mux(
    input [3:0] offset,
    input [128:0] cache_out_data,
    output [31:0] real_data
);
    assign real_data = cache_out_data[offset*8];

endmodule