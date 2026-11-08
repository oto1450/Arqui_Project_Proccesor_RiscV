# RISC-V Processor Architectures — Monocycle, Pipeline and Pipeline PDC

## Project Overview

This repository contains the development and implementation of **RISC-V processors using Verilog HDL**, based on the **RV32I base integer instruction set architecture**.

The project explores different processor microarchitectures, starting with a single-cycle (monocycle) implementation and progressing towards pipelined architectures. The main objective is to understand, design, implement, and compare different processor architectures at both the RTL and FPGA implementation levels.

Currently, the repository includes three processor implementations:

- **RISC-V Monocycle:** A single-cycle processor in which each instruction is completed within one clock cycle.
- **RISC-V Pipeline:** A pipelined processor based on the original monocycle architecture, introducing pipeline registers to divide instruction execution into multiple stages.
- **RISC-V Pipeline PDC (Proof of Concept):** An experimental pipelined implementation without a hazard detection and handling unit, developed to study instruction execution and pipeline behavior without hazard management mechanisms.

All three implementations share a common functional objective and are progressively being developed towards a more complete implementation of the RV32I instruction set.

---

## Project Status

The repository currently contains three processor architectures at different stages of development.

| Architecture | Description | Status |
|---|---|---|
| RISC-V Monocycle | Single-cycle processor | Under development |
| RISC-V Pipeline | Pipelined processor with pipeline registers | Under development |
| RISC-V Pipeline PDC | Pipelined proof of concept without hazard handling | Experimental implementation |

The monocycle architecture serves as the foundation for the pipelined implementations. The Pipeline and Pipeline PDC versions currently support the same instruction subset as the monocycle processor, with further instruction integration planned.

---

## Processor Architectures

### 1. RISC-V Monocycle

The monocycle implementation executes each instruction within a single clock cycle.

It serves as the initial processor architecture and establishes the fundamental building blocks required for the subsequent implementations, including the control unit, datapath, register file, ALU, and memory interfaces.

This architecture provides the functional foundation for the entire project.

### 2. RISC-V Pipeline

The pipeline implementation extends the original monocycle processor by introducing registers between execution stages.

The processor follows the conventional five-stage pipeline organization:

```text
IF → ID → EX → MEM → WB
```

Where:

- **IF:** Instruction Fetch
- **ID:** Instruction Decode
- **EX:** Execute
- **MEM:** Memory Access
- **WB:** Write Back

This implementation aims to explore instruction-level parallelism and the challenges associated with pipelined processor architectures.

The current development focuses on establishing the pipeline structure and progressively integrating the supported instruction set.

### 3. RISC-V Pipeline PDC (Proof of Concept)

The Pipeline PDC implementation supports the same instruction subset as the other two architectures. Its main difference is the absence of a hazard detection and handling unit, allowing the study of instruction execution in a pipelined architecture without these mechanisms.

Its primary purpose is to serve as a proof of concept for studying how instructions and software routines behave in a pipelined architecture without hazard management mechanisms.

By comparing this implementation with the complete pipeline architecture, it is possible to investigate the importance of hazard handling and its impact on correct instruction execution.

---

## Functional Validation

All three processor implementations share a common functional validation objective.

The test program determines whether a given integer is a multiple of **9**, using repeated subtraction rather than a hardware division instruction.

The algorithm repeatedly subtracts 9 from the input number until one of two conditions is met:

- The result reaches zero: the input number is a multiple of 9.
- The result becomes negative: the input number is not a multiple of 9.

The final result is stored in the RISC-V **`a0` register**:

| Condition | `a0` |
|---|---|
| Input is a multiple of 9 | `1` |
| Input is not a multiple of 9 | `0` |

This program provides a common functional benchmark for evaluating the three architectures and verifying instruction execution, control flow, arithmetic operations, and register updates.

---

## Supported Instructions

All three processor architectures currently implement the same subset of RV32I instructions. This subset is sufficient to execute the common functional validation program, but it does not represent a complete implementation of the RV32I base instruction set.

The implemented instruction categories include:

| Category | Instructions |
|---|---|
| Arithmetic | `ADD`, `SUB` |
| Logical | `AND`, `OR` |
| Memory Access | `LW`, `SW` |
| Conditional Branches | `BEQ`, `BGE` |
| Unconditional Jumps | `J` |

This instruction subset provides the essential functionality required by the current validation program.

Instruction support will be progressively expanded across all processor implementations.

---

## Repository Structure

```text
Arqui_Project_Proccesor_RiscV/
│
├── RISC-V_Monocycle/
│   ├── Memory_Info/
│   ├── src/
│   ├── TB/
│   ├── RISC_V_Single.v
│   ├── RISC_V_Single_XDC.xdc
│   └── README.md
│
├── RISC-V_Pipeline/
│   ├── Memory_Info/
│   ├── src/
│   ├── TB/
│   ├── RISC_V_Pipeline.v
│   ├── RISC_PIPE.xdc
│   └── README.md
│
├── RISC-V_PIPELINE_PDC/
│   ├── Memory_Info/
│   ├── src/
│   ├── TB/
│   ├── RISC_V_Pipeline_PDC.v
│   └── README.md
│
└── README.md
```

Each processor architecture has its own directory, containing its respective Verilog source files, testbenches, memory initialization files, and documentation.

- **`src/`**: Contains the Verilog source files.
- **`TB/`**: Contains the testbenches for simulation and verification.
- **`Memory_Info/`**: Contains memory initialization files and supporting information for processor testing.
- **Top-level files**: Include the main processor module and, where applicable, its FPGA constraint file.
- **`README.md`**: Provides dedicated documentation for each processor architecture.

---

## Tools and Technologies

The project is developed using the following tools and technologies:

- **Verilog HDL:** Hardware description language used to design the processors.
- **AMD/Xilinx Vivado:** RTL simulation, synthesis, implementation, timing analysis, and FPGA deployment.
- **FPGA Development Boards:** Hardware platforms for testing and validating the processor implementations.

---

## Development Roadmap

The long-term objective is to develop a more complete RISC-V processor ecosystem, progressively expanding the instruction set and improving the microarchitectures.

Planned development stages include:

1. **Complete RV32I Support:** Expand the currently implemented instruction subset until all three processor architectures support the complete RV32I base integer instruction set.
2. **Pipeline Development:** Complete the pipelined implementation, including hazard detection, forwarding, stalling, and control hazard management.
3. **Architecture Comparison:** Evaluate the monocycle and pipeline implementations in terms of clock frequency, execution performance, timing constraints, and FPGA resource utilization.
4. **FPGA Validation:** Test and validate all processor architectures on physical FPGA hardware.
5. **RISC-V Extensions:** Explore the integration of additional RISC-V instruction set extensions, depending on compatibility and project requirements.

Potential future extensions include:

- **M:** Integer multiplication and division.
- **A:** Atomic instructions.
- **F:** Single-precision floating-point operations.
- **C:** Compressed instructions.

The implementation of these extensions will depend on the evolution of the base architectures and their respective datapaths and control units.

---

## Project Goals

The main goals of this project are:

- Design and implement RISC-V processor architectures using Verilog HDL.
- Understand the relationship between instruction set architecture (ISA) and microarchitecture.
- Explore the differences between single-cycle and pipelined processor designs.
- Study instruction-level parallelism and pipeline hazards.
- Implement and validate the RV32I instruction set.
- Analyze hardware resource utilization and timing performance.
- Progressively integrate additional RISC-V extensions.
- Develop practical experience with FPGA-based processor design and verification.

---

## License

License and usage conditions will be specified as the project evolves.