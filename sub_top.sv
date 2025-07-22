module sub_top(input clk);

int cnt;

always @(posedge clk) begin
    cnt <= cnt + 1;
end

endmodule