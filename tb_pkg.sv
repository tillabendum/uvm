package tb_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import my_haos_pkg::*;  

  import tb_params_pkg::*;

  //`include "api_write_seq.sv"
  //`include "api_read_seq.sv"

  //reset agent
  `include "reset_agent/my_reset_cfg.sv"  
  `include "reset_agent/my_reset_tr.sv"
  `include "reset_agent/my_reset_seq.sv"
  `include "reset_agent/my_reset_drv.sv"
  `include "reset_agent/my_reset_mon.sv"
  `include "reset_agent/my_reset.sv"

  //haos agent
  `include "haos_agent/my_haos_cfg.sv"
  `include "haos_agent/my_haos_tr.sv"
  `include "haos_agent/my_haos_drv.sv"
  `include "haos_agent/my_haos_mon.sv"
  `include "haos_agent/my_haos.sv"

  // RAL
  `include "ral/my_dummy_reg.sv"
  `include "ral/my_cr_reg.sv"
  `include "ral/my_mem.sv"
  `include "ral/my_alpha_reg.sv"
  `include "ral/my_beta_reg.sv"
  `include "ral/my_reg2bus_adapter.sv"
  `include "ral/my_muos_reg_block.sv"
  `include "ral/my_haos_reg_block.sv"
  
  //sequences
  `include "my_env_cfg.sv"
  `include "my_seq.sv"

  //tops
  `include "my_env.sv"
  `include "my_test.sv"

endpackage
