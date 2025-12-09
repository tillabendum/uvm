class my_comp_abstract extends uvm_component;
    `uvm_component_utils(my_pkg::my_comp_abstract)

    uvm_blocking_put_port #(.T(int)) port;

    function new(string name = "abstract", uvm_component parent = null);
    super.new(name, parent);
    endfunction : new

    virtual function void build_phase( uvm_phase phase );
      super.build_phase( phase );

      port = new("port", this);
    endfunction
endclass


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
