class my_parent_sequence extends uvm_sequence #( my_seq_item );
`uvm_object_utils( my_parent_sequence );


function new( string name = "" );
   super.new( name );
endfunction: new


task body;

      fork
        begin
          my_sequence seq;
          seq = my_sequence::type_id::create("seq");
          seq.id = 0;
          seq.start(m_sequencer, this);
        end
        begin
          my_sequence seq;
          seq = my_sequence::type_id::create("seq");
          seq.id = 1;
          seq.start(m_sequencer, this);
        end
        begin
          my_sequence seq;
          seq = my_sequence::type_id::create("seq");
          seq.id = 2;
          seq.start(m_sequencer, this);
        end
        begin
          my_sequence seq;
          seq = my_sequence::type_id::create("seq");
          seq.id = 3;
          seq.start(m_sequencer, this);
        end
        begin
          my_sequence seq;
          seq = my_sequence::type_id::create("seq");
          seq.id = 4;
          seq.start(m_sequencer, this);
        end
      join
endtask

endclass