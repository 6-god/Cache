/*cache块替换的选择。使用随机替换算法：
    若四路中有一路（或以上）为空，则直接替换�?
    若四路全满，则随机�?�择�?路替换；
    输出为四路select_signal，三路为0，一路为1�?
*/
module Write_Select(
    input[3:0] valids,
    input clk,
    input rst,
    output[3:0] select_signals

);
    wire [3:0] choose;
    reg[1:0] rand_num;
    wire [3:0] rand_choose;

    assign choose[0] = ~valids[0];
    assign choose[1] = ~valids[1] & valids[0];
    assign choose[2] = ~valids[2] & valids[1] & valids[0];
    assign choose[3] = ~valids[3] & valids[2] & valids[1] & valids[0];


    always@(posedge clk or negedge rst) begin
        if(!rst)begin
            rand_num <= 0;
        end
        else begin
            rand_num <= (rand_num+1)%4;
        end
    end

    assign rand_choose[0] = (!rand_num[0]) & (!rand_num[1]);
    assign rand_choose[1] = (!rand_num[0]) & rand_num[1];
    assign rand_choose[2] = rand_num[0] & (!rand_num[1]);
    assign rand_choose[3] = rand_num[0] & rand_num[1];

    assign select_signals = (choose[0]|choose[1]|choose[2]|choose[3])?choose:rand_choose;

endmodule
