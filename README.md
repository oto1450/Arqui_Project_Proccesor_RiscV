# RISC-V Processor — Monocycle and Pipeline

Implementación en **Verilog** de un procesador basado en la arquitectura **RISC-V RV32I**, desarrollado como proyecto de arquitectura de computadores.

El repositorio contiene las descripciones hardware necesarias para implementar y analizar un procesador RISC-V en FPGA, comenzando con una arquitectura **monociclo** y posteriormente extendiéndola hacia una arquitectura **pipeline**.

## Estado del proyecto

| Arquitectura | Estado |
|---|---|
| RISC-V Monociclo | En desarrollo |
| RISC-V Pipeline | Próximamente |

Actualmente, el repositorio contiene la implementación del procesador **RISC-V monociclo**.

---

## Estructura del repositorio

```text
Arqui_Project_Proccesor_RiscV/
│
├── RISC-V_Monocycle/
│   ├── Control_Unit/
│   ├── Datapath/
│   ├── RISC_V_Single.v
│   └── RISC_V_Single_XDC.xdc
│
└── README.md
```

### `RISC-V_Monocycle`

Contiene la implementación del procesador RISC-V de un solo ciclo.

#### `RISC_V_Single.v`

Módulo superior del procesador monociclo. Integra los diferentes bloques que conforman el procesador y establece las conexiones entre la unidad de control, el datapath, la memoria y los demás elementos necesarios para ejecutar las instrucciones.

#### `Control_Unit/`

Contiene los módulos relacionados con la **unidad de control** del procesador.

La unidad de control interpreta los campos de la instrucción RISC-V y genera las señales necesarias para controlar el comportamiento del datapath.

Entre las señales de control se encuentran, dependiendo de la implementación:

- Selección de la fuente del PC.
- Selección de la fuente del resultado.
- Escritura en memoria de datos.
- Habilitación de escritura en el banco de registros.
- Selección de operandos de la ALU.
- Operación de la ALU.

#### `Datapath/`

Contiene los módulos que conforman el **camino de datos** del procesador.

El datapath es responsable de transportar y procesar los datos durante la ejecución de las instrucciones. Entre sus componentes se encuentran elementos como:

- Banco de registros.
- Unidad aritmético-lógica (ALU).
- Extensión de inmediatos.
- Sumadores.
- Multiplexores.
- Registros.
- Memoria de instrucciones.
- Memoria de datos.

#### `RISC_V_Single_XDC.xdc`

Archivo de restricciones de **Vivado** para la implementación del procesador en FPGA.

Contiene las restricciones correspondientes a las entradas y salidas utilizadas por el diseño, así como las restricciones temporales necesarias para el análisis de timing.

---

## Arquitectura

La primera implementación corresponde a un procesador **RISC-V monociclo**.

En esta arquitectura, cada instrucción se ejecuta completamente durante un único ciclo de reloj:

```text
        ┌───────────────────┐
        │ Instruction       │
        │ Memory            │
        └─────────┬─────────┘
                  │
                  ▼
        ┌───────────────────┐
        │ Control Unit      │
        └─────────┬─────────┘
                  │
                  ▼
        ┌───────────────────┐
        │ Datapath          │
        │                   │
        │ Register File     │
        │ ALU               │
        │ Immediate Ext.    │
        │ Multiplexers      │
        └─────────┬─────────┘
                  │
                  ▼
        ┌───────────────────┐
        │ Data Memory       │
        └───────────────────┘
```

El flujo general de ejecución es:

```text
Fetch
  ↓
Decode
  ↓
Execute
  ↓
Memory
  ↓
Write Back
```

A diferencia de una arquitectura pipeline, estas etapas no se ejecutan simultáneamente sobre diferentes instrucciones, sino que una instrucción completa su ejecución dentro del mismo ciclo.

---

## RISC-V

El procesador está basado en la arquitectura **RISC-V**, utilizando como referencia el conjunto de instrucciones **RV32I**.

El objetivo del proyecto es implementar progresivamente los principales elementos de un procesador RISC-V y estudiar su comportamiento tanto a nivel funcional como a nivel de implementación en FPGA.

La arquitectura se desarrollará en dos versiones principales:

### 1. Monociclo

La implementación monociclo utiliza un único ciclo de reloj para completar la ejecución de cada instrucción.

Esta versión permite estudiar:

- Datapath.
- Unidad de control.
- Banco de registros.
- ALU.
- Memoria de instrucciones.
- Memoria de datos.
- Extensión de inmediatos.
- Lógica de actualización del PC.
- Señales de control.

### 2. Pipeline

Como segunda etapa del proyecto se desarrollará una arquitectura pipeline, en la cual la ejecución de las instrucciones se dividirá en diferentes etapas.

La arquitectura prevista seguirá una organización de cinco etapas:

```text
IF → ID → EX → MEM → WB
```

donde:

| Etapa | Descripción |
|---|---|
| IF | Instruction Fetch |
| ID | Instruction Decode |
| EX | Execute |
| MEM | Memory Access |
| WB | Write Back |

La implementación pipeline permitirá posteriormente analizar aspectos como:

- Registros entre etapas.
- Paralelismo a nivel de instrucciones.
- Dependencias de datos.
- Data hazards.
- Control hazards.
- Forwarding.
- Stalls.
- Branch handling.
- Frecuencia máxima de operación.

---

## Herramientas

El proyecto utiliza principalmente:

- **Verilog HDL**
- **AMD/Xilinx Vivado**
- FPGA compatible con el dispositivo definido en el archivo `.xdc`

---

## Simulación y síntesis

El diseño puede ser utilizado para realizar:

1. Simulación funcional.
2. Síntesis RTL.
3. Análisis de utilización de recursos.
4. Análisis de timing.
5. Implementación en FPGA.
6. Depuración mediante herramientas como **Integrated Logic Analyzer (ILA)**.

El análisis de timing permitirá comparar posteriormente el comportamiento de las arquitecturas monociclo y pipeline, especialmente en términos de:

- Frecuencia máxima.
- Critical path.
- WNS (Worst Negative Slack).
- Utilización de LUTs.
- Flip-Flops.
- Recursos de memoria.

---

## Objetivos del proyecto

- Implementar un procesador RISC-V utilizando Verilog.
- Comprender la relación entre arquitectura y descripción RTL.
- Diseñar un procesador monociclo funcional.
- Analizar la implementación del datapath y la unidad de control.
- Implementar posteriormente una arquitectura pipeline.
- Comparar el rendimiento y utilización de recursos de ambas arquitecturas.
- Implementar y validar el procesador sobre FPGA.

---

## Próximas versiones

El repositorio se ampliará progresivamente con nuevas versiones de la arquitectura:

```text
RISC-V Processor
│
├── RISC-V Monocycle
│   ├── Control Unit
│   ├── Datapath
│   └── Top Module
│
└── RISC-V Pipeline
    ├── Control Unit
    ├── Datapath
    ├── Pipeline Registers
    ├── Hazard Unit
    └── Top Module
```

La versión pipeline se incorporará posteriormente una vez finalizada y validada la implementación monociclo.