# 🚦 Traffic Light Controller using Verilog HDL

## Overview

This project implements a **Traffic Light Controller** using a **Moore Finite State Machine (FSM)** in Verilog HDL. The controller manages the sequence of traffic lights with configurable timing using a counter. It also includes support for pedestrian requests, emergency vehicle priority, and vehicle detection.

---

## Objectives

* Design a synthesizable FSM using Verilog HDL.
* Implement timer-based state transitions using a counter.
* Understand the difference between control logic and datapath.
* Verify the design using a comprehensive Verilog testbench.
* Simulate the design and analyze waveforms using GTKWave.

---

## Features

* Three-state Moore FSM
* Counter-based timing
* Configurable RED, GREEN, and YELLOW durations
* Pedestrian crossing support
* Emergency vehicle priority
* Vehicle sensor support
* Three-block FSM architecture
* Simulation using GTKWave

---

## Inputs

| Signal         | Description                         |
| -------------- | ----------------------------------- |
| clk            | System clock                        |
| rst            | Asynchronous reset                  |
| pedestrian     | Pedestrian crossing request         |
| emergency      | Emergency vehicle request           |
| vehicle_sensor | Detects vehicles during GREEN state |

---

## Outputs

| Signal          | Description                                     |
| --------------- | ----------------------------------------------- |
| red             | RED traffic light                               |
| yellow          | YELLOW traffic light                            |
| green           | GREEN traffic light                             |
| pedestrian_walk | Indicates when pedestrians are allowed to cross |

---

## State Encoding

| State  | Binary |
| ------ | ------ |
| RED    | 2'b00  |
| GREEN  | 2'b01  |
| YELLOW | 2'b10  |

---

## State Transition

```
        RESET
          │
          ▼
       +------+
       | RED  |
       +------+
          │
          ▼
      +--------+
      | GREEN  |
      +--------+
          │
          ▼
      +---------+
      | YELLOW  |
      +---------+
          │
          └────────────► RED
```

---

## Design Methodology

The controller is implemented using the standard **three-block FSM architecture**.

### 1. State Register

Stores the current state using flip-flops.

### 2. Next-State Logic

Computes the next state based on the current state, timer status, and input conditions.

### 3. Output Logic

Generates the traffic light outputs based on the current state.

---

## Timing

For simulation:

| State  | Duration        |
| ------ | --------------- |
| RED    | 10 Clock Cycles |
| GREEN  | 8 Clock Cycles  |
| YELLOW | 3 Clock Cycles  |

These values can be modified by changing the timing parameters in the RTL.

---

## Verification

The design is verified using a dedicated Verilog testbench covering the following scenarios:

* Reset operation
* Normal traffic light sequence
* Pedestrian request
* Emergency vehicle request
* Vehicle sensor operation

---

## Simulation Tools

* Verilator / Icarus Verilog
* GTKWave
* Visual Studio Code
* Linux Terminal

---

## Learning Outcomes

Through this project I learned:

* Finite State Machine (FSM) design
* Moore FSM implementation
* Counter-based timing
* Sequential and combinational logic
* RTL coding practices
* Testbench development
* Waveform debugging using GTKWave

---

## Future Improvements

* Four-road intersection controller
* Countdown timer display
* Adaptive traffic control
* Emergency route optimization
* Night mode operation
* Sensor-based dynamic signal timing

---


VLSI Design & Verification Enthusiast
