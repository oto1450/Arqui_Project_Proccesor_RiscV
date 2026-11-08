# RISC-V Pipelined Processor

A Verilog-based implementation of a five-stage pipelined RISC-V processor, developed as part of an ongoing computer architecture project. This implementation explores instruction pipelining, data forwarding, and control hazard management, providing a foundation for future improvements and ISA extensions.

## Overview

This project implements a five-stage pipelined RISC-V processor using Verilog HDL. Its architecture divides instruction execution into five stages:

1. **Instruction Fetch (IF):** Fetches instructions from instruction memory and updates the program counter.
2. **Instruction Decode (ID):** Decodes instructions, reads source registers, and generates immediate values.
3. **Execute (EX):** Performs ALU operations, calculates memory addresses, and evaluates branch and jump conditions.
4. **Memory Access (MEM):** Performs read and write operations on data memory.
5. **Write Back (WB):** Selects the result to be written back into the register file.

Pipeline registers separate consecutive stages, allowing multiple instructions to be processed simultaneously.

The processor also incorporates a hazard unit to manage selected data and control dependencies through forwarding and pipeline flushing.

**Important:** This implementation currently supports a subset of the RV32I instruction set. Full RV32I compatibility is a long-term development objective.

## Architecture

### Pipeline Organization

The processor follows a conventional five-stage pipeline organization.

| Stage | Main functionality |
|---|---|
| IF | Instruction fetching and program counter update |
| ID | Instruction decoding, register access, and immediate generation |
| EX | ALU operations, address calculation, and branch evaluation |
| MEM | Data memory access |
| WB | Result selection and register write-back |

The following pipeline registers are used to transfer information between stages:

- `FFDFD`: IF/ID pipeline register.
- `FFDDE`: ID/EX pipeline register.
- `FFDEM`: EX/MEM pipeline register.
- `FFDMW`: MEM/WB pipeline register.

Additional pipeline registers (`FFDDECU`, `FFDEMCU`, and `FFDMWCU`) propagate control signals across the corresponding stages.

### Hazard Management

The processor includes a dedicated `Hazard_Unit` that implements two mechanisms:

**Data Forwarding**

Forwarding paths allow operands to be obtained directly from later pipeline stages instead of waiting for the register file to be updated.

The current implementation supports:

- MEM-to-EX forwarding.
- WB-to-EX forwarding.

Forwarding is controlled independently for both ALU operands. When dependencies with both MEM and WB are detected, the MEM result has priority.

**Control Hazard Management**

Branch and jump decisions are evaluated in the Execute stage. When a control-flow instruction changes the program counter, the hazard unit activates flush signals to clear instructions in the Decode and Execute stages.

**Current limitations**

The hazard management implementation does not currently include:

- Dedicated load-use hazard detection.
- Pipeline stall mechanisms.
- A complete solution for every possible data dependency.

These mechanisms are potential targets for future development.

## Instruction Set Support

The current implementation supports the same instruction subset as the monocycle processor in this repository.

The implemented instruction categories include:

| Instruction type | Currently supported instructions |
|---|---|
| R-type | `ADD`, `SUB`, `AND`, `OR`, `SLT` |
| I-type | `ADDI`, `ANDI`, `ORI`, `SLTI` |
| Load | `LW` |
| Store | `SW` |
| Branch | `BEQ`, `BGE` |
| Jump | `JAL` |

This is a partial implementation of RV32I, not a complete implementation of the base ISA. Additional instructions and addressing modes remain part of the development roadmap.

## Repository Structure

```text
RISC-V_Pipeline/
│
├── Memory_Info/
│   ├── Programadiv9.mem
│   └── Prueba.mem
│
├── src/
│   ├── ALU_Decoder.v
│   ├── ALU.v
│   ├── Control_Unit.v
│   ├── Data_Memory.v
│   ├── Datapath.v
│   ├── Extend.v
│   ├── FFD32.v
│   ├── FFDEM.v
│   ├── FFDFD.v
│   ├── FFDDE.v
│   ├── FFDDECU.v
│   ├── FFDEMCU.v
│   ├── FFDMW.v
│   ├── FFDMWCU.v
│   ├── Hazard_Unit.v
│   ├── MainDecoder.v
│   ├── Memoria2.v
│   ├── MUX32.v
│   ├── MUX4_32.v
│   ├── Register_File.v
│   ├── RISC_V_Pipeline.v
│   ├── SUM4.v
│   └── SUMA.v
│
├── TB/
│   └── RISC_PIPE_TB.v
│
├── RISC_V_Pipeline.v
├── RISC_PIPE.xdc
└── README.md
```

