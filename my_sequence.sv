class my_sequence extends uvm_sequence #( my_seq_item );
`uvm_object_utils( my_sequence );


int id;


function new( string name = "" );
   super.new( name );
endfunction: new

semaphore sem;


task body;
      localparam num_steps = 5;

      my_seq_item req[num_steps];

    

      for (int i = 0; i < num_steps; i++) begin
        req[i] = my_seq_item::type_id::create("req");
        req[i].cnt = i;
        req[i].id = id;
      end

      sem = new(num_steps);
      for (int j = 0; j < num_steps; j++ ) begin
        automatic int i = j;
        fork
          begin
            `uvm_info("seq", {"flow: ", req[i].convert2string()}, UVM_NONE)
            start_item( req[i] );
            //`uvm_info("seq", $sformatf("start №%0d", i ), UVM_NONE)
            finish_item( req[i] );
            //`uvm_info("seq", $sformatf("finish №%0d", i ), UVM_NONE)
          end
        join_none
      end
#(100ns);
      //sem.get(num_steps);
endtask

endclass
