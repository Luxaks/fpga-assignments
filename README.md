# FPGA Assignments

Containing my assignments for the SOC (Structure and Organisation of Computers) and APM (Architecture of Modern Processors) courses, implemented in Verilog.

## Requirements

Install [Icarus Verilog](https://steveicarus.github.io/iverilog/).

Optionally, install [Xilinx Vivado](https://www.amd.com/en/products/software/adaptive-socs-and-fpgas/vivado.html/) for the APM assignments (since they are not configured for iverilog (yet?)).

## Overview

The SOC projects were solo assignments. The APM assignments were done in collaboration with a classmate.

Note that the majority of the documentation and comments are in Romanian, though I doubt anyone looking at this doesn't speak it.

### SOC
1. The folder `tema_mealy` contains a [Mealy automaton](https://en.wikipedia.org/wiki/Mealy_machine/) simulating a soda vending machine, done as homework
2. The folder `test_moore` contains a [Moore machine](https://en.wikipedia.org/wiki/Moore_machine/) which detects a bit sequence, originally done as part of the final exam

### APM
1. The folder `t1-sap` contains an implementation for the [SAP-1](https://en.wikipedia.org/wiki/Simple-As-Possible_computer/) architecture, based on [this repository](https://github.com/raresifrim/sap1-single-cycle-public/). The FPGA synth doesn't work properly, but the simulation works (or at least worked, I think I messed it up trying to fix it)
2. The folder `t2-riscv-fd` contains an implementation for the [RISC-V](https://en.wikipedia.org/wiki/RISC-V/) architecture, based on the [relevant documentation](t2-riscv-fd/docs/). Note that this part includes only the `IF` (instruction fetch) and `ID` (instruction decode) stages, so the processor so far only goes through the instructions and breaks them into their constituents, without actually executing anything.
