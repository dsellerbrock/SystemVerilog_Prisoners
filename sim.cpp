  #include "Vprison_box_interconnect_tb.h"
  #include "verilated.h"

  int main(int argc, char** argv) {
      VerilatedContext* contextp = new VerilatedContext;
      contextp->commandArgs(argc, argv);
      Vprison_box_interconnect_tb* top = new Vprison_box_interconnect_tb{contextp};
      while (!contextp->gotFinish()) { top->eval(); }
      delete top;
      delete contextp;
      return 0;
  }
