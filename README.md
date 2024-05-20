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

![image](https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core/assets/93693421/039b77db-fb1e-4902-8b5a-2dff9fe0c195)
![image](https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core/assets/93693421/c31e0c8c-61ac-444c-8dc2-3e9b7d5eb75d)

# Results
As mentioned, the tests were conducted using an MCP4822. The maximum SPI clock for this device is 20MHz. For the tests, a Cyclone IV EP4CE6E22C8 embedded in a development kit was used, which has a 50MHz crystal onboard. Therefore, to perform tests without major concerns about optimizing the write time, I chose to divide the clock by 4, resulting in a 12.5MHz clock for the SPI. However, if you are going to use this core, it might be interesting to use a PLL to generate a 40MHz frequency for the SPI component (spi.vhd). The SPI component will divide the clock by 2 and will name the signal sclk, in which case you will have a clock equal to the maximum allowed of 20MHz.

In the mcpdactest.vhd file, you will notice that I created an array storing the 360 values of a sine function. I used MATLAB to generate the array as well as to convert it to binary. I did not worry about the use of LUT4 in the FPGA, so I stored the values as an array of std_logic_vector (just for testing purposes). Without the array, the total use of logic elements was around 100, so I believe it is possible to incorporate this core into a simple CPLD (EPM240 or EPM570).

* DAC-A Channel at 1kHz and DAC-B 1kHz (90 degrees phase shift between the channels)

![F0019TEK](https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core/assets/93693421/f437e005-932b-4b58-967c-ac644f371e15)

* DAC-A Channel at 20kHz and DAC-B 1kHz

![F0021TEK](https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core/assets/93693421/1031b170-0775-4492-a976-10f079ca990b)

To generate different frequencies, in one channel I traversed the array step by step for the 1kHz channel, and in the other channel, I traversed the array in steps of 20. In this case, I reduce the continuity of the signal but increase its frequency without necessarily having to increase the number of packets sent through the SPI.

## SPI Core VHDL
The SPI core was fully developed by the user nematoli and is available at this link: https://github.com/nematoli/SPI-FPGA-VHDL

## Future Improvements
* I intend to further optimize the code, making it more general-purpose. 
* I will add synchronous resets to prevent bugs from occurring.
* I will transform mcpdactest.vhd into a component that can be used in any project for any DAC model.

## FPGA Development Kit
![image](https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core/assets/93693421/1947d1e2-4602-40d2-8954-970e222e4a99)

## Cloning Repository
To clone the repository, use the following command in the terminal:
```bash
git clone https://github.com/otaviocmaciel/DAC-MCP482x-VHDL-core.git
