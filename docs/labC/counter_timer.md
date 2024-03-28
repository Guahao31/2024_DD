# 计数器与计时器

<!-- !!! danger "请注意"
    本实验并未正式公布，内容与要求随时可能变化，仅供提前完成实验的同学参考。 -->

## 实验背景

### 74LS161 {: #bg-74ls161}

74LS161 芯片具有**同步四位二进制计数器**功能，其引脚如下：

<img src="../pic/sym_74LS161.png">

* `CP`：接入时钟信号，**上升沿**触发
* `CRn`：清零端，**低电平有效**，且为**异步清零**
* `LDn`：置数控制端，**低电平有效**
* `D3~D0`：置数数据端，当 `LDn` 有效时将数据写入
* `CTT, CTP`：使能端，两脚均为**高电平**时启用计数功能，**任意一脚**为低电平时计数器保持原状态
* `Q3~Q0`：数据输出端
* `CO`：进位输出端，当输出位均为 1 时置 1

请特别关注输出改变时机：**异步清零**意味着不论时钟信号为何当清零端有效时**立即**改变输出为 0；**清零外**的所有输出改变都发生在**时钟上升沿**（包括置数与计数）。

其功能表如下：

<img src="../pic/fun_74LS161.png" style="zoom: 60%">

??? note "时序图"
    提供时序图帮助理解：

    <img src="../pic/sync_74LS161.png">

### x进制计数器 {： #bg-x-counter}

74LS161 提供了十六进制计数器的功能，我们可以通过**反馈清零**和**反馈置位**等方法得到任意进制的计数器，本实验中只使用反馈清零的设计方法。

所谓“反馈清零”指的是用输出 `Q3~Q0` 的值决定何时清零，即清零端 `CRn` 是关于 `Q3~Q0` 的函数。以**十进制计数器**的设计为例，我们期望输出值为 `0~9` 十个状态，也就需要在将输出 `10` 时进行清零。十进制数 `10` 的二进制表示是 `b1010`，我们得到清零端为 $\overline{CR} = \overline{Q_3\overline{Q_2}Q_1\overline{Q_0}}$，注意到输出从 `0` 开始自增，到 `b1010` 时是**第一次** `Q3, Q1` 同时为 `1` 的状态(`b0000->b0001->...->b1010`)，因此我们可以简化清零端为 $\overline{CR} = \overline{Q_3Q_1}$，得到了如下电路，其功能为十进制计数器：

<img src="../pic/sym_bcd_counter.png">

在这里可能有一个疑问“为什么不在输出值为 `9` 时(`b1001`)进行清零”，之前提到芯片的复位是**异步**的，与时钟信号无关，在输出变为 `10` 的时钟上升沿后很短的时间内，复位信号变为有效，进而将输出清零，我们并不去考虑这段很短的时间可能造成的影响。而如果在输出值为 `9` 时进行清零，则实际得到的是“九进制”计数器。

如果希望拓展计数器的位宽，则需要多个计数器相连，以**256 进制计数器**为例，使用两片 74LS161，高 4 位的一个使能端接低 4 位计数器的进位端，在低 4 位输出为 `b1111` 时进位信号升起，使高位片在下个时钟上升沿时自增。

<img src="../pic/sym_256_counter.png">

结合刚刚介绍的两个计数器的设计特点，我们可以设计出任意进制的计数器（在不考虑具体时延影响的前提下），比如一个**五十进制计数器**，其输出状态应为 `0~49`，在输出应为 `50` 时(`b0011_0010`)进行清零。容易得到其清零端应为高位片的 `Q1, Q0` 与低位片的 `Q1` 的与非，即 $\overline{CR} = \overline{Q_1'Q_0'Q_1}$，同时需要将低位片的进位信号连接到高位片的使能端。

<img src="../pic/sym_50_counter.png">

## 实现 74LS161 功能

