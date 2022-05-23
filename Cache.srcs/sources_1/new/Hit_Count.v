module Hit_Count(
    input clk,
    input rst,
    input read_en,
    input valid_out,
    output reg [7:0] hit,
    output reg [7:0] miss
);

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        hit <= 0;
        miss <= 0;
    end else begin
        if(read_en && valid_out) begin
            hit <= hit + 1;
        end else begin
            miss <= miss + 1;
        end
    end
    end
end

endmodule