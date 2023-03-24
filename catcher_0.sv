class catcher_0 extends uvm_report_catcher;
  function new(string name="catcher_0");
    super.new(name);
  endfunction


  function action_e catch();
    uvm_report_info("catcher_0", "start pursuit", UVM_NONE);
    if (get_severity() == UVM_INFO) begin
      uvm_report_info("catcher_0", "found info severity", UVM_NONE);
      set_verbosity(UVM_DEBUG);
      issue();
    end
    return THROW;

  endfunction


endclass
