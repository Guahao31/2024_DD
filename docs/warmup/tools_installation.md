# 实验工具安装

我们将使用 [Vivado 套件](https://www.xilinx.com/products/design-tools/vivado.html)及 [logisim evolution](https://github.com/logisim-evolution/logisim-evolution) 完成实验，本节内容为实验工具安装的简易指导。安装过程中若遇到问题请在充分自行尝试后及时与助教沟通解决。

## Vivado 安装

[Vivado Design Suite](https://zh.wikipedia.org/zh-hans/Xilinx_Vivado) 是 Xilinx 开发的用于 HDL 设计的合成和分析的软件套件，具有用于片上系统开发和高级综合的附加功能。

在安装之前，请确保电脑有足够的磁盘容量（大约需要 30~50 GB 的安装空间）。

💡请选择不低于 **2021.2** 的版本

???+ warning "注意"
    如果使用 webpack 下载经常遇到需要 retry 的情况，你可以

    * 下载官网提供的完整镜像（一般名为 Xilinx/AMD Unified Installer 20xx.x SFD）
        * 不同版本的完整镜像文件大小 80~110GB，文件较大，请准备好足够空间
    * 或在**校网**环境下使用 FTP 获得 2020.2 版本
        * FTP 地址为 ftp://10.78.18.205/
        * FTP中有相关指导。为了防止传输中断导致的失败，请使用支持断点续传的 FTP 软件，比如 [FileZilla](https://filezilla-project.org/)
    

* 在官网提供的[下载网页](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html)中找到合适的版本(版本号；Windows/Linux)，选择“...Web Installer”（约300MB的文件）。

* 打开下载安装程序，使用注册的Xilinx账号登陆，并选择“Download and install now”
* 选择安装的软件 (Vivado) 、版本 (Vivado HL WebPACK)
* 选择需要的组件（以下为**必须勾选**）：Design Tools (Vivado Deign Suite, DocNav); Devices (Kintex-7); Installation Options (Install Cable Drivers)。选择完成后查看磁盘空间，使用上述选择需要30-40GB空间用来安装
    * 如果你之后需要使用其他型号的设备，可以通过 installer 补充下载，不必要一次全部安装(可以查看 [Xilinx-Support-60112](https://support.xilinx.com/s/article/60112))
* 确保空间充足，开始下载，并等待安装结束

!!! tip "建议"
    * 习惯使用 Linux 系统的同学可以安装 Linux 版本的 Vivado，WSL2 也可尝试安装。

    * 目前未找到在 Apple M1/M2 机器上安装运行 Vivado 的方法。

    * Vivado 安装路径上不要出现中文和空格。

### FAQ

#### 安装找不到 *WebPack* 选项

选择 *Standard* 版本即可。 *Enterprise* 版本需要付费。

#### Device 看不到 Kintex-7 选项

展开 *7 Series*，在里面可以找到 K7 板。

## Logisim Evolution 安装

LogicSim 是一种数字逻辑电路仿真工具，用于模拟数字电路的行为和性能。实验使用的 Logisim-evolution 是功能加强的免费、开源、跨平台的版本。

Logisim-evolution 需要 **Java 运行环境**(Java 16+)，可以在[官网下载界面](https://www.oracle.com/java/technologies/downloads/#java17)选择对应平台版本，完成下载并进行安装。

如果你能打开 Logisim-evolution 项目的 [release](https://github.com/logisim-evolution/logisim-evolution/releases/tag/v3.8.0) 网页，推荐你在这个网页中选择合适的安装包或使用源码自行编译（Windows 用户可以选择 *.msi* 的安装文件，macOS 用户选择 *.dmg* 安装文件）。如果你无法稳定访问，可以在[浙大云盘](https://pan.zju.edu.cn/share/4e7b3139e7a5a3ff998ad1b5b6)下载，若链接失效，请联系 guahao@zju.edu.cn。