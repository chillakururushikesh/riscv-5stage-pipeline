module ID_EX(
    input clk,
    input rst,
    input idex_flush,

    input [31:0] ifid_pc,
    input [31:0] ifid_pcplus4,
    input [31:0] readdata1,
    input [31:0] readdata2,
    input [31:0] immediate,

    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [2:0] funct3,
    input [6:0] funct7,
    input [6:0] opcode,

    input RegWrite,
    input MemRead,
    input MemWrite,
    input MemToReg,
    input ALUSrc,
    input Branch,
    input Jump,
    input [1:0] ALUOp,
  

    output reg [31:0] idex_pc,
    output reg [31:0] idex_pcplus4,
    output reg [31:0] idex_readdata1,
    output reg [31:0] idex_readdata2,
    output reg [31:0] idex_immediate,

    output reg [4:0] idex_rs1,
    output reg [4:0] idex_rs2,
    output reg [4:0] idex_rd,
    output reg [2:0] idex_funct3,
    output reg [6:0] idex_funct7,idex_opcode,

    output reg idex_RegWrite,
    output reg idex_MemRead,
    output reg idex_MemWrite,
    output reg idex_MemToReg,
    output reg idex_ALUSrc,
    output reg idex_Branch,
    output reg idex_Jump,
    output reg [1:0] idex_ALUOp
   

);


    always @(posedge clk or posedge rst) begin

        if (rst) begin

            idex_pc          <= 0;
            idex_pcplus4     <= 0;
            idex_readdata1   <= 0;
            idex_readdata2   <= 0;
            idex_immediate   <= 0;

            idex_rs1         <= 0;
            idex_rs2         <= 0;
            idex_rd          <= 0;
            idex_funct3      <= 0;
            idex_funct7      <= 0;
            idex_opcode      <= 0;

            idex_RegWrite    <= 0;
            idex_MemRead     <= 0;
            idex_MemWrite    <= 0;
            idex_MemToReg    <= 0;
            idex_ALUSrc      <= 0;
            idex_Branch      <= 0;
            idex_Jump        <= 0;
            idex_ALUOp       <= 0;


        end

      else if (idex_flush) begin

            idex_pc          <= 0;
            idex_pcplus4     <= 0;
            idex_readdata1   <= 0;
            idex_readdata2   <= 0;
            idex_immediate   <= 0;

            idex_rs1         <= 0;
            idex_rs2         <= 0;
            idex_rd          <= 0;
            idex_funct3      <= 0;
            idex_funct7      <= 0;
            idex_opcode      <= 0;

            idex_RegWrite    <= 0;
            idex_MemRead     <= 0;
            idex_MemWrite    <= 0;
            idex_MemToReg    <= 0;
            idex_ALUSrc      <= 0;
            idex_Branch      <= 0;
            idex_Jump        <= 0;
            idex_ALUOp       <= 0;

        end

        else begin

            idex_pc          <= ifid_pc;
            idex_pcplus4     <= ifid_pcplus4;
            idex_readdata1   <= readdata1;
            idex_readdata2   <= readdata2;
            idex_immediate   <= immediate;

            idex_rs1         <= rs1;
            idex_rs2         <= rs2;
            idex_rd          <= rd;
            idex_funct3      <= funct3;
            idex_funct7      <= funct7;
            idex_opcode      <= opcode;

            idex_RegWrite    <= RegWrite;
            idex_MemRead     <= MemRead;
            idex_MemWrite    <= MemWrite;
            idex_MemToReg    <= MemToReg;
            idex_ALUSrc      <= ALUSrc;
            idex_Branch      <= Branch;
            idex_Jump        <= Jump;
            idex_ALUOp       <= ALUOp;

        end
    end

endmodule
