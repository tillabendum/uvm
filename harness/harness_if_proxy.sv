virtual class harness_if_proxy #(type T=int);
  pure virtual function T get_val();
  pure virtual function void force_val(T new_val);

  static harness_if_proxy#(.T(T)) proxies[$];
  
  function new();
    // Register action
    proxies.push_back(this);
  endfunction
endclass