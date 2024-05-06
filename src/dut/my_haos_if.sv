interface my_haos_if(
    input clk,
    input reset
  );
  
  import my_haos_pkg::*;
  
  // Request channel
  logic                                 rd;
  logic                                 wr;
  logic [AWIDTH-1:0]                    addr;
  logic [NUM_DATA_BYTES-1:0][7:0]       wdata;
  logic [NUM_DATA_BYTES-1:0]            wstrb;
  
  // Back write channel
  status_t                              wstatus;
  logic                                 wstatus_valid;

  // Back read channel
  logic [NUM_DATA_BYTES-1:0][7:0]       rdata;
  logic                                 rdata_valid;
  status_t                              rstatus;


  unknown_wr: assert property (
    @(posedge clk)
    disable iff ( reset !== 1'b0 ) 
    !$isunknown(wr)
  ) else begin
    $error("Unknown write signal");
  end

    unknown_rd: assert property (
    @(posedge clk)
    disable iff ( reset !== 1'b0 ) 
    !$isunknown(rd)
  ) else begin
    $error("Unknown read signal");
  end
  
endinterface