### Main Modules

- **RISC_V_Pipeline.v:** Top-level processor module.
- **Datapath.v:** Implements the five-stage datapath and connects the pipeline registers, ALU, memories, multiplexers, and hazard unit.
- **Control_Unit.v:** Coordinates instruction decoding and generates the processor control signals.
- **MainDecoder.v:** Generates the main control signals based on the instruction opcode.
- **ALU_Decoder.v:** Determines the ALU operation using the instruction fields and main decoder output.
- **Hazard_Unit.v:** Implements forwarding and pipeline flush control.
- **Memoria2.v:** Instruction memory, initialized using a memory initialization file.
- **Data_Memory.v:** Data memory.
- **Register_File.v:** Implements the processor register bank.

## Simulation

The project includes a basic testbench located in `TB/RISC_PIPE_TB.v`.

The testbench generates the clock signal required to execute the processor. Instruction memory is initialized independently through the `$readmemh` system task in `Memoria2.v`, using the selected `.mem` file.

Two memory initialization files are provided:

- `Programadiv9.mem`
- `Prueba.mem`

### Functional Test: Divisibility by 9

One of the programs provided performs a divisibility-by-9 test using successive subtraction.

The algorithm repeatedly subtracts 9 from an input integer until the result reaches zero or becomes negative. The processor then stores the outcome in register `a0` (`x10`):

- `a0 = 1`: The input number is divisible by 9.
- `a0 = 0`: The input number is not divisible by 9.

This program provides a practical workload for exercising instruction execution and the pipeline datapath.

**Note:** The current testbench is a basic simulation environment. It does not include a comprehensive automated verification framework, assertions, or exhaustive instruction-level testing.

## FPGA Implementation

The project includes an XDC constraints file (`RISC_PIPE.xdc`) for FPGA implementation.

The design was developed using Verilog HDL and Xilinx Vivado. To reproduce the implementation:

1. Create a new Vivado RTL project.
2. Select the target FPGA device or development board.
3. Add the Verilog source files from `src/`.
4. Add `RISC_V_Pipeline.v` as the top-level module.
5. Add `RISC_PIPE.xdc` to the project constraints.
6. Configure the instruction memory initialization file so that Vivado can locate the selected `.mem` file during simulation and implementation.
7. Run behavioral simulation, synthesis, implementation, and bitstream generation.

The actual target FPGA and board configuration should match the constraints file.

## Development Roadmap

This project is intended to evolve into a more complete and extensible RISC-V processor platform.

Planned development includes:

- **Complete RV32I implementation:** Support for the full RV32I base instruction set.
- **Advanced hazard management:** Implement load-use hazard detection, pipeline stalls, and more comprehensive dependency handling.
- **Performance improvements:** Evaluate forwarding strategies, pipeline timing, and execution efficiency.
- **RISC-V extensions:** Explore the implementation of additional ISA extensions, including:
  - **M:** Integer multiplication and division.
  - **A:** Atomic instructions.
  - **F:** Single-precision floating-point operations.
  - **C:** Compressed instructions.
- **Verification:** Develop more comprehensive testbenches, automated tests, and systematic instruction validation.
- **Architecture exploration:** Investigate additional pipeline optimizations and microarchitectural improvements.

The implementation of these features will be approached incrementally, with functionality validated as the processor evolves.

## Related Projects

This repository is part of a broader RISC-V processor development project containing three architectural implementations:

- **RISC-V Monocycle:** A single-cycle processor implementation.
- **RISC-V Pipeline:** A five-stage pipelined processor with forwarding and control hazard handling.
- **RISC-V Pipeline PDC:** A pipeline proof of concept focused on exploring the pipelined architecture.

All three implementations currently share the same supported instruction subset, allowing their architectures and execution approaches to be explored under a common functional scope.

## Technologies

- Verilog HDL
- Xilinx Vivado
- RISC-V RV32I architecture
- FPGA-based digital design