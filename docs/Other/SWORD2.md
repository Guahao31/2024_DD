# SWORD2 相关信息

做 FPGA 开发，开发者应当能够获得 FPGA 的产品说明书和技术规范。但 SWORD2 因历史原因，资料稀缺。本文档是笔者在学习和使用 SWORD2 开发板时收集、探索到的一些信息，供大家参考，也欢迎补充。

## SWORD 4.0

SWORD 官网上仅公布了 4.0 产品的相关资料，包括完整的引脚定义和项目参考。对比 4.0 和 2.0 的图示，猜测 4.0 版本只是将 2.0 版本的部分资源进行了重新分配，比如将左侧的几个 PMOD 更改为右侧的光口 SFP，其余引脚定义保持兼容。

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

??? info "目前已经验证过有效的引脚"

    -   数字逻辑设计课程 Lab 使用的所有 Switch、Button、数码管等基础引脚均有效
    -   HDMI TX/RX 均有效
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

    ```text
    set_property PACKAGE_PIN C12 [get_ports {bpi_addr[0]}]
    set_property PACKAGE_PIN J11 [get_ports {bpi_addr[1]}]
    set_property PACKAGE_PIN H13 [get_ports {bpi_addr[2]}]
    set_property PACKAGE_PIN H12 [get_ports {bpi_addr[3]}]
    set_property PACKAGE_PIN J13 [get_ports {bpi_addr[4]}]
    set_property PACKAGE_PIN H11 [get_ports {bpi_addr[5]}]
    set_property PACKAGE_PIN J10 [get_ports {bpi_addr[6]}]
    set_property PACKAGE_PIN J8 [get_ports {bpi_addr[7]}]
    set_property PACKAGE_PIN F9 [get_ports {bpi_addr[8]}]
    set_property PACKAGE_PIN F8 [get_ports {bpi_addr[9]}]
    set_property PACKAGE_PIN E10 [get_ports {bpi_addr[10]}]
    set_property PACKAGE_PIN F10 [get_ports {bpi_addr[11]}]
    set_property PACKAGE_PIN D9 [get_ports {bpi_addr[12]}]
    set_property PACKAGE_PIN D8 [get_ports {bpi_addr[13]}]
    set_property PACKAGE_PIN G14 [get_ports {bpi_addr[14]}]
    set_property PACKAGE_PIN H14 [get_ports {bpi_addr[15]}]
    set_property PACKAGE_PIN B9 [get_ports {bpi_addr[16]}]
    set_property PACKAGE_PIN G11 [get_ports {bpi_addr[17]}]
    set_property PACKAGE_PIN H9 [get_ports {bpi_addr[18]}]
    set_property PACKAGE_PIN G12 [get_ports {bpi_addr[19]}]
    set_property PACKAGE_PIN F12 [get_ports {bpi_addr[20]}]
    set_property PACKAGE_PIN H8 [get_ports {bpi_addr[21]}]
    set_property PACKAGE_PIN A8 [get_ports {bpi_addr[22]}]
    set_property PACKAGE_PIN C9 [get_ports {bpi_addr[23]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[23]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[22]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[21]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[20]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[19]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[18]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[17]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[16]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[15]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[14]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[13]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[12]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[11]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[10]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[9]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[8]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_addr[0]}]
    set_property PACKAGE_PIN D14 [get_ports {bpi_dq_io[0]}]
    set_property PACKAGE_PIN D13 [get_ports {bpi_dq_io[1]}]
    set_property PACKAGE_PIN E13 [get_ports {bpi_dq_io[2]}]
    set_property PACKAGE_PIN E12 [get_ports {bpi_dq_io[3]}]
    set_property PACKAGE_PIN C14 [get_ports {bpi_dq_io[4]}]
    set_property PACKAGE_PIN C13 [get_ports {bpi_dq_io[5]}]
    set_property PACKAGE_PIN B12 [get_ports {bpi_dq_io[6]}]
    set_property PACKAGE_PIN B11 [get_ports {bpi_dq_io[7]}]
    set_property PACKAGE_PIN B14 [get_ports {bpi_dq_io[8]}]
    set_property PACKAGE_PIN A14 [get_ports {bpi_dq_io[9]}]
    set_property PACKAGE_PIN B10 [get_ports {bpi_dq_io[10]}]
    set_property PACKAGE_PIN A10 [get_ports {bpi_dq_io[11]}]
    set_property PACKAGE_PIN B15 [get_ports {bpi_dq_io[12]}]
    set_property PACKAGE_PIN A15 [get_ports {bpi_dq_io[13]}]
    set_property PACKAGE_PIN A13 [get_ports {bpi_dq_io[14]}]
    set_property PACKAGE_PIN A12 [get_ports {bpi_dq_io[15]}]
    set_property PACKAGE_PIN J14 [get_ports {bpi_dq_io[16]}]
    set_property PACKAGE_PIN J25 [get_ports {bpi_dq_io[17]}]
    set_property PACKAGE_PIN C18 [get_ports {bpi_dq_io[18]}]
    set_property PACKAGE_PIN J23 [get_ports {bpi_dq_io[19]}]
    set_property PACKAGE_PIN K23 [get_ports {bpi_dq_io[20]}]
    set_property PACKAGE_PIN B17 [get_ports {bpi_dq_io[21]}]
    set_property PACKAGE_PIN L22 [get_ports {bpi_dq_io[22]}]
    set_property PACKAGE_PIN D15 [get_ports {bpi_dq_io[23]}]
    set_property PACKAGE_PIN H22 [get_ports {bpi_dq_io[24]}]
    set_property PACKAGE_PIN K15 [get_ports {bpi_dq_io[25]}]
    set_property PACKAGE_PIN J24 [get_ports {bpi_dq_io[26]}]
    set_property PACKAGE_PIN K22 [get_ports {bpi_dq_io[27]}]
    set_property PACKAGE_PIN C17 [get_ports {bpi_dq_io[28]}]
    set_property PACKAGE_PIN D16 [get_ports {bpi_dq_io[29]}]
    set_property PACKAGE_PIN A17 [get_ports {bpi_dq_io[30]}]
    set_property PACKAGE_PIN L23 [get_ports {bpi_dq_io[31]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[31]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[30]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[29]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[28]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[27]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[26]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[25]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[24]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[23]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[22]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[21]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[20]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[19]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[18]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[17]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[16]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[15]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[14]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[13]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[12]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[11]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[10]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[9]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[8]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_dq_io[0]}]
    set_property PACKAGE_PIN D11 [get_ports {bpi_ce_n[0]}]
    set_property PACKAGE_PIN F14 [get_ports {bpi_ce_n[1]}]
    set_property PACKAGE_PIN C11 [get_ports {bpi_rdy[0]}]
    set_property PACKAGE_PIN E11 [get_ports {bpi_rdy[1]}]
    set_property PACKAGE_PIN F13 [get_ports bpi_oen]
    set_property PACKAGE_PIN G9 [get_ports bpi_rpn]
    set_property PACKAGE_PIN G10 [get_ports bpi_wen]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_ce_n[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_ce_n[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_rdy[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {bpi_rdy[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports bpi_oen]
    set_property IOSTANDARD LVCMOS33 [get_ports bpi_rpn]
    set_property IOSTANDARD LVCMOS33 [get_ports bpi_wen]
    ```
