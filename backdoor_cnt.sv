class backdoor_cnt extends backdoor;
  `uvm_component_utils(backdoor_cnt)
  
  function new(string name="", uvm_component parent=null);
    super.new(name, parent);
  endfunction


  // This method to be implemented by subclasses.
    virtual function uvm_object sample();
        uvm_object_cnt  tr;
        uvm_hdl_data_t value;
        
        //Put backdoor accesses here
        //Convert data from backdoor accesses to class that exteds uvm_object and return it
        tr = uvm_object_cnt::type_id::create("tr");
        if(uvm_hdl_read("top.sub.cnt", value)) begin
            tr.cnt = value;
            return tr;
        end else begin
            `uvm_error("BackdoorReadError", "Failed to read handle")
        end

        return tr;
    
    endfunction


endclass