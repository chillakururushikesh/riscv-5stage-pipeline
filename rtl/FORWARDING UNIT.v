module forwarding(output reg [1:0]forwarda,forwardb,input [4:0]idex_rs1,idex_rs2,exmem_rd,memwb_rd,input exmem_regwrite,memwb_regwrite);
  always@(*)begin
    forwarda = 2'b00;
        forwardb = 2'b00;
    if((exmem_regwrite && exmem_rd!=5'b0)&&(idex_rs1==exmem_rd))
      forwarda=2'b10;
    else if (memwb_regwrite && 
                 (memwb_rd != 5'b0) &&
                 (memwb_rd == idex_rs1))
            forwarda = 2'b01;
    if((exmem_regwrite && exmem_rd!=5'b0)&&(idex_rs2==exmem_rd))
      forwardb=2'b10;
    else if (memwb_regwrite &&
                 (memwb_rd != 5'b0) &&
      (memwb_rd == idex_rs2))
            forwardb = 2'b01;
            $display("FORWARD UNIT: RS1=%d RS2=%d EXMEM_RD=%d EXMEM_RW=%b MEMWB_RD=%d MEMWB_RW=%b FA=%b FB=%b",
             idex_rs1, idex_rs2,
             exmem_rd, exmem_regwrite,
             memwb_rd, memwb_regwrite,
             forwarda, forwardb);
  end
  
endmodule
module forwardmux(input [1:0]forwarda,forwardb,input [31:0] exmem_aluresult,writedata,input [31:0]idex_readdata1,idex_readdata2,output reg [31:0]forwardeda,forwardedb);
  always@(*)begin
    case(forwarda)
      2'b00: forwardeda = idex_readdata1;

            2'b10: forwardeda = exmem_aluresult;

            2'b01: forwardeda = writedata;
    endcase
    case(forwardb)
      2'b00: forwardedb = idex_readdata2;

            2'b10: forwardedb = exmem_aluresult;

            2'b01: forwardedb = writedata;

    endcase end
endmodule
