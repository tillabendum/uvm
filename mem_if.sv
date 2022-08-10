interface mem_if (
    input clk_i,
    srst_i
  );

import my_params_pkg::DWIDTH;
import my_params_pkg::AWIDTH;

logic [DWIDTH - 1 : 0]  data;
logic [DWIDTH - 1 : 0]  rddata;
logic [AWIDTH - 1 : 0]  addr;
logic                   wr;
logic                   rd;
logic                   rddatavalid;

endinterface
