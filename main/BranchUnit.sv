`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC,
    input logic [31:0] Imm,
    input logic Branch,
    input logic flag_halt,
    input logic JmpSel,
    input logic JalrSel,

    input logic [31:0] AluResult,
    output logic [31:0] PC_Imm,
    output logic [31:0] PC_Four,
    output logic [31:0] BrPC,
    output logic PcSel
);

  logic Branch_Sel;
  logic [31:0] PC_Full;

  assign PC_Full = {23'b0, Cur_PC};

  assign PC_Imm = (JalrSel) ? AluResult : ((JmpSel) ?  (PC_Full + Imm) : (PC_Full + Imm - 32'b1000)); //Se for JALR, Pc_Imm é AluResult, caso contrário o Pc_Imm é (PC_Full + Imm) para JAL e (PC_Full + Imm - 32'b1000) para branch
  assign PC_Four = (flag_halt) ? {0'b0} : PC_Full + 32'b100; //(flag_halt) ? 32'b100000000 : PC_Full + 32'b100
  assign Branch_Sel = (Branch && AluResult[0]) || (JmpSel);  // 0:Branch is taken; 1:Branch is not taken

  assign BrPC = (Branch_Sel) ? PC_Imm : 32'b0;  // Branch -> PC+Imm   // Otherwise, BrPC vsim:/tb_top/#INITIAL#35alue is not important
  assign PcSel = Branch_Sel;  // 1:branch is taken; 0:branch is not taken(choose pc+4)


endmodule
