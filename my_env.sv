class my_env extends uvm_env;
`uvm_component_utils(my_env)

my_drv                        drv;
uvm_sequencer #(my_seq_item)  sequencer;
my_sequence                   seq[2];

function new (string name = "my_env", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  sequencer = new ("sequencer", this);
  drv = my_drv::type_id::create("drv", this);
  seq[0] = my_sequence::type_id::create("seq_0", this);
  seq[1] = my_sequence::type_id::create("seq_1", this);
endfunction : build_phase

virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  drv.seq_item_port.connect(sequencer.seq_item_export);
endfunction

task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  fork
   seq[0].start(sequencer);
   seq[1].start(sequencer);
  join
  phase.drop_objection(this);

endtask : run_phase

endclass:my_env
