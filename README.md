# ZJU-Digital Logic Design Lab 2023

本仓库用来发布《数字逻辑设计》课程实验文档，你可以直接查看[在线文档](https://guahao31.github.io/2023_DD)，或将本仓库拉至本地部署。在校园网环境下，你也可以访问 ZJU Git Pages 上部署的[实验文档](http://3200105455.pages.zjusct.io/2023_dd)以及 ZJU Git 中的[仓库](https://git.zju.edu.cn/3200105455/2023_dd)。

本文档面向对象为 2023-2024 秋冬学期《数字逻辑设计》**刘海风老师**。

本文档的实验工具介绍，实验部分内容和思考题借鉴了《计算机系统》系列课程的实验文档，你可以在他们的 [ZJU git 主页](https://git.zju.edu.cn/zju-sys)上查看相关内容，非常感谢《计算机系统》课程老师与历届助教在课程建设上的努力！

## 如何在本地构建？

本文档使用 [mkdocs](https://www.mkdocs.org/) 构建，并使用了 [material](https://squidfunk.github.io/mkdocs-material/) 第三方主题，你需要在本地依次序安装 [Python](https://python.org)、mkdocs、material 主题。

### Python 安装

官网[安装指导](https://wiki.python.org/moin/BeginnersGuide/Download)已经给出各系统安装方式，根据官网内容安装即可。

### mkdocs、material 主题

均可以通过 [pip](https://pypi.org/project/pip/)（Python 的包管理器） 进行安装。

```bash
$ pip install mkdocs
$ pip install mkdocs-material
```

具体地，你可以分别查看 [mkdocs 的安装指导](https://www.mkdocs.org/getting-started/#installation) 与 [material 的安装指导](https://squidfunk.github.io/mkdocs-material/getting-started/#installation)。

### 本地构建

你只需要将本仓库拉至本地，后使用 `mkdocs serve` 部署即可。

```bash
# 拉取仓库，两者皆可
$ git clone git@github.com:Guahao31/2023_DD.git
$ git clone https://github.com/Guahao31/2023_DD.git
# 构建
$ cd ./2023_DD
$ mkdocs serve
```

如果你使用本地部署查看文档，请在每次使用前查看并拉取远程仓库的 `main` 分支更新 `git pull`。

请注意，如果你使用本地构建，**需要自行保证使用的是最新版本的实验指导，因为未及时得知版本更新造成的后果自行承担**。

## 如何提建议

本人水平有限，文档难免有错误以及排布不合理之处。

如果你：

* 发现文档有知识性或实践性的错误
* 发现文本中的错别字/格式错误/图片缺失
* 对文档有建议

欢迎提交 Issue 或通过邮箱与我沟通，我的邮箱为 guahao@zju.edu.cn 。

非常期待得到你的反馈！
