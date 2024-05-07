package tb_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import my_haos_pkg::*;  

  import tb_params_pkg::*;

  //`include "api_write_seq.sv"
  //`include "api_read_seq.sv"

  //reset agent
  `include "src/reset_agent/my_reset_cfg.sv"  
  `include "src/reset_agent/my_reset_tr.sv"
  `include "src/reset_agent/my_reset_seq.sv"
  `include "src/reset_agent/my_reset_drv.sv"
  `include "src/reset_agent/my_reset_mon.sv"
  `include "src/reset_agent/my_reset.sv"

  //haos agent
  `include "src/haos_agent/my_haos_cfg.sv"
  `include "src/haos_agent/my_haos_tr.sv"
  `include "src/haos_agent/my_haos_drv.sv"
  `include "src/haos_agent/my_haos_mon.sv"
  `include "src/haos_agent/my_haos.sv"

  // RAL
  `include "src/ral/my_dummy_reg.sv"
  `include "src/ral/my_cr_reg.sv"
  `include "src/ral/my_mem.sv"
  `include "src/ral/my_alpha_reg.sv"
  `include "src/ral/my_beta_reg.sv"
  `include "src/ral/my_reg2bus_adapter.sv"
  `include "src/ral/my_muos_reg_block.sv"
  `include "src/ral/my_haos_reg_block.sv"
  // RAL sequences
  `include "src/ral/seq/my_haos_seq.sv"
  `include "src/ral/seq/my_muos_seq.sv"
  `include "src/ral/seq/my_muos_mem_seq.sv"

  //tops
  `include "src/my_env_cfg.sv"
  `include "src/my_env.sv"
  `include "src/my_test.sv"

endpackage
