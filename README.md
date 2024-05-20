# DAC-MCP482x-VHDL-core

# Description
This project implements a VHDL core for the MCP482x Digital-to-Analog Converter (DAC). The MCP482x is a 12-bit DAC that can be used in various applications where it is necessary to convert digital signals into analog signals. The MCP4xxx DAC family includes various device configurations. Initially, I used the MCP4822. This DAC has a configurable internal reference, which can be either 2.048V or 4.096V. The gain configuration is done through the SPI packet sent to the DAC.

## Package Types

![image](https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core/assets/93693421/8c0adf6e-27fd-4025-b1e6-32b4dd180e3e)

## Device Configurations

![image](https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core/assets/93693421/0ca4b8a5-452b-46b2-a752-d8c086b3159e)

## Block Diagram

![image](https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core/assets/93693421/48a41e25-2c3b-4c11-bcb6-29ea5089c680)

## Interfacing with MCP4802/4812/4822

The MCP4802/4812/4822 devices are designed to interface directly with the Serial Peripheral Interface (SPI) port, available on many microcontrollers, and support Mode 0,0 and Mode 1,1. Commands and data are sent to the device via the SDI pin, with data being clocked-in on the rising edge of SCK. The communications are unidirectional and, thus, data cannot be read out of the MCP4802/4812/4822 devices.

The CS pin must be held low for the duration of a write command. The write command consists of 16 bits and is used to configure the DAC’s control and data latches. Register 5-1 to Register 5-3 detail the input register that is used to configure and load the DACA and DACB registers for each device.

## Installation
To clone the repository, use the following command in the terminal:
```bash
git clone https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core.git
