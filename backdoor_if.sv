interface backdoor_if(input clk);

    clocking cb @(posedge clk);
    endclocking


    class proxy_concrete extends my_pkg::backdoor_if_proxy;

        task wait_posedge();
            @cb;
        endtask
        
    endclass

    // Get instance of concrete_proxy
    function static my_pkg::backdoor_if_proxy get_proxy();
        proxy_concrete proxy;
        if (proxy == null) begin
        proxy = new();
        end
        return proxy;
    endfunction : get_proxy




endinterface //backdoor_if