提供代码框架如下，请实现 74LS161 芯片功能，接口定义等内容见[实验背景](#bg-74ls161)。实现后对 `My74LS161` 进行仿真。

```verilog linenums="1"
module My74LS161(
    input CP,
    input CRn,
    input LDn,
    input [3:0] D,
    input CTT,
    input CTP,
    output [3:0] Q,
    output CO
);
    
    reg [3:0] Q_reg = 4'b0;
    
    always @(posedge CP or negedge CRn) begin
        if(!CRn) begin
            // reset
        end else begin
            //
        end
    end
    
    assign Q = Q_reg;
    assign CO = (Q == 4'hF);
    
endmodule
```

## 74LS161 应用

!!! note "请注意"
    请从“223 进制计数器”和“时钟应用”中**选择一个**来完成，如果选择“223 进制计数器”则**本实验获得分数不超过 70**。

!!! tip "关于实现"
    清零端和置数端应书写为 `CRn = ~(Q == 4'b1010)` 或 `CRn = ~(Q[3] & ~Q[2] & Q[1] & ~Q[0])`。**请不要**写成实验背景中的 `CRn = ~(Q[3] & Q[1])`。

### 223 进制计数器

请仿照[五十进制计数器](#bg-x-counter)，使用 `My74LS161` 模块实现一个“223进制”计数器，其状态输出为 `0-222`。实现后进行仿真验证。其中 `rstn` 为异步复位，低位有效。

```verilog linenums="1"
module counter_223(
    input clk,
    input rstn,     // Active-low, reset Q to 0
    output [7:0] Q
);
```

### 时钟应用

要求实现一个格式为“小时：分钟”的时钟应用，使用 Arduino 板上的七段数码管进行输出。使用 `SW[0]` 选择时钟速度，使用 `SW[1]` 对时钟进行“重置”（重置为 `23:00`）。

`top` 模块框架如下，请补充代码，获得正确的 `hour_tens, hour_ones, min_tens, min_ones`，要求必须使用 `My74LS161` 模块。

```verilog linenums="1"
module top(
    input clk,
    input [1:0] SW,
    output [3:0] AN,
    output [7:0] SEGMENT
);
    
    wire clk_10ms;
    wire clk_100ms;
    // clk_1s used in LabA
    clk_10ms clk_div_10ms (.clk(clk), .clk_10ms(clk_10ms)); // Refer to the code of clk_1s to complete these modules
    clk_100ms clk_div_100ms (.clk(clk), .clk_100ms(clk_100ms)); 
    
    wire clk_counter = (SW[0] == 1'b0) ? clk_10ms : clk_100ms; // Connect this clk_counter to CP-port of 74LS161
    
    wire [3:0] hour_tens;
    wire [3:0] hour_ones;
    wire [3:0] min_tens;
    wire [3:0] min_ones;
    
    // Your code here to get the correct HOUR and MINUTE
    
    // Module written in Lab 7
    DisplayNumber display_inst(.clk(clk), .hexs({hour_tens, hour_ones, min_tens, min_ones}), .points(4'b0100), .rst(1'b0), .LEs(4'b0000), .AN(AN), .SEGMENT(SEGMENT));
    
endmodule
```

需要注意：

* 分钟部分状态为 `0~59`
* 小时部分状态为 `0~23`
* 为每个 `My74LS161` 实例的 `LDn, D3~D0` 接线，使得 `SW[1] == 1` 时将时间设置为 `23:00`

一个可行的设计思路是，使用四个 `My74LS161` 实例分别存储 `hour_tens, hour_ones, min_tens, min_ones` 的值，你需要设计合适的清零与进位时机，如分钟(`min_tens, min_ones`)达到 59 后对时钟进位并清零。

请自行书写约束文件，并进行下板验证。

## 实验报告要求

### 实现 74LS161 功能

* 模块 `My74LS161` 代码
* 仿真代码，仿真波形与解释

### 74LS161 应用

* 若选择了“223 进制计数器”
    * 模块 `counter_223` 代码与解释
    * 仿真代码，仿真波形与解释
* 若选择了“时钟应用”
    * 模块 `top` 代码与解释
    * 下板图片，能够证明功能完整即可
