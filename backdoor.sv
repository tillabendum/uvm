class backdoor extends uvm_component;
`uvm_component_utils(backdoor)

uvm_blocking_get_imp#(uvm_object, backdoor)   imp;
backdoor_if_proxy                    iproxy;

function new(string name="", uvm_component parent=null);
    super.new(name, parent);
endfunction


function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db #(backdoor_if_proxy)::get(this, "", "iproxy", iproxy)) begin
        `uvm_fatal({get_full_name(), ".if_get_fail"}, "Cannot get iproxy")
    end

    imp = new("imp", this);
endfunction


task get(output uvm_object item);
    iproxy.wait_posedge();
    item = sample();
endtask

// This method to be implemented by subclasses.
virtual function uvm_object sample();
    //Put backdoor accesses here
    //Convert data from backdoor accesses to class that exteds uvm_object and return it
endfunction
endclass