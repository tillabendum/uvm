class comp_base extends uvm_component;
`uvm_component_utils( comp_base )


function new ( string name = "comp_base", uvm_component parent = null );
  super.new( name, parent );
endfunction: new





  // Function: raised
  //
  // The ~raised~ callback is called when this or a descendant of this component
  // instance raises the specified ~objection~. The ~source_obj~ is the object
  // that originally raised the objection. 
  // The ~description~ is optionally provided by the ~source_obj~ to give a
  // reason for raising the objection. The ~count~ indicates the number of
  // objections raised by the ~source_obj~.

  virtual function void raised (uvm_objection objection, uvm_object source_obj, 
      string description, int count);
      `uvm_info("ph", "raised()", UVM_NONE)
  endfunction


  // Function: dropped
  //
  // The ~dropped~ callback is called when this or a descendant of this component
  // instance drops the specified ~objection~. The ~source_obj~ is the object
  // that originally dropped the objection. 
  // The ~description~ is optionally provided by the ~source_obj~ to give a
  // reason for dropping the objection. The ~count~ indicates the number of
  // objections dropped by the ~source_obj~.

  virtual function void dropped (uvm_objection objection, uvm_object source_obj, 
      string description, int count);
      `uvm_info("ph", "dropped()", UVM_NONE)
  endfunction


  // Task: all_dropped
  //
  // The ~all_droppped~ callback is called when all objections have been 
  // dropped by this component and all its descendants.  The ~source_obj~ is the
  // object that dropped the last objection.
  // The ~description~ is optionally provided by the ~source_obj~ to give a
  // reason for raising the objection. The ~count~ indicates the number of
  // objections dropped by the ~source_obj~.

  virtual task all_dropped (uvm_objection objection, uvm_object source_obj, 
      string description, int count);
       `uvm_info("ph", "all_dropped()", UVM_NONE)
  endtask

  virtual function void phase_ready_to_end (uvm_phase phase);
       `uvm_info("ph", {"phase_ready_to_end(): ", phase.get_full_name()}, UVM_NONE)
  endfunction


  function void phase_started(uvm_phase phase);
    `uvm_info("ph", {"phase_started(): ", phase.get_full_name()}, UVM_NONE)
  endfunction

  // phase_ended
  // -----------
  function void phase_ended(uvm_phase phase);
    `uvm_info("ph", {"phase_ended(): ", phase.get_full_name()}, UVM_NONE)
  endfunction
endclass
