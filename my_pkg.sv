package my_pkg;
  import uvm_pkg::*;
  import my_params_pkg::*;
  `include "uvm_macros.svh"

  `include "mem_req_item.sv"

  `include "registers.sv"
  `include "my_reg_file.sv"
  `include "my_reg_block.sv"

  `include "reg2bus_adapter.sv"

  `include "api_write_seq.sv"
  `include "api_read_seq.sv"


  `include "mem_ladder_seq.sv"
  `include "mem_drv.sv"


  `include "my_env.sv"
  `include "my_test.sv"

endpackage
