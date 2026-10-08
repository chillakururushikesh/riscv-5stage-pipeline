module topmodule(input clk,rst);
wire [31:0]pcnext,pc;
wire pcenable;
wire [31:0]pcplus4,branchtarget,jumptarget;

wire branch,zero,branchtaken;
wire [31:0]instruction;
wire [31:0]ifid_pc,ifid_pcplus4,ifid_instruction;
wire ifid_enable;
wire [6:0]opcode;
wire [2:0]funct3;
wire [6:0]funct7;
wire [4:0]rs1,rs2,rd;
wire regwrite,memread,memwrite,alusrc,memtoreg,jump;
wire [1:0]aluop;
wire [31:0]readdata1,readdata2,writedata;
wire idex_RegWrite,idex_MemRead,idex_MemWrite,idex_MemToReg,idex_ALUSrc,idex_Branch,idex_Jump;
wire [1:0]idex_ALUOp;
wire [31:0]idex_pcplus4,idex_readdata1,idex_readdata2;
wire [4:0]idex_rs1,idex_rs2,idex_rd;
wire [2:0]idex_funct3;
wire [6:0] idex_opcode;
wire [6:0]idex_funct7;
wire idex_flush;
wire [31:0]idex_pc,idex_immediate;
wire [3:0]alucontrol;
wire [31:0]aluresult;
wire [31:0]operandb;
wire [31:0]forwardedb,forwardeda;
wire [1:0]forwarda,forwardb;
wire [4:0]exmem_rd,memwb_rd;
wire exmem_RegWrite;
wire [31:0]memwb_writedata,exmem_alu_result;
wire stall;
wire [31:0]readdata;
wire [31:0]exmem_store_data;
wire exmem_MemRead,exmem_MemWrite,exmem_MemToReg;
wire [31:0]memwb_readdata,memwb_aluresult;
wire memwb_MemToReg,memwb_RegWrite;
wire ifid_flush;
assign ifid_flush=branchtaken|idex_Jump;
assign pcenable = ~stall;
assign ifid_enable = ~stall;
assign idex_flush = stall|branchtaken|idex_Jump;
wire [31:0]immediate;
wire exmem_jump,memwb_jump;
wire [31:0]memwb_pcplus4,exmem_pcplus4;
pc pc1(.pcnext(pcnext),.clk(clk),.pcenable(pcenable),.rst(rst),.pc(pc));
pcplus4 pcplus4_1(.pc(pc),.pcplus4(pcplus4));
jump_target jump_target1(.idex_pc(idex_pc),.idex_immediate(idex_immediate),.jumptarget(jumptarget));
branchtaken_logic branchtaken1(.idex_branch(idex_Branch),.zero(zero),.branchtaken(branchtaken));
branchtarget branchtarget1(.idex_pc(idex_pc),.idex_immediate(idex_immediate),.branchtarget(branchtarget));
pc_mux pc_mux1(.pcplus4(pcplus4),.branchtarget(branchtarget),.jumptarget(jumptarget),.branchtaken(branchtaken),.idex_jump(idex_Jump),.pcnext(pcnext));
instructionmemory instructionmemory1(.pc(pc),.instruction(instruction));
IF_ID if_id1(.pc(pc),.pcplus4(pcplus4),.instruction(instruction),.ifid_pc(ifid_pc),.ifid_pcplus4(ifid_pcplus4),.ifid_instruction(ifid_instruction),.clk(clk),.rst(rst),.ifid_enable(ifid_enable),.ifid_flush(ifid_flush));
instructiondecoder instructiondecoder1(.ifid_instruction(ifid_instruction),.opcode(opcode),.funct7(funct7),.rd(rd),.rs1(rs1),.rs2(rs2),.funct3(funct3));
maincontrol maincontrol1(.opcode(opcode),.reg_write(regwrite),.mem_read(memread),.mem_write(memwrite),.alu_src(alusrc),.mem_to_reg(memtoreg),.branch(branch),.jump(jump),.alu_op(aluop));
//check maincontrol once
immediategenerator immediategenerator1(.instruction(ifid_instruction),.immediate(immediate),.opcode(opcode));
regfile regfile1(.clk(clk),.regwrite(memwb_RegWrite),.rs1(rs1),.rs2(rs2),.rd(memwb_rd),.writedata(writedata),.readdata1(readdata1),.readdata2(readdata2));
//check writedata and memwb_rd and check the regfile module once new changes are made in regfile module
ID_EX id_ex1(.clk(clk),.rst(rst),.idex_flush(idex_flush),.ifid_pc(ifid_pc),.ifid_pcplus4(ifid_pcplus4),.readdata1(readdata1),.readdata2(readdata2),.immediate(immediate),.rs1(rs1),.rs2(rs2),.rd(rd),.funct3(funct3),.funct7(funct7),.RegWrite(regwrite),.MemRead(memread),.MemWrite(memwrite),.MemToReg(memtoreg),.ALUSrc(alusrc),.Branch(branch),.Jump(jump),.ALUOp(aluop),.opcode(opcode),.idex_pc(idex_pc),.idex_pcplus4(idex_pcplus4),.idex_readdata1(idex_readdata1),.idex_readdata2(idex_readdata2),.idex_immediate(idex_immediate),.idex_opcode(idex_opcode),.idex_funct3(idex_funct3),.idex_funct7(idex_funct7),.idex_rs1(idex_rs1),.idex_rs2(idex_rs2),.idex_rd(idex_rd),.idex_RegWrite(idex_RegWrite),.idex_MemRead(idex_MemRead),.idex_MemWrite(idex_MemWrite),.idex_MemToReg(idex_MemToReg),.idex_ALUSrc(idex_ALUSrc),.idex_Branch(idex_Branch),.idex_Jump(idex_Jump),.idex_ALUOp(idex_ALUOp));
//check idex_reg once
alucontrol alucontrol1(.idex_opcode(idex_opcode),.idex_funct3(idex_funct3),.idex_funct7(idex_funct7),.alucontrol(alucontrol));
alu alu1(.forwardeda(forwardeda),.operand_b(operandb),.alucontrol(alucontrol),.aluresult(aluresult),.zero(zero));
//here operandb is forwardedb or immediate based on ALUSrc
alusrc alusrc_mux1(.idex_alusrc(idex_ALUSrc),.forwardedb(forwardedb),.idex_immediate(idex_immediate),.operandb(operandb));
forwarding forwarding1(.forwarda(forwarda),.forwardb(forwardb),.idex_rs1(idex_rs1),.idex_rs2(idex_rs2),.exmem_rd(exmem_rd),.memwb_rd(memwb_rd),.exmem_regwrite(exmem_RegWrite),.memwb_regwrite(memwb_RegWrite));
forwardmux forwardmux1(.forwarda(forwarda),.forwardb(forwardb),.exmem_aluresult(exmem_alu_result),.writedata(writedata),.idex_readdata1(idex_readdata1),.idex_readdata2(idex_readdata2),.forwardeda(forwardeda),.forwardedb(forwardedb));
//check writedata logic once
hazarddetection hazarddetection1(.idex_memread(idex_MemRead),.idex_rd(idex_rd),.ifid_rs1(rs1),.ifid_rs2(rs2),.stall(stall));
EX_MEM ex_mem1(.clk(clk),.rst(rst),.alu_result(aluresult),.idex_pcplus4(idex_pcplus4),.idex_jump(idex_Jump),.store_data(forwardedb),.idex_rd(idex_rd),.idex_MemRead(idex_MemRead),.idex_MemWrite(idex_MemWrite),.idex_MemToReg(idex_MemToReg),.idex_RegWrite(idex_RegWrite),.exmem_alu_result(exmem_alu_result),.exmem_store_data(exmem_store_data),.exmem_rd(exmem_rd),.exmem_pcplus4(exmem_pcplus4),.exmem_jump(exmem_jump),.exmem_MemRead(exmem_MemRead),.exmem_MemWrite(exmem_MemWrite),.exmem_MemToReg(exmem_MemToReg),.exmem_RegWrite(exmem_RegWrite));
//storedata(data to store ) is forwardedb 
datamemory data_memory1(.clk(clk),.exmem_MemRead(exmem_MemRead),.exmem_MemWrite(exmem_MemWrite),.exmem_store_data(exmem_store_data),.readdata(readdata),.address(exmem_alu_result));
//memread=1 means its a load instruction therefore if memread is 1 then aluresult is the address
mem_wb mem_wb1(.clk(clk),.rst(rst),.exmem_RegWrite(exmem_RegWrite),.exmem_jump(exmem_jump),.exmem_pcplus4(exmem_pcplus4),.exmem_MemToReg(exmem_MemToReg),.readdata(readdata),.exmem_alu_result(exmem_alu_result),.exmem_rd(exmem_rd),.memwb_aluresult(memwb_aluresult),.memwb_pcplus4(memwb_pcplus4),.memwb_jump(memwb_jump),.memwb_readdata(memwb_readdata),.memwb_rd(memwb_rd),.memwb_MemToReg(memwb_MemToReg),.memwb_RegWrite(memwb_RegWrite));
wb wb1(.memwb_readdata(memwb_readdata),.memwb_aluresult(memwb_aluresult),.memwb_MemToReg(memwb_MemToReg),.memwb_jump(memwb_jump),.memwb_pcplus4(memwb_pcplus4),.writedata(writedata));
endmodule
