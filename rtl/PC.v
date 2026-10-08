module branchtaken_logic(
    input  idex_branch,
    input  zero,

    output branchtaken
);

assign branchtaken = idex_branch & zero;

endmodule
module pc_mux(

    input [31:0] pcplus4,
    input [31:0] branchtarget,
    input [31:0] jumptarget,

    input branchtaken,
    input idex_jump,

    output reg [31:0] pcnext

);

always @(*) begin

    if (idex_jump)
        pcnext = jumptarget;

    else if (branchtaken)
        pcnext = branchtarget;

    else
        pcnext = pcplus4;

end

endmodule
module jump_target(
    input  [31:0] idex_pc,
  input  [31:0] idex_immediate,
    output [31:0] jumptarget
);

assign jumptarget = idex_pc + idex_immediate;

endmodule
module pcplus4(input [31:0]pc,output [31:0]pcplus4);
  assign pcplus4=pc+4;
endmodule
module pc(input [31:0]pcnext,input clk,pcenable,input rst,output reg [31:0]pc);
  always@(posedge clk or posedge rst)begin
    if(rst)
      pc<=0;
    else if(pcenable)
      pc<=pcnext;
  end
endmodule
module branchtarget(
  input  [31:0] idex_pc,
  input  [31:0] idex_immediate,
    output [31:0] branchtarget
);

assign branchtarget = idex_pc + idex_immediate;
endmodule
