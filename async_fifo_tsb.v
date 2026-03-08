`timescale 1ns / 1ps
module async_fifo_tsb();
localparam data_w=8;
reg clk_wr,clk_rd,rst,wr_en,rd_en;
reg [data_w:0] data_in;
wire full,empty;
wire [data_w:0] data_out;
async_fifo dut (.clk_wr(clk_wr),.clk_rd(clk_rd),.rst(rst),.wr_en(wr_en),.rd_en(rd_en),.data_in(data_in),.full(full),
.empty(empty),.data_out(data_out));
always #5 clk_wr=~clk_wr;
always #7 clk_rd=~clk_rd;
initial
begin
$monitor($time, "wr_en=%b rd_en=%b data_in=%d data_out=%d full=%b empty=%b ",wr_en,rd_en,data_in,data_out,full,empty);
clk_wr=0;clk_rd=0;rst=1;wr_en=0;rd_en=0;data_in=0;
#20;
rst=0;
#30;

wr_en=1;
@(posedge clk_wr);
data_in=8'haa;@(posedge clk_wr);
data_in=8'hc2;@(posedge clk_wr);
data_in=8'he2;@(posedge clk_wr);
data_in=8'hff;@(posedge clk_wr);
data_in=8'ha1;@(posedge clk_wr);
data_in=8'hf3;@(posedge clk_wr);
data_in=8'ha2;@(posedge clk_wr);
data_in=8'hb5;@(posedge clk_wr);
data_in=8'hbb;@(posedge clk_wr);
data_in=8'hee;@(posedge clk_wr);
wr_en=0;
#30;
rd_en=1;

#120;
$finish;
end
endmodule
