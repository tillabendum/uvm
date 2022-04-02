module mem #(
    parameter DWIDTH = 8,
    parameter AWIDTH = 6
  )(
    mem_if  mem_if,
    input clk_i
  );




reg  [DWIDTH - 1 : 0] mem[2 ** AWIDTH];


always @( posedge clk_i )
  if( mem_if.wr )
    mem[mem_if.addr] <= mem_if.data;

always @( posedge clk_i )
  if( mem_if.rd )
    begin
     mem_if.rddata      <= mem[mem_if.addr];
     mem_if.rddatavalid <= 1;
    end
  else
    begin
     mem_if.rddata      <= 0;
     mem_if.rddatavalid <= 0;
    end



endmodule
