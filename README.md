# Asynchronous FIFO (Parameterized) – Verilog

# Description

This project implements a parameterized asynchronous FIFO in Verilog. The FIFO allows safe data transfer between two independent clock domains using Gray-coded pointers and two-stage synchronizers to mitigate metastability during clock domain crossing (CDC).

The design supports configurable data width and FIFO depth, making it reusable for different systems that require buffering between asynchronous domains.

---

# Features

- Parameterized data width and FIFO depth

- Independent read and write clocks

- Gray-code pointer generation for CDC safety

- Two-flip-flop synchronizers for pointer transfer

- Full and empty flag detection

- Circular buffer memory implementation

- Simple testbench demonstrating write and read operations

---

# Module Parameters

Parameter| Description

"data_w"| Width of input/output data

"depth"| Number of FIFO storage locations

"addr_w"| Address width derived using "$clog2(depth)"

---

# Module Interface

# Inputs

- "clk_wr" – Write clock

- "clk_rd" – Read clock

- "rst" – Asynchronous reset

- "wr_en" – Write enable

- "rd_en" – Read enable

- "data_in" – Data input

# Outputs

- "data_out" – Data output

- "full" – FIFO full indicator

- "empty" – FIFO empty indicator

---

# How It Works

Write Operation

Data is written to the FIFO when:

wr_en = 1 and full = 0

The write pointer increments and the lower address bits select the memory location.

---

Read Operation

Data is read from the FIFO when:

rd_en = 1 and empty = 0

The read pointer increments and the selected memory value is driven to "data_out".

---

# Pointer Structure

Each pointer includes an extra MSB used as a wrap bit.

[wrap_bit | address_bits]

This extra bit helps distinguish between full and empty conditions when the read and write pointers point to the same memory location.

---

# Gray Code Conversion

Pointers are converted to Gray code before crossing clock domains:

gray = binary ^ (binary >> 1)

This ensures that only one bit changes at a time, reducing the chance of incorrect sampling in asynchronous clock environments.

---

# Pointer Synchronization

To safely pass pointers between clock domains, two flip-flop synchronizers are used.

Write pointer crossing to read domain:

wr_ptr_gray → FF → FF → wr_ptr_sync

Read pointer crossing to write domain:

rd_ptr_gray → FF → FF → rd_ptr_sync

---

# Empty Condition

The FIFO is empty when the read pointer equals the synchronized write pointer.

empty = (wr_ptr_sync == rd_ptr_gray)

---

# Full Condition

The FIFO is full when the next write position would overlap the read pointer after wraparound.

full = (wr_ptr_next_gray == rd_ptr_sync)

---

# Testbench

The provided testbench verifies FIFO functionality using two independent clocks.

Clock periods used in simulation:

- Write clock: 10 ns

- Read clock: 14 ns

The testbench:

1. Resets the FIFO

2. Writes multiple data values

3. Enables reads after writing

4. Observes FIFO status flags and data ordering

Simulation output confirms:

- Correct FIFO ordering

- Proper FULL and EMPTY flag behavior

- Safe operation across asynchronous clock domains


---

# Concepts Demonstrated

- Asynchronous FIFO architecture

- Clock Domain Crossing (CDC)

- Gray code counters

- Two-flip-flop synchronizers

- Parameterized RTL design
- Circular buffer memory
