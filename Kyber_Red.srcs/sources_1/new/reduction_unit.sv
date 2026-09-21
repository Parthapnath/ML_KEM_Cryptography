module reduction_unit(
    input  logic [23:0] c,
    output logic [11:0] r
);
    logic [14:0] d0, S0;
    logic [14:0] sum0, sum_m2q, sum_mq, sum_pq;
    
    // Kyber modulus constants
    localparam logic [14:0] Q      = 15'd3329;
    localparam logic [14:0] MIN_Q  = -15'd3329;
    localparam logic [14:0] MIN_2Q = -15'd6658;

    // Instantiate DTHCA
    dthca u_dthca(
        .c(c),
        .d0(d0),
        .S0(S0)
    );

    // FA0: Sums the carry and partial sum from DTHCA[cite: 2]
    fa_15bit fa0 (.a(d0), .b(S0), .sum(sum0));

    // Parallel Full Adders for range correction (-2q, -q, +q)[cite: 2]
    fa_15bit fa1 (.a(sum0), .b(MIN_2Q), .sum(sum_m2q));
    fa_15bit fa2 (.a(sum0), .b(MIN_Q),  .sum(sum_mq));
    fa_15bit fa3 (.a(sum0), .b(Q),      .sum(sum_pq));

    // Priority MUX
    mux_4to1 u_mux(
        .res0(sum0), 
        .res_minus_2q(sum_m2q), 
        .res_minus_q(sum_mq), 
        .res_plus_q(sum_pq), 
        .final_r(r)
    );
endmodule