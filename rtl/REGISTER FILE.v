module regfile(
    input clk,
    input regwrite,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] writedata,
    output [31:0] readdata1,
    output [31:0] readdata2
);

    reg [31:0] register [0:31];

    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
            register[i] = 32'b0;
    end

    assign readdata1 = (rs1 == 5'b0) ? 32'b0 :
                   (regwrite && rd != 5'b0 && rd == rs1) ? writedata :
                   register[rs1];

assign readdata2 = (rs2 == 5'b0) ? 32'b0 :
                   (regwrite && rd != 5'b0 && rd == rs2) ? writedata :
                   register[rs2];

    always @(posedge clk) begin
        if (regwrite && rd != 5'b0)
            register[rd] <= writedata;
    end

endmodule
