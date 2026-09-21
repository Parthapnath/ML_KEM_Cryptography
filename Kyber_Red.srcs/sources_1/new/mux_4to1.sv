module mux_4to1(
    input  logic [14:0] res0, res_minus_2q, res_minus_q, res_plus_q,
    output logic [11:0] final_r
);
    // Selects the correct result based on the sign bits (MSBs) of the parallel additions[cite: 2]
    always_comb begin
        if (!res_minus_2q[14]) 
            final_r = res_minus_2q[11:0];
        else if (!res_minus_q[14]) 
            final_r = res_minus_q[11:0];
        else if (!res0[14]) 
            final_r = res0[11:0];
        else 
            final_r = res_plus_q[11:0];
    end
endmodule