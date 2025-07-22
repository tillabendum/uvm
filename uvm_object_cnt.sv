class uvm_object_cnt extends uvm_object;
`uvm_object_utils(uvm_object_cnt)
    int cnt;
    
    function new(string name="uvm_object_cnt");
        super.new(name);
    endfunction
    
endclass