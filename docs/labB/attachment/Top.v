module Top(
    input clk,
    input [3:0] BTN_Y, 
    input [15:0] SW,
    output BTN_X,
    output[3:0]AN,
    output[7:0] SEGMENT
);

    wire [31:0] my_clkdiv;
    wire [2:0] btn_out;
    reg  [11:0] num;
    wire [3:0] A1, A2, B1, B2, C1, C2;
    wire [3:0] mux_out;
    wire Co;
    wire [3:0] ALU_res;

    /* SW[1:0] to control if the counter for A or B is reversal */
    wire A_Ctrl = SW[0];
    wire B_Ctrl = SW[1];
    /* SW[3:2] to choose the mode of the ALU */
    wire [1:0] ALU_Ctrl = SW[3:2];
    /* SW[5:4] to choose from A B C and 0 */
    /* 00 for A; 01 for B; 10 for C; 11 for 0 */
    wire [1:0] Trans_select = SW[5:4];

    wire [3:0] reg_A_val = num[ 3: 0];
    wire [3:0] reg_B_val = num[ 7: 4];
    wire [3:0] reg_C_val = num[11: 8];

    assign BTN_X = 1'b0;

    clkdiv m0(.clk(clk), .rst(1'b0), .div_res(my_clkdiv));
    
    pbdebounce m1(.clk(my_clkdiv[17]), .button(BTN_Y[0]), .pbreg(btn_out[0]));
    pbdebounce m2(.clk(my_clkdiv[17]), .button(BTN_Y[1]), .pbreg(btn_out[1]));
    pbdebounce m3(.clk(my_clkdiv[17]), .button(BTN_Y[2]), .pbreg(btn_out[2]));
    
    AddSub4b m4(.A(reg_A_val), .B(4'b0001), .Ctrl(A_Ctrl), .S(A1));
    AddSub4b m5(.A(reg_B_val), .B(4'b0001), .Ctrl(B_Ctrl), .S(B1));
    
    Mux4to1b4 m6(.D0(reg_A_val), .D1(reg_B_val), .D2(reg_C_val), .D3(4'b0000),
                                     .S(Trans_select), .Y(mux_out));
    
    /* ALU module implemented in Lab8 */
    /* A/B    : operands */
    /* S        : select the operation on ALU  */
    /* C         : result of ALU */
    /* Co        : Carry bit */
    ALU m7(.A(num_A), .B(num_B), .res(ALU_res), .Cout(Co), .op(ALU_Ctrl)); // (Co) may be useless
    
    DisplayNumber m8(.clk(clk), .hexs({reg_A_val, reg_B_val, ALU_res, reg_C_val}), 
                            .LEs(4'b0000), .points(4'b0000), .rst(1'b0), .AN(AN),
                            .SEGMENT(SEGMENT));
    
    /* Your code here */
    // SW[15]: 0 for ALU mode, 1 for Trans mode.
    assign A2 = (1'b0 == SW[15]) ? A1 : mux_out; 
    assign B2 = ();
    assign C2 = ();
    
    always@(posedge btn_out[0]) num[3:0] = A2;
    always@() num[7:4] = ();
    always@() num[11:8] = ();
    /******************/

endmodule
