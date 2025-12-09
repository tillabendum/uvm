class my_comp #(parameter params_t PARAMS = DEFAULT_PARAMS) extends my_comp_abstract;
  `uvm_component_param_utils(my_pkg::my_comp#(PARAMS))

  function new(string name = "my_comp", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  // Checking for parameters override
  function string convert2string();
    return $sformatf("WIDTH=%0d, DEPTH=%0d", PARAMS.WIDTH, PARAMS.DEPTH);
  endfunction
endclass : my_comp
