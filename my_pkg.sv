package my_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

virtual interface my_if global_vif;

// sequences
`include "ctrl_seq_item.sv"
`include "ctrl_subsequence.sv"
`include "ctrl_sequence.sv"

`include "component.sv"
`include "ctrl_drv.sv"



`include "my_data.sv"
`include "my_generator.sv"
`include "my_driver.sv"
`include "my_env.sv"
`include "my_test.sv"

endpackage
