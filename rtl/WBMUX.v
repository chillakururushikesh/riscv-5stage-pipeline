module wb(
    input [31:0] memwb_readdata,
    input [31:0] memwb_aluresult,
    input [31:0] memwb_pcplus4,
    input memwb_MemToReg,
    input memwb_jump,
    output [31:0] writedata
);

    assign writedata = memwb_jump ?
                       memwb_pcplus4 :
                       (memwb_MemToReg ? memwb_readdata : memwb_aluresult);

endmodule
