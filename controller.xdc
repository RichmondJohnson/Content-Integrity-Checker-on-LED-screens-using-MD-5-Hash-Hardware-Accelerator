## Clock signal
# set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { Clk }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
# create_clock -add -name Clk -period 20.00 -waveform {0 10} [get_ports {Clk}];


# set_property IOSTANDARD LVCMOS33 [get_ports Clk]
# create_clock -period 10.000 -name Clk [get_ports Clk]

# set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { Clk }];
create_clock -period 10.000 -name Clk [get_ports Clk]
set_property PACKAGE_PIN E3 [get_ports Clk]

##Switches

# set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { Reset }];

set_property PACKAGE_PIN J15 [get_ports Reset]
set_property IOSTANDARD LVCMOS33 [get_ports Reset]


## LEDs

set_property PACKAGE_PIN H17 [get_ports complete]
set_property IOSTANDARD LVCMOS33 [get_ports complete]

# set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { complete }];

set_property IOSTANDARD LVCMOS33 [get_ports Clk]
