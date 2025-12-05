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



class my_comp #(parameter int unsigned WIDTH = 8) extends my_comp_abstract;
  `uvm_component_utils(my_pkg::my_comp)

  function new(string name = "my_comp", uvm_component parent = null);
    super.new(name, parent);
    //
  endfunction : new


  virtual function void build_phase( uvm_phase phase );
    super.build_phase( phase );
    //
  endfunction
endclass : my_comp



