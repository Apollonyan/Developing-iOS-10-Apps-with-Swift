# 翻译指南／校对规则

请大家翻译和校对的时候尽量对照原视频，结合上下文，不要望文生义。

1. 不要合并多条**字幕**！
2. 中英文字幕**开头结尾**均不留空格，以 Unix 样式的 LF 换行
3. 不要在字幕**开头结尾**加上逗号（，）或句号（。）
4. 除了 `[`，`]`，和 `-` 以外使用全角中文标点
5. 保证每一条字幕中最多两行，一行英文一行中文。如果一条字幕中有**多行英文**，请顺手将其合并成一行
6. 修改错别字，明显的笔误，大小写，甚至包括原英文字幕中的错误

## 英文

1. 保证上下文行文连续通顺，便于理解，翻译后的顺序不一定要按照英文顺序。
2. 出现 `Okay?`，`All Right` 等语气词，请结合上下文选择合适的翻译，或省略不翻。
3. 保证不翻译部分大小写的正确规范
	1. 如果想在同时翻译并保留原文，请更具情况选用一下的格式
		2. 用逗号隔开。例：这是 Navigator，导航面板
		3. 用括号补充。例：MVC，即 Model（模型）-View（视图）-Controller（控制器）
	1. 不翻译缩写和一些专有名词，如 MVC，iPhone，Xcode 等
	2. 不翻译翻译后会失真的术语，如 Storyboard
	3. 不翻译直接引用的代码，包括但不限于
		- Swift 语言关键字：如 true，false 等
		- 类／结构体／元组类型的名称：如 UIView，String 等
		- 项目中的代码：如 var description 等
4. 英文同中文之间应当有一个空格。
5. 如遇到英文词汇和标点符号相邻的情况，则不需要再留空格。

例：就算是最新的 iPad，也不能用 Swift Playgrounds 打包应用。

## 术语

翻译术语的时候请参考这个流程：

1. 尽量保证和已翻译的内容一致
2. 参考 [特殊处理](#特殊处理)
3. 参考历年 [iOS 8](https://github.com/X140Yu/Developing_iOS_8_Apps_With_Swift) 和 [iOS 9](https://github.com/SwiftGGTeam/Developing-iOS-9-Apps-with-Swift) 的翻译
4. 参考 [《The Swift Programming Language》中文版](http://gg.swiftguide.cn/) 及其 [术语表](https://github.com/numbbbbb/the-swift-programming-language-in-chinese/issues/62)
5. 参考该术语在其它编程语言中的翻译，可以使用 [微软官方术语搜索](https://www.microsoft.com/Language/zh-cn/Search.aspx) 等搜索引擎。
6. 如果以上都没有找到合适的结果，你可以
	1. 在得到任务分配的 issue 下讨论
	2. 直接使用英文原文
	3. 自己决定一个合适的翻译

后期校对请参考以上标准对术语的使用进行统一。

## 特殊处理

学生提问的部分如果听不清楚，字幕也不全（[INAUDIBLE]），但是老师回答时候把问题复述了一遍，字幕可译为 `-[学生提问]`。

出现 [COUGH]，[LAUGH]，[NOISE]，[BLANK_AUDIO]，[INAUDIBLE] 等，请自行把握，可结合上下文选择省略不翻译。

在非讲师 Paul Hegarty 的对话前，请加 `-` 来区分。如：Question? -Is it ...。

## 后记

> 为何没有完全采用之前的[校对规范](https://github.com/X140Yu/Developing_iOS_8_Apps_With_Swift/blob/master/proofread-rules.md)？

其一是因为确实有些因为 Swift 的更新需要修改的地方。其二是因为即使就像之前规则中说的，*“校对是一个很重要的部分，甚至比翻译还要重要”*，但是如果我们从翻译阶段就能做到统一规范，相信校对也能事半功倍。当然，既然这是新的规范，没经过实践验证，欢迎大家根据实际情况讨论后提出修订意见。
