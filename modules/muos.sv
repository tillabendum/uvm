module muos(
    input my_pkg::MY_T cnt_in,
    input              clk
  );

my_pkg::MY_T cnt=0;

always @(posedge clk) begin
  cnt <= cnt_in;
end

import my_pkg::MY_T;

// Harness creates a ghost interface
// harness_if#(.T(my_pkg::MY_T)) harness_if_inst(cnt, clk);
endmodule