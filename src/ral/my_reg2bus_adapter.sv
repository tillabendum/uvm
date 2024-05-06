class my_reg2bus_adapter extends uvm_reg_adapter;
  `uvm_object_utils( my_reg2bus_adapter )

function new(
    string name = "my_reg2bus_adapter"
  );
  super.new( name );
  // If byte enable lane exists set 1
  this.supports_byte_enable = 1;

  // It should be 1 if target agent driver sends separate response items
  // that require response handling
  this.provides_responses   = 1;
endfunction

// This function accepts  a register item of type "uvm_reg_bus_op" and assigns
// address, data and other required fields to the bus protocol sequence item.
virtual function uvm_sequence_item reg2bus (
    const ref uvm_reg_bus_op rw
  );
  my_haos_tr tr;

  tr = my_haos_tr::type_id::create("tr");
  case (rw.kind)
    UVM_WRITE: tr.op = WR;
    UVM_READ:  tr.op = RD;
    default: begin
      `uvm_fatal("ral", $sformatf("Unexpected kind %s", rw.kind.name))
    end
  endcase
  
  tr.addr  = rw.addr;
  tr.data  = rw.data;
  tr.wstrb = rw.byte_en; 
  case (rw.status)
    UVM_IS_OK: tr.status = OK;
    UVM_HAS_X: tr.status = ERR;
    UVM_NOT_OK: tr.status = ERR;
  endcase
  return tr;
endfunction

// This function accepts a bus sequence_item and assigns address/data fields to
// the register item
virtual function void bus2reg(
    uvm_sequence_item   bus_item,
    ref uvm_reg_bus_op  rw
  );
  my_haos_tr tr;

  // bus_item is a base class handle of type "uvm_sequence_item" and hense does
  // not contain addr, data properties in it. Hence bus_item has to be cast into
  // my_haos_tr
  if( !$cast( tr, bus_item ) ) begin
    `uvm_fatal( get_name, "Failed to cast into my_haos_tr")
  end

  rw.addr = tr.addr;
  rw.data = tr.data;

  case (tr.op)
    WR: begin
      rw.kind = UVM_WRITE;
      rw.byte_en = tr.wstrb; 
    end

    RD: begin
      rw.kind = UVM_READ;
      rw.byte_en = '1; 
    end

    default: begin
      `uvm_fatal("ral", $sformatf("Unexpected op %s", tr.op.name))
    end
  endcase
  
  case(tr.status)
    OK:  rw.status = UVM_IS_OK;
    ERR: rw.status = UVM_NOT_OK;
    default: begin
      `uvm_fatal("ral", $sformatf("Unexpected status %s", tr.status.name))
    end
  endcase
endfunction


endclass
