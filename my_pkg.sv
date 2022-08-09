package my_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //Environment constants
  localparam DWIDTH = 8; //Data width
  localparam INTERFACE_AWIDTH = 8; // Address width of DUT and interface connections
  localparam CAPACITY_AWIDTH = 8; // Address with that characterize memory capacity

  `include "registers.sv"
  `include "my_reg_file.sv"
  `include "my_reg_block.sv"

  `include "mem_req_item.sv"
  `include "api_write_seq.sv"
  `include "api_read_seq.sv"

  `include "mem_ladder_seq.sv"
  `include "mem_drv.sv"


  `include "my_env.sv"
  `include "my_test.sv"

endpackage
