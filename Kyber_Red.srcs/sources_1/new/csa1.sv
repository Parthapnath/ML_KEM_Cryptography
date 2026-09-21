module csa1(
    input  logic a, b,
    output logic d, s
);
    // Generates a 1-bit half adder sum and carry[cite: 2]
    assign s = a ^ b;
    assign d = a & b;
endmodule