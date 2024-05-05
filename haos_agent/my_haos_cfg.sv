class my_haos_cfg extends uvm_object;
  `uvm_object_utils(my_haos_cfg)

  virtual interface my_haos_if vif;

  function new(string name="cfg");
    super.new(name);  
  endfunction

endclass