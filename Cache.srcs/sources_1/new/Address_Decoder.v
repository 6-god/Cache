/*
    将来自CPU�?32位物理地�?译码�?
    格式�?
    [15:0]   tag，用于标识物理地�?
    [27:16]   index，用于确定组�?
    [31:28]   offset，用于确定组内的偏移�?1代表1Byte的偏�?
  */

module Address_Decoder(
    input [31:0] address,
    output [15:0] tag,
    output [11:0] index,    //addrb
    output [3:0] offset  
);
    assign tag[15:0] = address[31:16];
    assign index[11:0] = address[15:4];
    assign offset[3:0] = address[3:0];

endmodule