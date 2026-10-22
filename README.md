# SystemVerilog Prisoners

RTL model of the **100 prisoners riddle**: each prisoner may open 50 of 100 boxes and wins by following the loop that starts at their own number. This design shows the strategy working in hardware.

| | |
|---|---|
| Language | Verilog / SystemVerilog |
| Simulator | Altair DSim (`SystemVerilog Prisoners.dpf`); any SV simulator should work |
| Status | Finished (2023-07, updated 2026-01) |
| License | MIT |

## Layout

| Path | What |
|---|---|
| `rtl/box.v` | One box: holds a slip and releases it only when the 32-bit key matches |
| `rtl/prisoner.v` | Prisoner FSM (`IDLE` -> `LOAD` -> `SEARCH`), counts `boxes_searched` from 50, raises `win` or `fail` |
| `sim/box_tb.sv` | Box unit test |
| `sim/prisoner_tb.sv` | Single-prisoner test |
| `sim/multi_prisoner_tb.sv` | All prisoners against the box array, with generic mux/demux |
| `neoTRNG` | Pointer to the neoTRNG random-number generator (submodule entry has no `.gitmodules`, so it does not clone) |

## Run

Open `SystemVerilog Prisoners.dpf` in DSim and run `box_sim`, or compile `rtl/*.v` with a testbench from `sim/` in your simulator of choice. Waveforms and `dsim_work/` are git-ignored.
