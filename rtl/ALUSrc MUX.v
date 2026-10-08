module alusrc(input idex_alusrc,input[31:0] forwardedb,idex_immediate,output [31:0]operandb);
  assign operandb=idex_alusrc?idex_immediate:forwardedb;
endmodule
