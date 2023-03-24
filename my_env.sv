class my_env extends uvm_env;

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

  UVM_FILE desc_default;       // All infos got there
  UVM_FILE desc_warnings;      // Warnings got there
  UVM_FILE desc_my_id;   // Selected id event arrive at this location

  my_obj        obj;
  my_comp       comp;

`uvm_component_utils_begin( my_env )
  `uvm_field_object( obj, UVM_DEFAULT)
`uvm_component_utils_end


virtual function void build_phase( uvm_phase phase );
  catcher_0 cat_0=new;
  catcher_1 cat_1=new;
  super.build_phase( phase );

  //Preparing files for reporting
  desc_default  = $fopen( "default.log", "w" );
  desc_warnings = $fopen( "warnings.log", "w" );
  desc_my_id    = $fopen( "my_id.log", "w" );
  set_report_default_file( desc_default );
  set_report_severity_file( UVM_WARNING, desc_warnings );
  set_report_id_file( "my_id", desc_my_id );

  //Defining actions locally to environment
  set_report_severity_action( UVM_WARNING, UVM_DISPLAY |  UVM_LOG );

  obj = my_obj::type_id::create("obj", this);
  comp= my_comp::type_id::create("comp", this);

  uvm_report_cb::add(comp, cat_0);
  uvm_report_cb::add(comp, cat_1);


  reporting_with_macros();
  check_logging();
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase(phase);
endfunction


virtual function void start_of_simulation_phase(uvm_phase phase);
  obj.touch();
endfunction

virtual function void end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
  //umv_factory::print();

endfunction


function void reporting_with_macros();
  string str;
  int    val;
  int    val2;
  my_obj obj;
  str = "My string value";
  val = 12;
  `uvm_warning("debug", "Common warning")
  `uvm_warning_begin("debug", "Complex warning")
    `uvm_message_add_tag("Label for str(literal)", "My string value")
    `uvm_message_add_string(str, "Label for str(val)")
    `uvm_message_add_int(12, UVM_BIN, "Label for int(literal)")
    `uvm_message_add_int(val, UVM_BIN, "Label for int(val)")
  `uvm_warning_end


  obj = my_obj::type_id::create( "obj" );
  obj.val = my_obj::DEI;
  val2 = 101;
  `uvm_warning_begin("debug", "Complex warning with object and int")
   `uvm_message_add_int(val2, UVM_DEC, "Second integer")
   `uvm_message_add_object(obj, "Reason")
  `uvm_warning_end
endfunction


function void check_logging();
  // Logging of this files is enabled from hierarchy-up level from test
  `uvm_info("some_id", "Must be logged in default file", UVM_NONE )
  `uvm_info("my_id", "Must be logged in my_id file", UVM_NONE )
endfunction




endclass:my_env
