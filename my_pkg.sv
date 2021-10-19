package my_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

virtual interface my_if global_vif;

`include "my_data.sv"
`include "my_generator.sv"
`include "my_driver.sv"
`include "my_env.sv"
`include "my_test.sv"

endpackage
