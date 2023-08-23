`timescale 1ns / 1ps

module wrsmux #(
    parameter DATA_W = 32
) (
    input logic [DATA_W-1:0] WrmuxSrc,
    input logic              JSel,
    input logic [DATA_W-1:0] PC_Four,
    output logic [DATA_W-1:0] WB_Data
);

assign WB_Data = (JSel == 1) ? PC_Four : WrmuxSrc;

endmodule
