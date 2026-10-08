module mem_wb(input exmem_RegWrite,exmem_MemToReg,clk,rst,exmem_jump,input [31:0]readdata,exmem_alu_result,exmem_pcplus4,input [4:0]exmem_rd,output reg [31:0] memwb_aluresult,
    output reg [31:0] memwb_readdata,memwb_pcplus4,
    output reg [4:0] memwb_rd,

    output reg memwb_MemToReg,memwb_jump,
              output reg memwb_RegWrite);
  always@(posedge clk)begin
    if(rst)
      begin
        memwb_aluresult <= 32'b0;
            memwb_readdata   <= 32'b0;
            memwb_rd         <= 5'b0;

            memwb_MemToReg   <= 1'b0;
            memwb_jump       <= 1'b0;
            memwb_RegWrite   <= 1'b0;
            memwb_pcplus4    <= 32'b0;
        end
    else begin
      memwb_aluresult <= exmem_alu_result;
            memwb_readdata   <= readdata;
            memwb_rd         <= exmem_rd;
            memwb_pcplus4    <= exmem_pcplus4;

            memwb_MemToReg   <= exmem_MemToReg;
            memwb_jump       <= exmem_jump;
            memwb_RegWrite   <= exmem_RegWrite;
        end

    end

endmodule
