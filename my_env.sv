class my_env extends uvm_env;
`uvm_component_utils( my_env )

backdoor_cnt bkdr_cnt;
uvm_blocking_get_port#(uvm_object)   port;

function new ( string name = "my_env", uvm_component parent = null );
  super.new( name, parent );
endfunction: new

virtual function void build_phase( uvm_phase phase );
  super.build_phase( phase );

  bkdr_cnt = backdoor_cnt::type_id::create("bkdr_cnt", this);
  port = new("port", this);
endfunction : build_phase

virtual function void connect_phase( uvm_phase phase );
  port.connect(bkdr_cnt.imp);
endfunction


task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  repeat(5) begin
    uvm_object      item;
    uvm_object_cnt  object_cnt;

    port.get(item);
    if(!$cast(object_cnt, item)) begin
      `uvm_fatal("casting", "Failed to cast item to uvm_object_cnt")
    end

    `uvm_info("run_phase", $sformatf("Received cnt: %0d", object_cnt.cnt), UVM_MEDIUM)

  end
  
  
  phase.drop_objection(this);
endtask

endclass:my_env
