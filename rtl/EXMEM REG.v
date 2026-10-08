module EX_MEM(
    input clk,
    input rst,

    input [31:0] alu_result,idex_pcplus4,
    input [31:0] store_data,//data to be written to memory in case of store instruction its forwardedb only 
    input [4:0]  idex_rd,

    input idex_MemRead,idex_jump,
    input idex_MemWrite,
    input idex_MemToReg,
    input idex_RegWrite,

    output reg [31:0] exmem_alu_result,exmem_pcplus4,
    output reg [31:0] exmem_store_data,
    output reg [4:0]  exmem_rd,

    output reg exmem_MemRead,exmem_jump,
    output reg exmem_MemWrite,
    output reg exmem_MemToReg,
    output reg exmem_RegWrite
);

    always @(posedge clk or posedge rst) begin

        if (rst) begin
            exmem_alu_result  <= 32'b0;
            exmem_store_data  <= 32'b0;
            exmem_rd          <= 5'b0;
            exmem_jump        <= 1'b0;

            exmem_MemRead     <= 1'b0;
            exmem_MemWrite    <= 1'b0;
            exmem_MemToReg    <= 1'b0;
            exmem_RegWrite    <= 1'b0;
            exmem_pcplus4     <= 32'b0;
        end

        else begin
            exmem_alu_result  <= alu_result;
            exmem_store_data  <= store_data;
            exmem_rd          <= idex_rd;
            exmem_jump        <= idex_jump;

            exmem_MemRead     <= idex_MemRead;
            exmem_MemWrite    <= idex_MemWrite;
            exmem_MemToReg    <= idex_MemToReg;
            exmem_RegWrite    <= idex_RegWrite;
            exmem_pcplus4     <= idex_pcplus4;
        end

    end

endmodule
