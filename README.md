# Kyber Modular Reduction via Dadda Tree Compression

## Overview
This repository contains the Register-Transfer Level (RTL) implementation of an efficient, low-cost modular reduction architecture for the Kyber post-quantum cryptographic algorithm. Designed as part of a Final Year Project (FYP) in Electronics and Communication Engineering at National Institute of Technology, Silchar, this hardware accelerator computes the remainder modulo 3329 for a 24-bit input without utilizing computationally expensive hardware dividers.

The architecture leverages a Dadda Tree Hybrid Compression Array (DTHCA) to reduce 62 partial product dots (comprising native input bits, inverted bits, and constant 1s for sign extension) down to two 15-bit vectors. These vectors are then processed by parallel full adders and a priority multiplexer to generate the exact 12-bit modular remainder.

## Hardware Specifications
* **Target Device:** Xilinx Artix-7 FPGA (xc7a200tffg1156-3)
* **Development Environment:** Xilinx Vivado
* **Hardware Description Language:** SystemVerilog

## Repository Structure
The design is structural and heavily modularized to ensure efficient logic synthesis and clear routing:

* `csa1.sv`: 2-to-2 compressor (Half Adder) logic used for 2-dot column reduction.
* `csa2.sv`: 3-to-2 compressor (Full Adder) logic used for 3-dot column reduction.
* `fa_15bit.sv`: 15-bit parallel full adder for final boundary corrections.
* `mux_4to1.sv`: Priority multiplexer to select the valid candidate modular output within the $(-q, 3q)$ range.
* `dthca.sv`: The core Dadda Tree Hybrid Compression Array. Maps the 62 polynomial dots across 11 binary weight columns and compresses them over a strict multi-stage pipeline using the $N-1$ diagonal carry routing rule.
* `reduction_unit.sv`: The top-level wrapper module integrating the DTHCA, parallel range-correction adders, and the priority multiplexer.
* `tb_reduction.sv`: Behavioral simulation testbench including bound checks and functional verification vectors.

## Functional Verification
Behavioral simulation has been thoroughly verified in the Vivado simulator using targeted test vectors. The module accurately resolves standard reductions and edge cases (e.g., verifying `10000 mod 3329 = 13`), proving the structural integrity of the custom compression array, adder stages, and multiplexing logic.

## Performance Metrics (To Be Updated)
*This section will be updated upon completion of the synthesis and physical implementation phases.*
* **Hardware Utilization:** (Pending Slice LUTs and CARRY4 logic count)
* **Power Consumption:** (Pending Dynamic and Static power analysis in Watts)
* **Critical Path Delay:** (Pending maximum combinational data path delay in nanoseconds)
