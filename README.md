# Verilog CPU Design

## Overview

This project implements a pipelined CPU architecture using Verilog HDL. The CPU supports basic instruction execution including arithmetic operations, memory access, branching, and jumping. It includes mechanisms for hazard detection, forwarding, stalling, and a multiply unit. All components are modularized and interconnected in the top-level module `CPU.v`.

## Features

- **5-stage pipeline**: IF, ID, EX, MEM, WB
- **Hazard detection** and **data forwarding**
- **Branch and jump handling**
- **Multicycle multiply operations**
- **Hi/Lo register support**
- **Modular Verilog design** with individual functional blocks

## File Structure

| File                  | Description |
|-----------------------|-------------|
| `CPU.v`               | Top-level module that wires all components together. |
| `CPU_tb.v`            | Testbench for simulating the CPU. |
| `alu.v`               | Arithmetic logic unit (supports signed/unsigned ops). |
| `alucontrol.v`        | Determines ALU operation based on function and opcode. |
| `ForwardingUnit.v`    | Implements forwarding logic to prevent data hazards. |
| `hazardunit.v`        | Detects hazards and generates stall signals. |
| `incrementer.v`       | Increments PC address. |
| `jumpadd.v`           | Handles jump and branch address calculation. |
| `load_in_counter.v`   | Used to support instruction memory loading. |
| `memory2.v`           | Dual-role memory module (instruction and data). |
| `multiplycontrol.v`   | Control logic for multiplication instruction decoding. |
| `mux2to1_1bit.v`      | 2-to-1 multiplexer for 1-bit signals. |
| `mux2to1_5bit.v`      | 2-to-1 multiplexer for 5-bit signals. |
| `mux2to1.v`           | 2-to-1 multiplexer for 32-bit signals. |
| `mux3to1_32bit.v`     | 3-to-1 multiplexer for 32-bit signals. |
| `pipecontrol.v`       | Main control unit that generates pipeline control signals. |
| `reg_2bitne.v`        | 2-bit register with enable and reset. |
| `reg_5bitne.v`        | 5-bit register with enable and reset. |
| `reg_14bitne.v`       | 14-bit register with enable and reset. |
| `reg_32bit.v`         | 32-bit general-purpose register. |
| `reg_32bitne.v`       | 32-bit register with enable and reset. |
| `RegFile.v`           | Register file with two read and one write port. |
| `signextend.v`        | Extends 16-bit immediates to 32 bits. |
| `signextend26.v`      | Extends 26-bit jump offset to 32 bits. |
| `stallmux.v`          | Stalling multiplexer to insert NOPs in pipeline. |
| `three_to_one_mux.v`  | 3-to-1 multiplexer for forwarding paths. |

## Top Module: `CPU.v`

The `CPU` module instantiates and connects all components necessary for instruction fetch, decode, execute, memory access, and write-back. Key responsibilities include:

- **Instruction Fetch (IF)**: PC update logic, memory access for instruction fetch.
- **Instruction Decode (ID)**: Control signal generation, hazard detection, and register reads.
- **Execute (EX)**: ALU operations, forwarding, and multiply logic.
- **Memory Access (MEM)**: Data memory reads/writes.
- **Write Back (WB)**: Select and write data back to register file.

## How to Simulate

1. **Testbench**: Run `CPU_tb.v` using a Verilog simulator like Icarus Verilog, ModelSim, or Vivado.
2. **Simulation Commands (Icarus Example)**:
   ```bash
   iverilog -o cpu_sim CPU_tb.v CPU.v alu.v ... # include all modules
   vvp cpu_sim
