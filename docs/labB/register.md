# 寄存器与寄存器传输设计

<!-- !!! danger "请注意"
    本实验并未正式公布，内容与要求随时可能变化，仅供提前完成实验的同学参考。 -->

## 实验背景

**寄存器**是一组二进制存储单元，一个寄存器可以用于存储多位二进制值，通常用于进行简单数据存储、移动和处理等操作。最基本的操作为**读和写**，其中写操作通常在时钟边沿时将接受的输入值存储在触发器中。

**采用门控时钟的寄存器**指通过一个或多个控制信号控制门电路的打开和关闭，只有在门控打开时才能对寄存器的值进行修改，一个简单的实现是使用一个信号 `Load` 作为门控信号，`Load` 与时钟信号的与为门控时钟信号，如下图：

<img src="../pic/gated_clock.png">

一个更稳定的方式是“采用 Load 控制反馈的寄存器”，它不对时钟信号进行处理，而是在触发器的输入端使用 2-1 多路选择器从**触发器的值**与**输入的值**之间进行选择，原理图如下（存储 2 位数据的寄存器）：

<img src="../pic/load_feedback.png">

## 数据传输应用

本次实验使用多路选择器总线进行寄存器传输，其模式图如下，寄存器的值“汇总”到一个多路选择器并通过选择信号选择一个值作为三个寄存器的输入，当 Load 信号升起时对对应寄存器的值进行修改：

<img src="../pic/mux_bus.png" style="zoom: 40%">

使用 Arduino 板上的七段数码管显示结果，显示顺序如下：

<img src="../pic/example.png" style="zoom: 60%">

需要实现的功能如下：

* `SW[15] = 0` ALU 运算输出模式
    * `SW[0]` 控制 `A` 的增/减；`SW[1]` 控制 `B` 的增/减
    * `SW[3:2]` 控制 ALU 运算类型
    * 按下 `btn[0]` 用 `A` 自增/自减的值更新 `A`
    * 按下 `btn[1]` 用 `B` 自增/自减的值更新 `B`
    * 按下 `btn[2]` 用 ALU 运算结果更新 `C`
* `SW[15] = 1` 数据传输控制
    * `SW[5:4]` 传输选择信号，`00` 选择 A，`01` 选择 B，`10` 选择 C，`11` 选择常数 0
    * `btn[0], btn[1], btn[2]` 分别为三个寄存器 `A, B, C` 的 load 信号。如在按下 `btn[0]` 时用当前总线上数据对 A 的值进行更新

提供 Top 模块代码，子模块请自行添加。

??? "Top.v"
    ```verilog linenums="1"
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
        wire [3:0] A1, A2, B1, B2, C1, C2; // C1 maybe useless
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
        ALU m7(.A(reg_A_val), .B(reg_B_val), .res(ALU_res), .Cout(Co), .op(ALU_Ctrl)); // (Co) may be useless
        
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
    ```

自行书写约束文件，下板验证。

## 实验报告要求

1. 补全后的 Top 模块代码与分析。
2. 下板验证图片。