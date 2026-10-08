module datamemory(input clk,exmem_MemRead,exmem_MemWrite,input [31:0]exmem_store_data,output [31:0]readdata,input [31:0]address);
  reg [31:0]mem [0:255];
  initial begin
    mem[25] = 32'd50;
end
  assign readdata=exmem_MemRead ? mem[address[31:2]]:32'd0;
  always@(posedge clk)
    begin
      if(exmem_MemWrite)
        mem[address[31:2]]<=exmem_store_data;
    end
endmodule
