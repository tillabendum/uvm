module mem_indirect #(
    parameter DWIDTH          = 8,
    parameter AWIDTH          = 8,
    parameter INDIRECT_AWIDTH = 8 // For this example we set INDIRECT_AWIDTH no more than DWIDTH
  )(
    mem_if  mem_if,
    input   srst_i,
    input   clk_i
  );
localparam  OP            = 3;
localparam  INDIRECT_ADDR = 4;
localparam  INDIRECT_DATA = 5;
localparam  RDDATA        = 6;


reg  [DWIDTH - 1 : 0] mem[2 ** INDIRECT_AWIDTH];


// Indirect addressing registers
reg  [INDIRECT_AWIDTH - 1 : 0]                          indirect_addr;
reg  [DWIDTH          - 1 : 0]                          indirect_data;
reg  [DWIDTH          - 1 : 0]                          indirect_rddata;
typedef enum reg [1:0] { NOP = 2'b00, RD = 2'b01, WR = 2'b10 }  op_t;
op_t                                                    op;


always @( posedge clk_i )
  if( srst_i )
    begin
      indirect_addr <= 'x;
      indirect_data <= 'x;
      op            <= NOP;
    end
  else if( mem_if.wr )
    case( mem_if.addr )
      INDIRECT_ADDR:
        indirect_addr <= mem_if.data;
      INDIRECT_DATA:
        indirect_data <= mem_if.data;
      OP:
        op <= op_t'( mem_if.data );
    endcase


always @( posedge clk_i )
  if( mem_if.rd && mem_if.addr == RDDATA )
    begin
      mem_if.rddata       <= indirect_rddata;
      mem_if.rddatavalid  <= 1;
    end
  else
    begin
      mem_if.rddata      <= 0;
      mem_if.rddatavalid <= 0;
    end


always @( posedge clk_i )
  if( op == WR )
    mem[indirect_addr] <= indirect_addr;

always @( posedge clk_i )
  if( op ==   RD )
    indirect_rddata <= mem[indirect_addr];














endmodule
