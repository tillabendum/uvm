class catcher_1 extends uvm_report_catcher;
  function new(string name="catcher_1");
    super.new(name);
  endfunction


  function action_e catch();
    uvm_report_info("catcher_1", "start pursuit", UVM_NONE)
    if (get_id() == "mouse") begin
      uvm_report_info("catcher_1", "found mouse", UVM_NONE)
      return THROW;
    end

  endfunction


endclass
