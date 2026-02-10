virtual class harness_if_proxy #(type T=int, string VAR_NAME="");
  pure virtual function T       get_current_val();
  pure virtual function T       get_preponed_val();
  pure virtual task             wait_posedge();
  pure virtual function bit     name(output string str);

  static harness_if_proxy#(.T(T), .VAR_NAME(VAR_NAME)) proxies[$];
  
  function new();
    // Register action
    proxies.push_back(this);
  endfunction
endclass