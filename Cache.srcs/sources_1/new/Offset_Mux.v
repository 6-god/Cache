/*
    从一整块cache�?4*4Byte）中取出4Byte的数据�??
    根据32位地�?中的offset部分进行数据选择�?
*/
module Offset_Mux(
    input [3:0] offset,
    input [127:0] cache_out_data,
    output reg [31:0] real_data
);

    always@(*) begin        
        case(offset)
            3'h0:real_data <= cache_out_data[127:96];
            3'h4:real_data <= cache_out_data[95:64];
            3'h8:real_data <= cache_out_data[63:32];
            3'hc:real_data <= cache_out_data[31:0];
            default:real_data <= cache_out_data[127:96];
        endcase
    end
     

endmodule