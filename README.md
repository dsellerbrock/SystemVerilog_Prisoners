# SystemVerilog Prisoners

RTL model of the 100 prisoners riddle: `box` holds the shuffled slips, `prisoner` follows the loop-following strategy (up to 50 boxes).

- `rtl/`: `box.v`, `prisoner.v`
- `sim/`: testbenches (`box_tb`, `prisoner_tb`, `multi_prisoner_tb`); built for Altair DSim (`SystemVerilog Prisoners.dpf`)

Status: finished (2023-07, updated 2026-01).
