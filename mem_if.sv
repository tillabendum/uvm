interface mem_if #(
    parameter DWIDTH = 8,
    parameter AWIDTH = 6
  )();

logic [DWIDTH - 1 : 0]  data;
logic [DWIDTH - 1 : 0]  rddata;
logic [AWIDTH - 1 : 0]  addr;
logic                   wr;
logic                   rd;
logic                   rddatavalid;

endinterface
