# Design-and-Verification-of-Synchronous_Ram

Problem: Design a Simple Synchronous RAM
Requirements & Specifications:

Memory Parameters:

Depth: 256 locations (8-bit address)
Width: 32 bits per word
Operating Mode: Synchronous Read/Write
Single port configuration


Interface Signals:

clk: Clock input (positive edge triggered)
rst_n: Active low asynchronous reset
write_en: Write enable signal
addr: 8-bit address input
data_in: 32-bit input data
data_out: 32-bit output data


Functionality:

Write Operation: When write_en = 1
Read Operation: When write_en = 0
Reset: Clear all memory locations to 0
Each operation occurs at positive edge of clock
