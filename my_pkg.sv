`include "uvm_macros.svh"

package my_pkg;
  import uvm_pkg::*;

  typedef bit [2:0] MY_T;
 
  `include "uvm_object_cnt.sv"
  `include "backdoor_if_proxy.sv"
  `include "harness/harness_if_proxy.sv"
  `include "backdoor.sv"
  `include "backdoor_cnt.sv"

  `include "my_env.sv"
  `include "my_test.sv"

endpackage
