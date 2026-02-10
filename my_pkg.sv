`include "uvm_macros.svh"

package my_pkg;
  import uvm_pkg::*;

  typedef integer MY_T;
 
  `include "harness/harness_if_proxy.sv"
  `include "my_env.sv"
  `include "my_test.sv"

endpackage
