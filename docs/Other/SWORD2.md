# SWORD2 使用说明

要做 FPGA 开发，开发者应当能够获得 FPGA 的产品说明书和技术规范。但 SWORD2 因历史原因，资料稀缺。本文档是笔者在学习和使用 SWORD2 开发板时收集和探索到的一些信息，供大家参考，也欢迎补充。

在本篇文档中，我会逐一介绍 SWORD2 各个部件的功能、工作原理、引脚定义，以及我们如何在 FPGA 开发中使用它们（给出示例的 Verilog 模块）。

## 可供参考的 SWORD 4.0

在课程中我们使用的是 SWORD2 开发板，而 SWORD2 现已找不到任何资料。[SWORD 官网](http://www.sword.org.cn/)上公布了 SWROD 4.0 产品的相关资料，包括完整的引脚定义和项目参考。对比 4.0 和 2.0 的图示，猜测 4.0 版本只是将 2.0 版本的部分资源进行了重新分配，比如将左侧的几个 PMOD 更改为右侧的光口 SFP，其余引脚定义保持兼容。这些 SWORD 4.0 的资料也可以作为 SWORD2 的参考。

<!-- prettier-ignore-start -->
!!! note "SWORD 4.0 板卡约束文件"

    -   [ISE UCF 文件](http://www.sword.org.cn/sites/default/files/SWORD4.ucf)
    -   [Vivado XDC 文件](http://www.sword.org.cn/sites/default/files/SWORD4.xdc)

??? info "SWORD 4.0 与 2.0 图示比较"

    从图中可以看到 SWORD 4.0 与 2.0 的接口发生了一些改变：

    ```text
    + SFP3, SPF4
    - PMOD B, PMOD C, PMOD D, PMOD XADC
    - SATA x2
    - USB HOSTB, USB HOSTC
    - AXT IN
    + DC OUT
    - Digilent
    + PCIE_GEN2_X4
    - SPI Flash
    + BPI Flash(?)
    ```

??? info "SWROD4 引脚文件在 SWORD2 开发板上可用性验证状态"

    -   ✅ 数字逻辑设计课程 Lab 使用过的：Switch、Button、数码管
    -   ✅ HDMI TX/RX
<!-- prettier-ignore-end -->

## SWORD2 主要参数

-   XC7K160T-2FFG676C
-   6MB SRAM 静态存储：支持 32Data，16 位TAG
-   512M BDDR3 动态存储：支持 32Data
-   32MB NOR Flash 存储：支持 32 位 Data
-   12 位 VGA 接口（RGB656）
-   USB-HID
-   UART
-   10/100/1000M 以太网口
-   SFP 光口
-   HDMI 接口
-   PMOD
-   MicroSD（TF）卡槽
-   Arduino

## FPGA 芯片

SWORD2 使用的 FPGA 芯片为 Kintex-7 XC7K160T FFG676，片内存储 11.9808 Mb。

FPGA 芯片的技术规范：[XC7K160T-2FFG676C](https://www.digikey.com/en/products/detail/amd/XC7K160T-2FFG676C/3671575)

## 板载存储

<!-- prettier-ignore-start -->
??? info "简单介绍一下几种存储技术"

    -   闪存 Flash Memory：非易失性存储器（断电后数据还在）
        -   NAND Flash：用于大容量存储，读写速度慢，擦写次数有限
        -   NOR Flash：用于小容量存储，读写速度快，擦写次数无限
    -   随机访问存储器 Random Access Memory：易失性存储器
        -   静态随机访问存储器 Static RAM：快速，用于 CPU 缓存，双稳态特性
        -   动态随机访问存储器 Dynamic RAM：用于主存储器，对干扰非常敏感
<!-- prettier-ignore-end -->

SWORD2 板载存储有：

### Flash-1, Flash-2

板载 2 片 NOR Flash，每片 16 MB，共 32 MB。

Flash 芯片的技术规范：[S29GL128S](https://www.infineon.com/dgdl/Infineon-S29GL01GS_S29GL512S_S29GL256S_S29GL128S_128_Mb_256_Mb_512_Mb_1_Gb_GL-S_MIRRORBIT_TM_Flash_Parallel_3-DataSheet-v21_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed07ac14bd5)

<!-- prettier-ignore-start -->
!!! info "引脚定义"

    详细的引脚定义见 [SWORD 4.0 板卡约束文件](attachment/SWORD4.xdc)。其中的 BPI Flash 模块引脚定义如下：

    -   `bpi_addr[23:0]`：地址总线
    -   `bpi_ce_n[1:0]`：片选信号
    -   `bpi_dq_io[47:0]`：数据总线
    -   `bpi_oen`：输出使能
    -   `bpi_rdy[1:0]`：读就绪
    -   `bpi_rpn`：读保持
    -   `bpi_wen`：写使能

<!-- prettier-ignore-end -->

### SRAM-1, SRAM-2, SRAM-3

SRAM 芯片的技术规范：[](https://www.digikey.at/en/products/detail/infineon-technologies/CY7C1061DV33-10BV1XI/2663971)

<!-- prettier-ignore-start -->
!!! info "引脚定义"

    三片板载 SRAM 与 SWORD 4.0 布线位置相同，直接沿用。详细的引脚定义见 [SWORD 4.0 板卡约束文件](attachment/SWORD4.xdc)。其中的 SRAM 模块引脚定义如下：

    -   `sram_addr[19:0]`：地址总线
    -   `sram_ce[3:0]`：片选信号
    -   `sram_dq[47:0]`：数据总线
    -   `sram_oen[3:0]`：输出使能
    -   `sram_wen[3:0]`：写使能
    -   `sram_bhen[3:0]`：高字节使能
    -   `sram_blen[3:0]`：低字节使能
    -   `sram_bls[3:0]`：字节选择

<!-- prettier-ignore-end -->

### SPI FLash

