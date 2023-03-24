class catcher_1 extends uvm_report_catcher;
  function new(string name="catcher_1");
    super.new(name);
  endfunction


  function action_e catch();
    uvm_report_info("catcher_1", $psprintf("start pursuit on message verb=%03d", get_verbosity()), UVM_NONE);
    if (get_id() == "catcher_0") begin
      uvm_report_info("catcher_1", "found report from catcher_0", UVM_NONE);
    end
    if (get_id() == "mouse") begin
      uvm_report_info("catcher_1", "found mouse", UVM_NONE);
    end
    return THROW;

  endfunction


endclass
