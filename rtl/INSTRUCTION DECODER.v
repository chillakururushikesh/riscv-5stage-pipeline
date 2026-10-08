module instructiondecoder(input [31:0]ifid_instruction,output[6:0]opcode,funct7,output [4:0]rd,rs1,rs2,output [2:0]funct3);
  assign opcode = ifid_instruction[6:0];
    assign rd     = ifid_instruction[11:7];
    assign funct3 = ifid_instruction[14:12];
    assign rs1    = ifid_instruction[19:15];
    assign rs2    = ifid_instruction[24:20];
    assign funct7 = ifid_instruction[31:25];
endmodule
