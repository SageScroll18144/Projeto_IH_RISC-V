`timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb
        begin
            case(Operation)
            4'b0000:        // AND
                    ALUResult = SrcA & SrcB;
            4'b0001:    //XOR
                    ALUResult = SrcA ^ SrcB; 
            4'b0010:        // SUB
                    ALUResult = SrcA - SrcB;
            4'b0011:           //OR
                    ALUResult = SrcA | SrcB;  
            4'b0100:    // ADD or ADDI
                    ALUResult = SrcA + SrcB;
            4'b1000:        // Equal
                    ALUResult = (SrcA == SrcB) ? 1 : 0;   
            4'b1001: //SLT
			ALUResult = SrcA << SrcB;
            4'b1010: //LUI
                    ALUResult = SrcB;
            default:
                    ALUResult = 0;
            endcase
        end
endmodule

