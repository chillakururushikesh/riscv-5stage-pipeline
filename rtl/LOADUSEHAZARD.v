module hazarddetection(input idex_memread,input [4:0]idex_rd,ifid_rs1,ifid_rs2,output reg stall);
  always@(*)begin
    stall=1'b0;
    if(idex_memread && (idex_rd!=0)&& ((idex_rd==ifid_rs1)||(idex_rd==ifid_rs2)))
      stall=1'b1;
  end
endmodule
