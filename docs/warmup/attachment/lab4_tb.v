`timescale 1ns/1ns

// Filename: lab4_tb.v
module lab4_tb ();

    reg I0;
    reg I1;
    reg I2;

    wire res;

    main test_inst (
        .I0(I0),
        .I1(I1),
        .I2(I2),
        .res(res)
    );

    initial begin
        #5;
        I0 = 1'b0; I1 = 1'b0; I2 = 1'b0; #5;
        I0 = 1'b0; I1 = 1'b0; I2 = 1'b1; #5;
        I0 = 1'b0; I1 = 1'b1; I2 = 1'b0; #5;
        I0 = 1'b0; I1 = 1'b1; I2 = 1'b1; #5;
        I0 = 1'b1; I1 = 1'b0; I2 = 1'b0; #5;
        I0 = 1'b1; I1 = 1'b0; I2 = 1'b1; #5;
        I0 = 1'b1; I1 = 1'b1; I2 = 1'b0; #5;
        I0 = 1'b1; I1 = 1'b1; I2 = 1'b1; #5;
        #5;
        I0 = 1'b0; I1 = 1'b0; I2 = 1'b0; #5;
    end

endmodule