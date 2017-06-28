<meta charset="utf-8">

# 任务相关说明

欢迎加入翻译的队伍！去年的现在还没有翻译完，为了避免这样的情况再次发生，希望能有更多的小伙伴们加入。Swifters of China, unite!

总之大家先 Watch + Star 这个 repository，有兴趣也可以加 QQ 群 277542197。

## 领取任务

1. 每节新内容发布以后，[issue 区](https://github.com/ApolloZhu/Developing-iOS-10-Apps-with-Swift/issues) 会开一个当节的「任务分配」issue。
2. 请到每节的 issue 中评论「翻译」或「校对」。评论的内容包括：
    1. 行数。建议按照 issue 下公布的分段，一般会是 300 或 500 行，也可以自定义，不过为了方便管理，每次至少要求 100 行。
    2. 预计完成时间。我个人的翻译速度是每小时 50 行，请结合个人情况进行估计，建议控制在一个星期以内。海外党请用本地时，并注明时区。
3. 我会结合字幕和您的需求等综合考虑后在 issue 中 @你 通知实际翻译的行数。
4. 请尽快在 issue 下回复 或 发邮件 public-apollonian@outlook.com 或 QQ 群确认。
5. 之后 [看板](https://github.com/ApolloZhu/Developing-iOS-10-Apps-with-Swift/projects/1) 和 issue 顶部添加关于您任务的信息。

**翻译、校对任务的序号不是指字幕文件中行数，而是指**

    67 <----此处的数字
    00:03:04,860 --> 00:03:06,960
    we talked about the NSNumber format and all that.

## 进行翻译

1. 请认真阅读并遵守 [翻译标准／校对规则](./translation-style-guide.md)。
2. 如果忙碌或者有困难一定要及时提出来，我也可以把任务转给其他人。这并不会对您有任何影响，觉得难为情可以邮件/私信我。
3. Fork 本项目到您的账户下，然后 Clone 保存到本地。
4. 如果已经 fork 过了，请通过 sync/update from master/fetch origin 等方式完成同步。
4. 翻译过程中请不要 update from master。
5. 翻译 subtitles 文件夹下对应的 srt 文件的对应“行”。srt 就是普通的文本文件，所以使用的程序只要能够保证保存为同样格式就行，个人便好是 Visual Studio Code。
6. 建议每完成一部分就 commit 一次，这样我们能对进度有个大概的把握。
7. 翻译或校对的过程中有拿不准的地方，请先尝试按照标准里提到的方法解决，也可以进入该节的 issue 中讨论（如这个词该不该翻译，该翻译成什么等）。

## 提交翻译

1. 完成全部翻译后，新建 pull request。
2. 如果有，请注明我们需要特别注意的地方，和其他任务行之外的改动。
2. 我们会进行简单的校对。多半您在主项目的 pull request 下会被拒绝合并，request changes。
3. 请 merge 您 fork 下的 pull request，建议然后再简单地确认一下。
4. merge 并修改（如果有）时，主项目的 pull request 会自动更新。请评论表示可以合并到主分支。
5. 在看到主项目出现一个标题为 `集数_开始行-结束行 翻译 @你` 的 commit 之后就算完成了。如果有需要，这个时候就可以安全地删除 fork 和本地文件了。

----

本规则基于 [github.com/SwiftGGTeam/Developing-iOS-9-Apps-with-Swift/issues/3](https://github.com/SwiftGGTeam/Developing-iOS-9-Apps-with-Swift/issues/3) 修订而成。
