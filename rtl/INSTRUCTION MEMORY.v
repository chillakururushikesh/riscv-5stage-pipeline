module instructionmemory(
    input [31:0] pc,
    output [31:0] instruction
);

    reg [31:0] mem [0:255];

    initial begin

        mem[0] = 32'h00A00093;  // addi x1, x0, 10
        mem[1] = 32'h00A00113;  // addi x2, x0, 10

        mem[2] = 32'h00208663;  // beq x1, x2, +12

        mem[3] = 32'h06400193;  // addi x3, x0, 100 - FLUSHED
        mem[4] = 32'h0C800213;  // addi x4, x0, 200 - FLUSHED

        mem[5] = 32'h03200293;  // addi x5, x0, 50 - TARGET

    end

    assign instruction = mem[pc[31:2]];

endmodule
