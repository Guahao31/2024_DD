`timescale 1ns / 1ps

module D_74LS138_tb();

// Inputs
   reg G;
   reg G2A;
   reg G2B;
   reg C;
   reg A;
   reg B;

// Output
   wire [7:0] Y;

   D_74LS138 m0 (
    .Y(Y),
    .G(G),
    .G2A(G2A),
    .G2B(G2B),
    .A(A),
    .B(B), 
    .C(C)
   );
// Initialize Inputs
  initial begin
    C = 0; B = 0; A = 0;
    G = 1; G2A = 0; G2B = 0; #50;
    {C, B, A} = 3'b000;
    
    repeat(8) begin
      {C, B, A} = {C, B, A} + 3'b1; #50;
    end

    G=1'b0; G2A=1'b0; G2B=1'b0; #50;
    G=1'b1; G2A=1'b1; G2B=1'b0; #50;
    G=1'b1; G2A=1'b0; G2B=1'b1; #50;
  end
endmodule // D_74LS138_tb
