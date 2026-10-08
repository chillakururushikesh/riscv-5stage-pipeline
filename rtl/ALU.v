module alu( input  [31:0] forwardeda,input  [31:0] operand_b,
  input  [3:0]  alucontrol, output reg [31:0] aluresult,output zero);

always @(*) begin
    case (alucontrol)
        4'b0000: aluresult = forwardeda + operand_b;  // ADD
        4'b0001: aluresult = forwardeda - operand_b;  // SUB
        4'b0010: aluresult = forwardeda & operand_b;  // AND
        4'b0011: aluresult = forwardeda | operand_b;  // OR
        4'b0100: aluresult = forwardeda ^ operand_b;  // XOR

        4'b0101: aluresult = forwardeda << operand_b[4:0]; // SLL
        4'b0110: aluresult = forwardeda >> operand_b[4:0]; // SRL
        4'b0111: aluresult = $signed(forwardeda) >>> operand_b[4:0]; // SRA

        4'b1000: aluresult =
                 ($signed(forwardeda) < $signed(operand_b)) ? 32'd1 : 32'd0; // SLT

        4'b1001: aluresult =
                 (forwardeda < operand_b) ? 32'd1 : 32'd0; // SLTU

        default: aluresult = 32'd0;
    endcase
end

assign zero = (aluresult == 32'd0);

endmodule
