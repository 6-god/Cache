/*
    将来自CPU的32位物理地址译码。
    格式：
    [15:0]   tag，用于标识物理地址
    [27:16]   index，用于确定组数
    [31:28]   offset，用于确定组内的偏移，1代表1Byte的偏移
  */

module Address_Decoder(
    input [31:0] address,
    output [15:0] tag,
    output [11:0] index,    //addrb
    output [3:0] offset  
);
    assign tag[15:0] = address[15:0];
    assign index[11:0] = address[27:16];
    assign offset[3:0] = address[31:28];

endmodule