module fa_15bit(
    input  logic [14:0] a, b,
    output logic [14:0] sum
);
    assign sum = a + b;
endmodule