# FPGA Light Sensor Interface

## Overview

In this project, an FPGA-based light sensor interface is implemented using Verilog on the Basys 3 Artix-7 Development Board. The project involves clock generation using a phase-locked loop (PLL), interfacing with an ALS light sensor using SPI, and displaying the sensor values on a seven-segment display.

## Modules

1. **clock_gen:** Generates a 10 MHz clock using a PLL and provides a synchronized active-low reset signal.

2. **als_pmod_int:** Implements the ALS light sensor interface and control module, including a state machine for sampling, SPI communication, and data processing.

3. **seven_seg:** Manages the seven-segment display, updating the display value based on sensor readings and predefined values.

4. **top_lab3:** The top-level module that instantiates the clock generation, ALS interface, and seven-segment display modules.

## How to Use

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/argrabowski/fpga-light-sensor.git
   cd fpga-light-sensor
   ```

2. **Open Project in FPGA Development Environment:**
   - Use your preferred FPGA development environment to open the project.

3. **Configure and Synthesize:**
   - Configure the project settings based on your FPGA board.
   - Perform synthesis and implement the design.

4. **Upload to FPGA Board:**
   - Upload the synthesized bitstream to your FPGA board.

## Results and Reports

- [Link to Lab Report](report.pdf)
- [Link to Simulation Testbench](simulation.pdf)
- [Link to Code](code.pdf)