<!-- prettier-ignore-end -->

### SRAM-1, SRAM-2, SRAM-3

SRAM 芯片的技术规范：[](https://www.digikey.at/en/products/detail/infineon-technologies/CY7C1061DV33-10BV1XI/2663971)

<!-- prettier-ignore-start -->
!!! info "引脚定义"

    三片板载 SRAM 与 SWORD 4.0 布线位置相同，直接沿用。

    ```text
    set_property PACKAGE_PIN D20 [get_ports {sram_addr[0]}]
    set_property PACKAGE_PIN D18 [get_ports {sram_addr[1]}]
    set_property PACKAGE_PIN E16 [get_ports {sram_addr[2]}]
    set_property PACKAGE_PIN E18 [get_ports {sram_addr[3]}]
    set_property PACKAGE_PIN E17 [get_ports {sram_addr[4]}]
    set_property PACKAGE_PIN E20 [get_ports {sram_addr[5]}]
    set_property PACKAGE_PIN F15 [get_ports {sram_addr[6]}]
    set_property PACKAGE_PIN F18 [get_ports {sram_addr[7]}]
    set_property PACKAGE_PIN H19 [get_ports {sram_addr[8]}]
    set_property PACKAGE_PIN J16 [get_ports {sram_addr[9]}]
    set_property PACKAGE_PIN J18 [get_ports {sram_addr[10]}]
    set_property PACKAGE_PIN J20 [get_ports {sram_addr[11]}]
    set_property PACKAGE_PIN G19 [get_ports {sram_addr[12]}]
    set_property PACKAGE_PIN H17 [get_ports {sram_addr[13]}]
    set_property PACKAGE_PIN F20 [get_ports {sram_addr[14]}]
    set_property PACKAGE_PIN G17 [get_ports {sram_addr[15]}]
    set_property PACKAGE_PIN F17 [get_ports {sram_addr[16]}]
    set_property PACKAGE_PIN F19 [get_ports {sram_addr[17]}]
    set_property PACKAGE_PIN H18 [get_ports {sram_addr[18]}]
    set_property PACKAGE_PIN G20 [get_ports {sram_addr[19]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[8]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[9]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[10]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[11]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[12]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[13]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[14]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[15]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[16]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[17]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[18]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[19]}]
    set_property PACKAGE_PIN E15 [get_ports {sram_ce[1]}]
    set_property PACKAGE_PIN G15 [get_ports {sram_ce[2]}]
    set_property PACKAGE_PIN K20 [get_ports {sram_ce[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_ce[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_ce[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_ce[3]}]
    set_property PACKAGE_PIN M16 [get_ports {sram_dq[0]}]
    set_property PACKAGE_PIN L19 [get_ports {sram_dq[1]}]
    set_property PACKAGE_PIN L17 [get_ports {sram_dq[2]}]
    set_property PACKAGE_PIN K18 [get_ports {sram_dq[3]}]
    set_property PACKAGE_PIN L18 [get_ports {sram_dq[4]}]
    set_property PACKAGE_PIN K17 [get_ports {sram_dq[5]}]
    set_property PACKAGE_PIN K16 [get_ports {sram_dq[6]}]
    set_property PACKAGE_PIN M17 [get_ports {sram_dq[7]}]
    set_property PACKAGE_PIN H26 [get_ports {sram_dq[8]}]
    set_property PACKAGE_PIN H23 [get_ports {sram_dq[9]}]
    set_property PACKAGE_PIN H21 [get_ports {sram_dq[10]}]
    set_property PACKAGE_PIN J26 [get_ports {sram_dq[11]}]
    set_property PACKAGE_PIN L20 [get_ports {sram_dq[12]}]
    set_property PACKAGE_PIN J19 [get_ports {sram_dq[13]}]
    set_property PACKAGE_PIN J21 [get_ports {sram_dq[14]}]
    set_property PACKAGE_PIN K21 [get_ports {sram_dq[15]}]
    set_property PACKAGE_PIN B26 [get_ports {sram_dq[16]}]
    set_property PACKAGE_PIN C22 [get_ports {sram_dq[17]}]
    set_property PACKAGE_PIN A24 [get_ports {sram_dq[18]}]
    set_property PACKAGE_PIN A23 [get_ports {sram_dq[19]}]
    set_property PACKAGE_PIN E22 [get_ports {sram_dq[20]}]
    set_property PACKAGE_PIN E23 [get_ports {sram_dq[21]}]
    set_property PACKAGE_PIN C24 [get_ports {sram_dq[22]}]
    set_property PACKAGE_PIN D23 [get_ports {sram_dq[23]}]
    set_property PACKAGE_PIN B20 [get_ports {sram_dq[24]}]
    set_property PACKAGE_PIN A20 [get_ports {sram_dq[25]}]
    set_property PACKAGE_PIN C21 [get_ports {sram_dq[26]}]
    set_property PACKAGE_PIN B21 [get_ports {sram_dq[27]}]
    set_property PACKAGE_PIN A22 [get_ports {sram_dq[28]}]
    set_property PACKAGE_PIN B22 [get_ports {sram_dq[29]}]
    set_property PACKAGE_PIN D21 [get_ports {sram_dq[30]}]
    set_property PACKAGE_PIN E21 [get_ports {sram_dq[31]}]
    set_property PACKAGE_PIN H24 [get_ports {sram_dq[32]}]
    set_property PACKAGE_PIN E26 [get_ports {sram_dq[33]}]
    set_property PACKAGE_PIN G25 [get_ports {sram_dq[34]}]
    set_property PACKAGE_PIN F24 [get_ports {sram_dq[35]}]
    set_property PACKAGE_PIN F25 [get_ports {sram_dq[36]}]
    set_property PACKAGE_PIN G24 [get_ports {sram_dq[37]}]
    set_property PACKAGE_PIN G21 [get_ports {sram_dq[38]}]
    set_property PACKAGE_PIN G26 [get_ports {sram_dq[39]}]
    set_property PACKAGE_PIN F22 [get_ports {sram_dq[40]}]
    set_property PACKAGE_PIN G22 [get_ports {sram_dq[41]}]
    set_property PACKAGE_PIN C26 [get_ports {sram_dq[42]}]
    set_property PACKAGE_PIN D24 [get_ports {sram_dq[43]}]
    set_property PACKAGE_PIN E25 [get_ports {sram_dq[44]}]
    set_property PACKAGE_PIN F23 [get_ports {sram_dq[45]}]
    set_property PACKAGE_PIN D25 [get_ports {sram_dq[46]}]
    set_property PACKAGE_PIN D26 [get_ports {sram_dq[47]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[8]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[9]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[10]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[11]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[12]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[13]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[14]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[15]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[16]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[17]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[18]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[19]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[20]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[21]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[22]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[23]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[24]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[25]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[26]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[27]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[28]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[29]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[30]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[31]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[32]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[33]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[34]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[35]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[36]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[37]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[38]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[39]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[40]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[41]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[42]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[43]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[44]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[45]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[46]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[47]}]
    set_property PACKAGE_PIN D19 [get_ports {sram_oen[1]}]
    set_property PACKAGE_PIN U19 [get_ports {sram_oen[2]}]
    set_property PACKAGE_PIN P16 [get_ports {sram_oen[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_oen[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_oen[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_oen[3]}]
    set_property PACKAGE_PIN J15 [get_ports {sram_wen[1]}]
    set_property PACKAGE_PIN T19 [get_ports {sram_wen[2]}]
    set_property PACKAGE_PIN P23 [get_ports {sram_wen[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_wen[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_wen[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_wen[3]}]
    set_property PACKAGE_PIN R26 [get_ports {sram_bhen[1]}]
    set_property PACKAGE_PIN P20 [get_ports {sram_bhen[2]}]
    set_property PACKAGE_PIN P18 [get_ports {sram_bhen[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_bhen[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_bhen[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_bhen[3]}]
    set_property PACKAGE_PIN K26 [get_ports {sram_blen[1]}]
    set_property PACKAGE_PIN M20 [get_ports {sram_blen[2]}]
    set_property PACKAGE_PIN R17 [get_ports {sram_blen[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_blen[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_blen[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sram_blen[3]}]
    ```

<!-- prettier-ignore-end -->

### SPI FLash

