# I2C--Verilog-Simulation

Through this project we aimed to implement an I2C master communication system designed to interface with an I2C-compatible temperature sensor (like the ADT7420). The system performs the following core tasks:

Clock Division: Converts the 100 MHz input clock into a slower clock (clk_200) to control I2C timing. to provide a 10kHz SCL line.

I2C Protocol Logic: Implements the I2C communication protocol using a state machine with 28 distinct states to:

Send a 7-bit slave address + read bit(1)

Receive temperature data (16 bits: MSB and LSB)

Control the SDA line direction using tri-state logic

Data Handling: Stores the temperature's MSB and LSB, and outputs an 8-bit processed temperature value (temp) from the 16 - bit value.

Testbench (i2ccomm_tb): Provides a 100 MHz clock and simulates the system, observing key outputs such as SDA, SCL, and temp.

Since no I2C slave device is connected or simulated in the testbench, the SDA line remains in a high-impedance state (Z) during the read phases of communication. As a result, any attempt by the I2C master to read data from the slave (such as temperature bits or ACK signals) will yield undefined or unknown values (X) in simulation, because there is no device driving the SDA line in response.

Future Scope: 
I2C Slave Simulation:
We are planning on implementing a simulated I2C slave device to test and validate complete read/write cycles during simulation.

FPGA Implementation:
Deploy the design on an actual FPGA board such as the NEXYS A7 and interface it with a real I2C temperature sensor such as PMOD Sensor to verify hardware functionality.
