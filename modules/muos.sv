module muos(
    input my_pkg::MY_T cnt_in,
    input              clk
  );

my_pkg::MY_T cnt=0;
bit [9:0] map[2];

always @(posedge clk) begin
  cnt <= cnt_in;
  map[0] <= cnt_in + 100;
  map[1] <= cnt_in + 1000;
end

import my_pkg::MY_T;

// Harness creates a ghost interface
// harness_if#(.T(my_pkg::MY_T)) harness_if_inst(cnt, clk);
// harness_n_if#(.T(logic [3:0], .N(2))) harness_if_inst(map, clk);
endmodule