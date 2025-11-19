module haos(
    input clk
  );

integer first_val = 12;
integer second_val = 13;
integer third_val = 14;

always @(posedge clk) begin
  first_val  <= first_val + 1;
  second_val <= second_val + 1;
  third_val  <= third_val + 1;
end

muos muos_inst_0(.cnt_in(first_val),  .clk(clk));
muos muos_inst_1(.cnt_in(second_val), .clk(clk));
muos muos_inst_2(.cnt_in(third_val) , .clk(clk));
endmodule