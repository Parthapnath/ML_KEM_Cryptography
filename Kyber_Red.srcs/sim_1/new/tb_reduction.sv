`timescale 1ns / 1ps

module tb_reduction;
    logic [23:0] c;
    logic [11:0] r;

    // Instantiate the Unit Under Test (UUT)
    reduction_unit uut (
        .c(c),
        .r(r)
    );

    initial begin
        // Test Vector 1: 0 (Min bound)
        c = 24'h000000;
        #10;
        
        // Test Vector 2: Modulus value (Should output 0)
        c = 24'd3329;
        #10;
        
        // Test Vector 3: Max product (3328^2 = 11,075,584)[cite: 1]
        c = 24'hA90000; 
        #10;
        
        // Test Vector 4: Random verification
        c = 24'd10000; // 10000 mod 3329 = 11
        #10;
        
        $finish;
    end
endmodule