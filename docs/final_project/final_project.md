# 课程设计内容与要求

## 实验环境

1. Sword Kintex 7 实验平台
2. 使用 Verilog HDL 或 System Verilog 完成设计

## 基本要求与截止时间

1. 在 Sword Kintex 7 实验平台上设计具有完整功能的时序电路
2. 基本输入输出交互选择
    1. Sword 实验平台上的按钮输入：SW, BTN
    2. Sword 实验平台上的显示输出：LED、七段数码管
    3. 扩展接口（根据工程设计使用）：PS/2 接口键盘鼠标、VGA 输出显示、蜂鸣器
3. 分组信息提交截止时间：12 月 20 日
4. 工程与设计报告提交截止时间：1 月 11 日 23:59

## 分组要求

在**班内**寻找队友，组成 2-3 人小组，组长填写[问卷](https://form.zju.edu.cn/#/dform/genericForm/AlB8CrYX)。

## 设计功能要求

1. 基本功能要求
    1. 有意义的时序状态机设计实现
    2. 存储器读写访问：RAM、ROM
    3. 适当的人机交互 I/O 接口（至少包括七段数码管、开关、按钮及 LED）
2. 扩展功能要求
    1. 使用 PS/2 接口的键盘或鼠标
    2. 使用 VGA 输出显示图形界面
    3. 使用蜂鸣器
3. 设计参考案例：手指跳舞机
    1. 以 Sword 上的七段数码管显示来指示上下左右
    2. 以 Sword 上的按钮作为上、下、左、右的输入
    3. 判断并显示输入的正确性，并随着游戏进展提高游戏难度
    4. 设置游戏失败的条件（如错按或未按几次按键）

## 可选题目

可从以下题目中选题制作，但**不限于**以下主题：

* 计算器
* 霓虹灯控制器
* 数字计时器
* 俄罗斯方块
* 贪吃蛇
* 打乒乓
* 吃豆豆

## 文档与工程提交要求

**组长**需要在[学在浙大](https://courses.zju.edu.cn/)平台提交**四份**作业，分别为代码文件、设计报告、工程文件、演示视频。

### 代码文件

提交所有的 Verilog 或 System Verilog 文件，将其打包为 `zip` 格式，请勿使用其他压缩格式。

提交时命名为 `组长学号_小组名_code.zip`，源代码文件压缩包不宜超过 5MB，特殊情况请先联系助教。

### 设计报告 {: #design-report}

提交设计报告，包括设计说明、核心模块说明与仿真、调试过程分析、小组主要工作说明、各成员贡献比例。

**小组主要工作说明**一节必须给出所有的参考工程（网络可见的应给出链接，其他参考与工程文件一同提交）并指出小组在其基础上进行了哪些工作，表明本组工作量。

**各成员贡献比例**一节应如实给出，并附小组所有成员手写签名的图片。助教给出小组得分后将根据贡献比例分配得分，分数不溢出。

如小组 3 人得基础分 13 分，三人贡献分别为 60% 20% 20%，分数包 3*13 = 39 分，贡献 60% 者（39 * 0.6 = 23.4）大作业满分，另两人大作业得分 7.8 分。

### 工程文件

工程文件提交一个 `zip` 压缩包，内容分为三部分，比特流文件、工程文件、参考工程。

```
组长学号_小组名_proj.zip/ # 用一个zip打包
├── yyy.bit # Bitstream 文件
├── Project # 你的工程文件
    ├── xxx.srcs/
    ├── xxx.xpr
    └── ...
└── Ref # 你的参考工程，如果没有可删除此部分
    └── ...
```

提交时命名为 `组长学号_小组名_proj.zip`，压缩包不宜超过 50MB，特殊情况请先联系助教。

#### 比特流文件

在 Generate Bitstream 成功后，通常能在工程目录下 `xxx.runs/impl_1/` 中找到 `yyy.bit`，其中 xxx 为工程名，yyy 为顶层模块名。

#### 工程文件

Vivado 工程通常会保留很多缓存文件以及生成的报告或比特流文件，工程较大，提交前需要对工程进行“重置”删除大部分缓存文件。

!!! warning "请注意"
    在进行“重置”之前请拷贝一份原工程，以免出现问题。在进行此步前，请先保存下来比特流文件。

进入 Vivado 界面，在下方找到 `Tcl Console`，在控制台内输入 `reset_project` 并回车，就完成了工程的重置。

#### 参考工程

在[设计报告](#design-report)中提到的参考工程，如果在网络上不可见，则应添加到此处。如果参考工程为 Vivado 工程，也请执行上述“重置”步骤。

### 演示视频

请演示你的成果并进行操作说明，拍摄成视频提交。你可以用各种常用的视频格式提交，不宜超过 300MB。