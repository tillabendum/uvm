class my_reset_cfg extends uvm_object;
  `uvm_object_utils(my_reset_cfg)

  virtual interface my_reset_if vif;

  function new(string name="cfg");
    super.new(name);  
  endfunction

endclass