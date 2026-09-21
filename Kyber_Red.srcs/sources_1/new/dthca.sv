module dthca(
    input  logic [23:0] c,
    output logic [14:0] d0,
    output logic [14:0] S0
);

    // ==========================================
    // STEP 0: INVERTED BITS FOR NEGATIVE DOTS
    // ==========================================
    logic cb12, cb13, cb14, cb15, cb16, cb17, cb18, cb19, cb20, cb21, cb22, cb23;
    assign cb12 = ~c[12];
    assign cb13 = ~c[13];
    assign cb14 = ~c[14];
    assign cb15 = ~c[15];
    assign cb16 = ~c[16];
    assign cb17 = ~c[17];
    assign cb18 = ~c[18];
    assign cb19 = ~c[19];
    assign cb20 = ~c[20];
    assign cb21 = ~c[21];
    assign cb22 = ~c[22]; 
    assign cb23 = ~c[23]; 

    // ==========================================
    // STEP 1: ESTABLISH WIRES (Declarations)
    // ==========================================
    logic lvl1_s_c0_0, lvl1_d_c0_0;
    logic lvl1_s_c1_0, lvl1_d_c1_0;
    
    logic lvl1_s_c2_0, lvl1_d_c2_0;
    logic lvl1_s_c2_1, lvl1_d_c2_1;

    logic lvl1_s_c3_0, lvl1_d_c3_0;
    logic lvl1_s_c3_1, lvl1_d_c3_1;

    logic lvl1_s_c4_0, lvl1_d_c4_0;

    logic lvl1_s_c5_0, lvl1_d_c5_0;
    logic lvl1_s_c5_1, lvl1_d_c5_1;

    logic lvl1_s_c6_0, lvl1_d_c6_0;
    logic lvl1_s_c6_1, lvl1_d_c6_1;

    logic lvl1_s_c7_0, lvl1_d_c7_0;

    logic lvl1_s_c8_0,  lvl1_d_c8_0;
    logic lvl1_s_c8_1,  lvl1_d_c8_1;
    logic lvl1_s_c9_0,  lvl1_d_c9_0;
    logic lvl1_s_c9_1,  lvl1_d_c9_1;
    logic lvl1_s_c10_0, lvl1_d_c10_0;
    logic lvl1_s_c10_1, lvl1_d_c10_1;

    // ==========================================
    // STEP 2: LEVEL 1 COMPRESSION
    // ==========================================
    csa2 u_lvl1_c0_0 (.a(c[0]), .b(c[20]), .cin(c[17]), .s(lvl1_s_c0_0), .d(lvl1_d_c0_0));
    csa1 u_lvl1_c1_0 (.a(c[1]), .b(c[21]), .s(lvl1_s_c1_0), .d(lvl1_d_c1_0));
    
    csa2 u_lvl1_c2_0 (.a(c[2]),  .b(cb14),  .cin(cb16), .s(lvl1_s_c2_0), .d(lvl1_d_c2_0));
    csa2 u_lvl1_c2_1 (.a(c[19]), .b(c[20]), .cin(c[22]), .s(lvl1_s_c2_1), .d(lvl1_d_c2_1));

    csa2 u_lvl1_c3_0 (.a(c[3]),  .b(cb15),  .cin(cb17), .s(lvl1_s_c3_0), .d(lvl1_d_c3_0));
    csa1 u_lvl1_c3_1 (.a(c[21]), .b(c[23]),             .s(lvl1_s_c3_1), .d(lvl1_d_c3_1));

    csa2 u_lvl1_c4_0 (.a(c[4]),  .b(cb16),  .cin(cb18), .s(lvl1_s_c4_0), .d(lvl1_d_c4_0));

    csa2 u_lvl1_c5_0 (.a(c[5]),  .b(cb17),  .cin(c[19]), .s(lvl1_s_c5_0), .d(lvl1_d_c5_0));
    csa1 u_lvl1_c5_1 (.a(c[23]), .b(1'b1),               .s(lvl1_s_c5_1), .d(lvl1_d_c5_1));

    csa2 u_lvl1_c6_0 (.a(c[6]),  .b(c[18]), .cin(c[19]), .s(lvl1_s_c6_0), .d(lvl1_d_c6_0));
    csa1 u_lvl1_c6_1 (.a(cb20),  .b(1'b1),               .s(lvl1_s_c6_1), .d(lvl1_d_c6_1));

    csa2 u_lvl1_c7_0 (.a(c[7]),  .b(c[18]), .cin(cb21),  .s(lvl1_s_c7_0), .d(lvl1_d_c7_0));

    csa2 u_lvl1_c8_0 (.a(c[8]),  .b(c[12]), .cin(cb14),  .s(lvl1_s_c8_0), .d(lvl1_d_c8_0));
    csa1 u_lvl1_c8_1 (.a(c[17]), .b(cb22),               .s(lvl1_s_c8_1), .d(lvl1_d_c8_1));

    csa2 u_lvl1_c9_0 (.a(c[9]),  .b(c[12]), .cin(c[13]), .s(lvl1_s_c9_0), .d(lvl1_d_c9_0));
    csa2 u_lvl1_c9_1 (.a(cb15),  .b(c[19]), .cin(cb23),  .s(lvl1_s_c9_1), .d(lvl1_d_c9_1));

    csa2 u_lvl1_c10_0 (.a(c[10]), .b(c[13]), .cin(cb16), .s(lvl1_s_c10_0), .d(lvl1_d_c10_0));
    csa2 u_lvl1_c10_1 (.a(c[17]), .b(cb18),  .cin(c[19]), .s(lvl1_s_c10_1), .d(lvl1_d_c10_1));


    // ==========================================
    // STEP 3: FINAL BINDING (Column Weight Summation)
    // ==========================================
    // Groups the Level 1 outputs and remaining uncompressed dots by their exact column weight.
    // Vivado synthesizes this into the remaining compression stages automatically.

    logic [14:0] col0_sum, col1_sum, col2_sum, col3_sum, col4_sum, col5_sum, col6_sum;
    logic [14:0] col7_sum, col8_sum, col9_sum, col10_sum, col11_sum, col_constants;

    always_comb begin
        // Weight 2^0: L1 sum + uncompressed bits (cb12, cb14, cb19, c[18], 1'b1)[cite: 5]
        col0_sum = lvl1_s_c0_0 + cb12 + cb14 + cb19 + c[18] + 1'b1;

        // Weight 2^1: L1 sum + L1 carry from Col 0 + uncompressed (cb13, cb15)[cite: 5]
        col1_sum = (lvl1_s_c1_0 + lvl1_d_c0_0 + cb13 + cb15) << 1;

        // Weight 2^2: L1 sums + L1 carry from Col 1
        col2_sum = (lvl1_s_c2_0 + lvl1_s_c2_1 + lvl1_d_c1_0) << 2;

        // Weight 2^3: L1 sums + L1 carries from Col 2
        col3_sum = (lvl1_s_c3_0 + lvl1_s_c3_1 + lvl1_d_c2_0 + lvl1_d_c2_1) << 3;

        // Weight 2^4: L1 sum + uncompressed (c[22]) + L1 carries from Col 3
        col4_sum = (lvl1_s_c4_0 + c[22] + lvl1_d_c3_0 + lvl1_d_c3_1) << 4;

        // Weight 2^5: L1 sums + L1 carry from Col 4
        col5_sum = (lvl1_s_c5_0 + lvl1_s_c5_1 + lvl1_d_c4_0) << 5;

        // Weight 2^6: L1 sums + L1 carries from Col 5
        col6_sum = (lvl1_s_c6_0 + lvl1_s_c6_1 + lvl1_d_c5_0 + lvl1_d_c5_1) << 6;

        // Weight 2^7: L1 sum + uncompressed (1'b1) + L1 carries from Col 6
        col7_sum = (lvl1_s_c7_0 + 1'b1 + lvl1_d_c6_0 + lvl1_d_c6_1) << 7;

        // Weight 2^8: L1 sums + L1 carry from Col 7
        col8_sum = (lvl1_s_c8_0 + lvl1_s_c8_1 + lvl1_d_c7_0) << 8;

        // Weight 2^9: L1 sums + L1 carries from Col 8
        col9_sum = (lvl1_s_c9_0 + lvl1_s_c9_1 + lvl1_d_c8_0 + lvl1_d_c8_1) << 9;

        // Weight 2^10: L1 sums + L1 carries from Col 9
        col10_sum = (lvl1_s_c10_0 + lvl1_s_c10_1 + lvl1_d_c9_0 + lvl1_d_c9_1) << 10;

        // Weight 2^11: uncompressed (c[11]) + L1 carries from Col 10
        col11_sum = (c[11] + lvl1_d_c10_0 + lvl1_d_c10_1) << 11;

        // Top Constants: The remaining '1's for sign extension at weights 12, 13, and 14[cite: 5]
        col_constants = (15'd1 << 12) + (15'd1 << 13) + (15'd1 << 14);

        // Bind everything to S0. Leave d0 as zero since all carries are handled internally here.
        S0 = col0_sum + col1_sum + col2_sum + col3_sum + col4_sum + col5_sum + col6_sum + 
             col7_sum + col8_sum + col9_sum + col10_sum + col11_sum + col_constants;
    end
    
    assign d0 = 15'b0;

endmodule