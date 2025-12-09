package my_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  typedef struct packed {
    int unsigned WIDTH;
    int unsigned DEPTH;
  } params_t;

  localparam params_t DEFAULT_PARAMS = '{WIDTH:1000, DEPTH:1001};

  `include "my_comp.sv"
  `include "my_env.sv"
  `include "my_test.sv"

endpackage
