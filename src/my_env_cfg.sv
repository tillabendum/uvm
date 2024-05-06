class my_env_cfg extends uvm_object;
  `uvm_object_utils(my_env_cfg)

  my_reset_cfg      reset_cfg;
  my_haos_cfg       haos_cfg;
  my_haos_reg_block ral;  
  
  function new(string name="cfg");
    super.new(name);  
  endfunction

endclass 