class reg2bus_adapter extends uvm_reg_adapter;
  `uvm_object_utils( reg2bus_adapter )

function new(
    string name = "reg2bus_adapter"
  );
  super.new( name );
  // If byte enable lane exists set 1
  this.supports_byte_enable = 0;

  // It should be 1 if target agent driver sends separate response items
  // that require response handling
  this.provides_responses   = 0;
endfunction

// This function accepts  a register item of type "uvm_reg_bus_op" and assigns
// address, data and other required fields to the bus protocol sequence item.
virtual function uvm_sequence_item reg2bus (
    const ref uvm_reg_bus_op rw
  );
  mem_req_item item;
  item = mem_req_item::type_id::create( "item" );
  if( rw.kind == UVM_WRITE )
    item.op = mem_req_item::WR;
  item.addr = rw.addr;
  item.data = rw.data;
  `uvm_info( get_name, $psprintf( "reg2bus addr = %0h, data = %0h, kind = %s", item.addr, item.data, rw.kind.name ), UVM_DEBUG )
  return item;
endfunction

// This function accepts a bus sequence_item and assigns address/data fields to
// the register item
virtual function void bus2reg(
    uvm_sequence_item   bus_item,
    ref uvm_reg_bus_op  rw
  );
  mem_req_item item;

  // bus_item is a base class handle of type "uvm_sequence_item" and hense does
  // not contain addr, data properties in it. Hence bus_item has to be cast into
  // mem_req_item
  if( !$cast( item, bus_item ) )
    `uvm_fatal( get_name, "Failed to cast into mem_req_item")

  rw.addr   = item.addr;
  rw.data   = item.data;
  rw.status = UVM_IS_OK;

  if( item.op == mem_req_item::WR )
    rw.kind = UVM_WRITE;
  else if( item.op == mem_req_item::RD )
    rw.kind   = UVM_READ;

  `uvm_info( get_name, $psprintf( "bus2reg: addr=%0h, data=%0h, kind=%s, status=%s", rw.addr, rw.data, rw.kind.name, rw.status.name ), UVM_DEBUG )
endfunction


endclass
