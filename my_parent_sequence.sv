class my_parent_sequence extends uvm_sequence #( my_seq_item );
`uvm_object_utils( my_parent_sequence );


function new( string name = "" );
   super.new( name );
endfunction: new


task body;
      my_sequence seq;

      seq = my_sequence::type_id::create("seq");
      seq.start(m_sequencer, this);
endtask

endclass