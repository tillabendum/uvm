class my_env extends uvm_env;
`uvm_component_utils( my_env )

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );
  reporting_with_macros();
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  super.connect_phase( phase );
endfunction


function reporting_with_macros();
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






endclass:my_env
