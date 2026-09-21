module csa2(
    input  logic a, b, cin,
    output logic d, s
);
    // Generates a 1-bit full adder sum and carry[cite: 2]
    assign s = a ^ b ^ cin;
    assign d = (a & b) | (b & cin) | (a & cin);
endmodule