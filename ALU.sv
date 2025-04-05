module ALU(
input logic [3:0] opcode,
input logic [31:0] A,
input logic [31:0] B,
output logic [31:0] result, 
output logic zero,
output logic carry,
output logic overflow,
output logic sign
);

typedef enum logic[3:0]{
ADD = 4'b0000,
SUB = 4'b0001,
AND = 4'b0010,
OR  = 4'b0011,
XOR = 4'b0100,
CMP = 4'b0101
} op_t;

always_comb begin: ALU_CORE
zero = 1'b0;
carry = 1'b0;
overflow = 1'b0;
sign = 1'b0;
result = 32'd0;

case (opcode)
    ADD: begin
        {carry, result} = A+B;
        overflow = (~A[31] & ~B[31] & result[31]) | (A[31] & B[31] & ~result[31]);
    end

    SUB: begin
        {carry, result} = A - B;
        overflow = (A[31] & ~B[31] & ~result[31]) | (~A[31] & B[31] & result[31]);
    end

    default: result = 31'd0;
endcase
    
end

endmodule

