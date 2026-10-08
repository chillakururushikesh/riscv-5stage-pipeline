module IF_ID(input [31:0] pc,pcplus4,instruction,output reg [31:0]ifid_pc,ifid_pcplus4,ifid_instruction,input clk,rst,ifid_enable,ifid_flush);
 
  always@(posedge clk or posedge rst)begin
    if(rst)begin
      ifid_pc<=0;
      ifid_pcplus4<=0;
      ifid_instruction<=0;
    end
    else if(ifid_flush) begin
       ifid_pc<=0;
      ifid_pcplus4<=0;
      ifid_instruction<=0; end
    else if(ifid_enable)begin
      ifid_pc<=pc;
      ifid_pcplus4<=pcplus4;
      ifid_instruction<=instruction;end
  end
endmodule
