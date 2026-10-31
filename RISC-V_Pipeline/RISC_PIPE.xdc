## ===================================================================
## XDC Constraints for RISC_V_PIPELINE
## Arty Z7-20 - XC7Z020-1CLG400C
## Dedicated for Timing Analysis, I/O Placement and Floorplanning
## 
## Todos los I/O de salida están deliberadamente colocados en Bank 35.
## Los pines utilizados pueden corresponder a funciones específicas
## de la placa (HDMI, XADC, botones, etc.).
## ===================================================================


## ===================================================================
## Clock - Bank 35
## ===================================================================

set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.500 -waveform {0.000 5.2500} [get_ports { clk }];

set_property -dict { PACKAGE_PIN D19 IOSTANDARD LVCMOS33 } [get_ports { reset }];

## ===================================================================
## Result[31:0]
## Todos los bits en IO Bank 35
## ===================================================================

set_property -dict { PACKAGE_PIN M20 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[0]  }];
set_property -dict { PACKAGE_PIN M19 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[1]  }];
set_property -dict { PACKAGE_PIN L15 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[2]  }];
set_property -dict { PACKAGE_PIN G17 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[3]  }];
set_property -dict { PACKAGE_PIN N15 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[4]  }];
set_property -dict { PACKAGE_PIN G14 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[5]  }];
set_property -dict { PACKAGE_PIN L14 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[6]  }];
set_property -dict { PACKAGE_PIN M15 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[7]  }];
                         
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[8]  }];
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[9]  }];
set_property -dict { PACKAGE_PIN D19 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[10] }];
set_property -dict { PACKAGE_PIN D20 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[11] }];
set_property -dict { PACKAGE_PIN L20 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[12] }];
set_property -dict { PACKAGE_PIN L19 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[13] }];
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[14] }];
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[15] }];
                                                                     
set_property -dict { PACKAGE_PIN G15 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[16] }];
set_property -dict { PACKAGE_PIN L17 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[17] }];
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[18] }];
set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[19] }];
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[20] }];
set_property -dict { PACKAGE_PIN J19 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[21] }];
set_property -dict { PACKAGE_PIN K19 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[22] }];
set_property -dict { PACKAGE_PIN H18 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[23] }];
                                                                    
set_property -dict { PACKAGE_PIN J18 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[24] }];
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[25] }];
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[26] }];
set_property -dict { PACKAGE_PIN D18 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[27] }];
set_property -dict { PACKAGE_PIN E17 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[28] }];
set_property -dict { PACKAGE_PIN E19 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[29] }];
set_property -dict { PACKAGE_PIN E18 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[30] }];
set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33 } [get_ports { ALUResultE[31] }];


## ===================================================================
## op[6:0]
## También en Bank 35
## ===================================================================

set_property -dict { PACKAGE_PIN K14 IOSTANDARD LVCMOS33 } [get_ports { op[0] }];
set_property -dict { PACKAGE_PIN J16 IOSTANDARD LVCMOS33 } [get_ports { op[1] }];
set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports { op[2] }];
set_property -dict { PACKAGE_PIN H20 IOSTANDARD LVCMOS33 } [get_ports { op[3] }];
set_property -dict { PACKAGE_PIN J20 IOSTANDARD LVCMOS33 } [get_ports { op[4] }];
set_property -dict { PACKAGE_PIN G20 IOSTANDARD LVCMOS33 } [get_ports { op[5] }];
set_property -dict { PACKAGE_PIN G19 IOSTANDARD LVCMOS33 } [get_ports { op[6] }];


## ===================================================================
## Floorplanning
## ===================================================================

#set_property KEEP_HIERARCHY true [get_cells datapath_inst]
#set_property KEEP_HIERARCHY true [get_cells control_unit_inst]

create_pblock RISC_V

add_cells_to_pblock [get_pblocks RISC_V] \
    [get_cells -quiet [list CU DECU EMCU MWCU DP]]
    
resize_pblock [get_pblocks RISC_V] -add {SLICE_X98Y110:SLICE_X113Y124}

set_property IS_SOFT FALSE [get_pblocks RISC_V]