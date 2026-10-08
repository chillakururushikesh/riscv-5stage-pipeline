# riscv-5stage-pipeline

A 32-bit 5-stage pipelined RISC-V processor implemented in Verilog, covering the core datapath and control logic for instruction fetch, decode, execute, memory, and write-back.

## Overview
This project implements a simple but complete RISC-V pipeline with:
- 5-stage execution pipeline
- Hazard detection for load-use stalls
- Data forwarding for ALU operand resolution
- ALU control decoding for R-type, I-type, load/store, and branch instructions
- Branch and jump target calculation
- Register file and data memory
- Write-back mux for load vs ALU result

## Features
- 32-bit integer datapath
- Basic RISC-V instruction support
- Single-cycle ALU with arithmetic, logical, shift, comparison, and branch logic
- Pipelined control and forwarding logic
- SystemVerilog-style modular organization for RTL design

## Repository structure
```text
.
├── README.md
├── rtl/
│   ├── ALU.v
│   ├── ALUCONTROL.v
│   ├── ALUSrc MUX.v
│   ├── CONTROLUNIT.v
│   ├── DATA MEMORY.v
│   ├── EXMEM REG.v
│   ├── FORWARDING UNIT.v
│   ├── IDEX REG.v
│   ├── IFIDREG.v
│   ├── IMMEDIATE GENERATOR.v
│   ├── INSTRUCTION DECODER.v
│   ├── INSTRUCTION MEMORY.v
│   ├── LOADUSEHAZARD.v
│   ├── MEMWB REG.v
│   ├── PC.v
│   ├── REGISTER FILE.v
│   ├── RISCV CORE.v
│   └── WBMUX.v
└── docs/
    └── architecture-notes.md
```

## Design notes
The processor is organized as a classic 5-stage pipeline:
1. Instruction Fetch (IF)
2. Instruction Decode (ID)
3. Execute (EX)
4. Memory Access (MEM)
5. Write Back (WB)

Forwarding and stall logic are included to manage data hazards and inter-stage dependencies.

## Verification
This project is structured for RTL simulation and verification using tools such as:
- Icarus Verilog (iverilog)
- GTKWave
- Vivado or ModelSim for larger testbench workflows

## Example simulation flow
```bash
iverilog -g2012 -o riscv_top rtl/*.v
vvp riscv_top
```

## Status
This repository represents the pipelined RISC-V implementation and is intended as a learning and design project for processor architecture and digital hardware design.

## Author
RUSHIKESH CHILLAKUR
