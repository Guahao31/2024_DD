`timescale 1ns / 1ps

module clk_1s( 
	input clk, 
	output reg clk_1s
);
	 
	reg [31:0] cnt;

	initial begin
		cnt = 32'b0;
	end

	wire[31:0] cnt_next;
	assign cnt_next = cnt + 1'b1;

	always @(posedge clk) begin
		if(cnt<50_000_000)begin
			cnt <= cnt_next;
		end
		else begin
			cnt <= 0;
			clk_1s <= ~clk_1s;
		end
	end

endmodule
