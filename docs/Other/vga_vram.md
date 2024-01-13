# VGA 标准制式驱动（VRAM 扫描输出）

## 前置知识

VGA 显示输出可以使用像素直接驱动或标准制式驱动（VRAM 扫描输出）。直接驱动灵活方便，但需要实时屏幕位置计算，只适合显示变化较少几何图形或模板的信息，不宜显示动态变化内容丰富的信息，否则显示信息与屏幕（光栅）位置同步定位处理电路冗杂，信号延时超大，使显示内容刷新速度跟不上。

采用标准制式驱动，将显示内容事先存储于称为“显存”的缓存器 VRAM 中，信息在屏幕上的显示位置与 VRAM 单元地址一一对应，显示像素定位及同步时间是固定的。但通过 VRAM 间接驱动像素显示整体速度要降低许多，对于常用的图形图像显示算法可以用硬件实现来加速处理，这就是 GPU 加速原理。

VGA 显示标准、原理、简单的接口实现在本文不再赘述。

## SWORD2 硬件规格

## 像素定位方法

<!-- prettier-ignore-start -->
!!! abstract "本节的内容和受众"

    本节讲解的像素显示定位方法在直接像素驱动和 VRAM 驱动方法都通用。但如果你只是做图像信息处理，**不需要自己绘制几何图形和文本，可以跳过本节**。

    需要学习本节内容的有：

    -   学习 GPU 设计的
    -   需要自己绘制几何图形和文本的
<!-- prettier-ignore-end -->

我们直接看圆形显示的定位方法。

### 圆形显示

```verilog
    assign x = cx;
    assign y = cy;
    wire [9:0] x_sqr = (x - col) * (x - col);
    wire [9:0] y_sqr = (y - row) * (y - row);
    wire [17:0] r_sqr = radius * radius;
    wire Round = (r_sqr - x_sqr - y_sqr) <= radius << 1;
    wire incircle = (x_sqr + y_sqr < r_sqr);
    assign VGA_Pixel = Round ? RGB4:0;
//  assign VGA_Pixel = incircle ? RGB5:0;
```

### 图形叠加

可以使用一个多路选择器实现：

```verilog
always@* begin
    case(1'b1)
        Hline: VGA_Pixel = 12'h000;
        Vline: VGA_Pixel = 12'h000;
        Round: VGA_Pixel = 12'h000;
        incircle: VGA_Pixel = 12'hFF0;
        default: VGA_Pixel = 12'hFFF;
    endcase
end
```

### 线性运动

## VRAM 显示预备知识

### 整体结构

### VRAM 显存的大小和构建方法

显示图形缓存起 VRAM 存储的是实际图像的点阵，具体由分辨率和色彩位数决定。以 640x480 分辨率、12 位色为例，每个单元存储一个点，每个点 12 位，VRAM 计算如下：

$$
Units: 640 \times 480 = 307200 \\
Bytes: 307200 \times 12 = 3686400 bit = 450 KB
$$

构建该 307200VRAM 显存单元需 19 位地址线，存储资源 3600Kbit，占用 31% XC7K160T 片内 Block Memory 资源。如需扩大更高分辨率，可以使用 SWORD 版载存储资源。

### 使用版载存储资源

## 缓存直接显示

本节我们学习将固定的图片存入 ROM，并将其定位到屏幕上进行显示。

### ROM 缓存

-   首先将图片转换成点阵位图（BMP 格式）。

位图存储格式需要根据存储器的结构和缓存显示映射约定（显示协议）格式来确定。

-   然后使用 `bmp2coe` 工具将图片转换成 COE 格式。

这是 FPGA 的存储器初始化关联文件。

## 缓存间接显示

本节我们学习文本显示

## 动态图形显示

本节我们学习动态图形显示，


