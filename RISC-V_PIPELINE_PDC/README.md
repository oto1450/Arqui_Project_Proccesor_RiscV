# RISC-V Pipeline Processor — Proof of Concept

## Overview

This project implements a **pipelined RISC-V processor as a Proof of Concept (PoC)**. Its primary purpose is to explore and test the basic operation of a pipelined processor architecture through the execution of a specific instruction sequence.

The implementation is intended for educational and experimental purposes. It focuses on validating the integration of the processor's main functional units and the transfer of data and control signals between pipeline stages.

**This is not a general-purpose RISC-V processor.** Its functionality is limited to the instructions and program for which the design has been developed and tested.

## Objectives

The main objectives of this project are:

- Implement a basic RISC-V processor using a pipelined architecture.
- Explore the separation of instruction execution into multiple stages.
- Verify the interaction between the datapath and the control unit.
- Implement pipeline registers to transfer data and control signals between stages.
- Simulate the execution of a predefined instruction sequence.
- Identify and investigate timing, control-flow, and data-propagation issues during pipeline execution.

## Architecture

The processor is organized around a datapath and a control unit, with pipeline registers used to transfer control signals between execution stages.

The design follows the conventional five-stage RISC pipeline organization:

| Stage | Name | Main responsibility |
|---|---|---|
| IF | Instruction Fetch | Fetch the instruction from instruction memory. |
| ID | Instruction Decode | Decode the instruction and generate the corresponding control signals. |
| EX | Execute | Perform ALU operations and evaluate execution conditions. |
| MEM | Memory Access | Handle data-memory operations when required. |
| WB | Write Back | Write the selected result back to the register file. |

The pipeline registers preserve the relevant control signals between stages so that they remain aligned with the corresponding instructions.

*Note: The table describes the conventional five-stage organization. The actual functionality of each stage depends on the modules and connections implemented in this project.*

## Supported Instructions

The processor is intended to execute a specific test program rather than arbitrary RISC-V software.

The current test program exercises the following RV32I instructions:

| Instruction | Operation | Purpose |
|---|---|---|
| `ADDI` | Add an immediate value | Test immediate arithmetic and register writes. |
| `ADD` | Add two register operands | Test arithmetic operations using register operands. |
| `SUB` | Subtract two register operands | Test subtraction. |
| `AND` | Bitwise AND | Test logical operations. |
| `OR` | Bitwise OR | Test logical operations. |

The test program uses NOP instructions (`ADDI x0, x0, 0`) between selected instructions to introduce spacing during execution.

These NOPs are part of the test sequence; they should not be interpreted as a complete hazard-management mechanism. The implementation's behavior with instruction dependencies must be verified separately.

## Test Program

The predefined instruction sequence initializes registers and evaluates arithmetic and logical operations.

The program includes the following operations:

1. Initialize `x1` with the value `10`.
2. Initialize `x2` with the value `6`.
3. Initialize `x10` with the value `20`.
4. Initialize `x11` with the value `4`.
5. Compute `x3 = x1 + x2`.
6. Compute `x4 = x1 - x2`.
7. Compute `x5 = x10 & x11`.
8. Compute `x6 = x10 | x11`.
9. Initialize `x7` with the value `-1`.

The expected results for the arithmetic and logical operations are:

| Register | Expected value | Operation |
|---|---:|---|
| `x3` | `16` | `1# RISC-V Processor — Pipeline Prueba de concepto 

Este es un procesador PIPELINE para realizar una prueba de concepto unicamente para un programa especifico ya que 0 + 6` |
| `x4` | `4` | `10 - 6` |
| `x5` | `4` | `20 AND 4` |
| `x6` | `20` | `20 OR 4` |
| `x7` | `-1` | Sign-extended immediate value |

These values represent the expected architectural results of the instruction sequence. They must be confirmed through simulation of the implemented design.

## Implementation

The processor is described in Verilog HDL and divided into modules that implement the datapath, control logic, and pipeline registers.

The top-level module is:

RISC_V_Pipeline

Its principal external signals are:

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | Clock signal for sequential logic. |
| `reset` | Input | Resets the processor's sequential control state. |
| `op` | Output | Exposes the opcode of the instruction represented by `InstD`. |
| `ALUResultE` | Output | Exposes the ALU result associated with the execution stage. |

The output signals are provided primarily for simulation and debugging. They are not intended to constitute a complete processor interface.

## Simulation

The project includes a testbench intended to apply the clock and reset signals and observe the processor's behavior over multiple clock cycles.

The testbench can be used to inspect:

- Instruction progression through the pipeline.
- Opcode values at the decode stage.
- ALU results during execution.
- Control-signal propagation between pipeline stages.
- The appearance of unknown (`X`) values caused by uninitialized signals or incomplete connections.

The testbench assumes that the instruction memory and other required components are configured with the appropriate initial state. It does not, by itself, guarantee that the program is loaded or that the expected results are verified automatically.

## Limitations

This implementation is an experimental proof of concept and has several important limitations:

- **Program-specific design:** The processor is intended for a predefined instruction sequence.
- **Limited instruction set:** Only the instructions implemented and tested in the current design should be considered supported.
- **Hazard handling:** Data hazards, control hazards, forwarding, and pipeline stalls must not be assumed to be fully implemented.
- **Control-flow behavior:** Branches and jumps require additional verification if they are included in the design.
- **Verification scope:** Successful simulation of the test program does not establish full compliance with the RISC-V ISA.
- **No production target:** The design is not intended for deployment as a general-purpose processor.

## Project Status

**Status: Experimental — Proof of Concept**

The purpose of this project is to validate the basic structure and operation of a pipelined RISC-V processor through a controlled test program. It serves as a starting point for further development, debugging, and experimentation with processor architecture.

## Disclaimer

This project is an educational implementation and is not intended to provide complete RISC-V compatibility, robust execution of arbitrary programs, or production-level reliability.