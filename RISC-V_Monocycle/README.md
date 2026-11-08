# RISC-V Monocycle Processor

A 32-bit single-cycle RISC-V processor implementation developed in **Verilog HDL**, based on the **RV32I Instruction Set Architecture (ISA)**.

This project explores the design and implementation of a single-cycle processor, including its datapath, control unit, register file, arithmetic and logic operations, and memory interfaces.

The processor is designed as an educational and experimental project, providing a practical starting point for understanding RISC-V architecture and FPGA-based processor development.

## Overview

The processor follows a **single-cycle microarchitecture**, meaning that each instruction is executed within one clock cycle.

Its design is organized around two main components:

- **Control Unit:** Decodes instructions and generates the control signals required for processor operation.
- **Datapath:** Performs data processing, arithmetic and logical operations, memory accesses, and program counter updates.

The implementation uses a 32-bit data path and a register file containing 32 general-purpose registers.

The current version supports a subset of the RV32I instruction set. Full RV32I compatibility is a long-term development goal.

## Architecture

The processor implements a conventional single-cycle datapath.

The main execution flow consists of five conceptual stages:

```text
Instruction Fetch
       |
       v
Instruction Decode
       |
       v
     Execute
       |
       v
 Memory Access
       |
       v
   Write Back
```

Unlike a pipelined processor, these stages are not distributed across multiple clock cycles. Instead, the entire instruction execution process takes place within a single clock cycle.

### Main Components

The processor includes the following hardware components:

- **Program Counter (PC):** Stores the address of the current instruction and determines the next instruction address.
- **Instruction Memory:** Stores the program instructions and provides the instruction corresponding to the current PC.
- **Control Unit:** Decodes instruction opcodes and generates the appropriate control signals.
- **Register File:** Contains 32 registers of 32 bits each, with two read ports and one synchronous write port.
- **Immediate Generator:** Extracts and sign-extends immediate values from different RISC-V instruction formats.
- **Arithmetic Logic Unit (ALU):** Performs arithmetic, logical, and comparison operations.
- **Data Memory:** Provides storage for data accessed by load and store instructions.
- **Multiplexers and Adders:** Control data selection, arithmetic operations, and program counter updates.

## Supported Instructions

The current implementation supports a subset of the RV32I base integer instruction set.

| Category | Instructions |
|---|---|
| Arithmetic | `ADD`, `SUB`, `ADDI` |
| Logical | `AND`, `OR`, `ANDI`, `ORI` |
| Comparison | `SLT`, `SLTI` |
| Memory Access | `LW`, `SW` |
| Conditional Branches | `BEQ`, `BGE` |
| Unconditional Jumps | `J` |

**Note:** The supported instruction list represents the current implementation and does not imply complete RV32I compatibility. Additional instructions will be incorporated in future development.

## Repository Structure

```text
RISC-V_Monocycle/
│
├── Memory_Info/
│   ├── Div9_LM.txt
│   └── programa2.mem
│
├── src/
│   ├── ALU.v
│   ├── ALU_Decoder.v
│   ├── Control_Unit.v
│   ├── Data_Memory.v
│   ├── Datapath.v
│   ├── Extend.v
│   ├── FFD32.v
│   ├── MainDecoder.v
│   ├── Memoria2.v
│   ├── MUX32.v
│   ├── MUX4_32.v
│   ├── Register_File.v
│   ├── SUM4.v
│   └── SUMA.v
│
├── TB/
│   ├── ALU_tb.v
│   ├── Extend_tb.v
│   └── RISC_V_Single_tb.v
│
├── RISC_V_Single.v
├── RISC_V_Single_XDC.xdc
└── README.md
```

### Directory Description

- **`src/`**: Contains the Verilog modules that implement the processor's hardware components.
- **`TB/`**: Contains testbenches for functional simulation and verification.
- **`Memory_Info/`**: Contains memory initialization files and supporting information for the processor's test programs.
- **`RISC_V_Single.v`**: Top-level module that integrates the control unit and datapath.
- **`RISC_V_Single_XDC.xdc`**: FPGA pin assignments and timing constraints for Vivado.
- **`README.md`**: Documentation for the monocycle processor implementation.

## Functional Verification

The processor has been tested using a program that determines whether an integer is a multiple of **9**, using successive subtraction.

The algorithm repeatedly subtracts 9 from the input number until the result reaches zero or becomes negative.

The final result is stored in the RISC-V `a0` register (`x10`):

| Condition | `a0` |
|---|---|
| Input is a multiple of 9 | `1` |
| Input is not a multiple of 9 | `0` |

This test program exercises several fundamental processor capabilities, including:

- Arithmetic operations.
- Logical operations.
- Register read and write operations.
- Memory access.
- Conditional branching.
- Program counter updates.

This application provides a common functional reference for validating the processor and comparing its behavior with other architectures developed in this project.

## Simulation and Verification

The project includes testbenches for individual hardware components and the complete processor.

| Testbench | Description |
|---|---|
| `ALU_tb.v` | Functional verification of the ALU. |
| `Extend_tb.v` | Verification of immediate generation and sign extension. |
| `RISC_V_Single_tb.v` | Simulation of the complete single-cycle processor. |

### Running the Simulation

The project can be simulated using **AMD/Xilinx Vivado**.

General procedure:

1. Open Vivado and create a new RTL project.
2. Select the FPGA device or development board to be used.
3. Add `RISC_V_Single.v` as the top-level module.
4. Add all Verilog files contained in the `src/` directory.
5. Add the required testbench files from `TB/` as simulation sources.
6. Ensure that the memory initialization file `programa2.mem` is accessible from the simulation working directory.
7. Run behavioral simulation using `RISC_V_Single_tb.v`.

The individual testbenches can also be used to verify the ALU and immediate generation independently.

## FPGA Implementation

The design includes an XDC constraint file for FPGA implementation using Vivado.

The implementation flow consists of:

1. RTL elaboration.
2. Synthesis.
3. Implementation.
4. Timing analysis.

The constraint file `RISC_V_Single_XDC.xdc` provides the pin assignments and timing constraints required by the target FPGA.

**Note:** The XDC file must be reviewed and adapted if a different FPGA device or development board is used.

## Limitations and Future Work

The current implementation is a functional starting point for a more complete RV32I processor.

Future improvements include:

- Implementing the remaining RV32I instructions.
- Expanding memory access support.
- Improving instruction and data memory organization.
- Enhancing functional verification through additional test programs.
- Evaluating FPGA resource utilization and maximum operating frequency.
- Exploring additional RISC-V instruction set extensions.

Potential future extensions include:

- **M:** Integer multiplication and division.
- **A:** Atomic instructions.
- **F:** Single-precision floating-point operations.
- **C:** Compressed instructions.

These extensions will be considered after establishing a more complete RV32I implementation.

## Technologies

- **Verilog HDL**
- **AMD/Xilinx Vivado**
- **RISC-V RV32I ISA**
- **FPGA Development Boards**

## Related Projects

This implementation is part of a broader RISC-V processor development project that explores different microarchitectures.

The repository also includes:

- **RISC-V Pipeline:** A pipelined implementation with pipeline registers and hazard handling.
- **RISC-V Pipeline PDC:** An experimental pipelined implementation without hazard handling, developed as a proof of concept.

Refer to the main repository README for an overview of all processor architectures.