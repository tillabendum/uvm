virtual class harness_if_proxy #(type T=int);
  pure virtual function T       get_current_val();
  pure virtual function T       get_preponed_val();
  pure virtual task             wait_posedge();
  pure virtual function bit     name(output string str);

  static harness_if_proxy#(.T(T)) proxies[$];
  
  function new();
    // Register action
    proxies.push_back(this);
  endfunction
endclass