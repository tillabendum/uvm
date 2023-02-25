class my_env extends uvm_env;
`uvm_component_utils( my_env )

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

  UVM_FILE desc_default;       // All infos got there
  UVM_FILE desc_warnings;      // Warnings got there
  UVM_FILE desc_my_id;   // Selected id event arrive at this location

virtual function void build_phase( uvm_phase phase );
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

  reporting_with_macros();
  check_logging();
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
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
