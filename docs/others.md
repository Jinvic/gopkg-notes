# 其他

## gin-contrib/sessions

- [Golang中文学习文档](https://golang.halfiisland.com/community/pkgs/web/gin.html#session)
- [Gin 框架之Cookie与Session](https://cloud.tencent.com/developer/article/2381258)

## go-resty/resty/v2

restful http 客户端

- [Go 每日一库之 resty](https://darjun.github.io/2021/06/26/godailylib/resty/)

## asaskevich/govalidator

验证器

- [Go每日一库之82：govalidator](https://juejin.cn/post/7289249524325711908)

## go-playground/validator/v10

另一个验证器，刚开始把这两个搞混了。

gin 框架的默认验证器

- [Validator | Go中文学习文档](https://golang.halfiisland.com/community/pkgs/validate/Validator.html)
- [Go 验证器 validator 详解](https://learnku.com/articles/78391)

## logrus

- [logrus](https://github.com/sirupsen/logrus)

日志库。

## casbin

- [casbin](https://casbin.org/docs/overview)

认证鉴权。

## GUI

还没决定学哪个包。

### fyne

[fyne](https://github.com/fyne-io/fyne)

Go跨平台GUI工具包
看起来很不错，大概会选择这个包。

### Gio UI

[gio](https://gioui.org/)

听说不错但是文档太少了，而且没有中文文档，看起来比较劝退。

### govcl

[govcl](https://github.com/ying32/govcl)

中文支持很好，但star数太少。

### andlabs/ui

[andlabs/ui](https://github.com/andlabs/ui)

应该是个比较轻量的包，有空看看。

## Andoroid

### avast/apkverifier

[apkverifier](https://pkg.go.dev/github.com/avast/apkverifier)

用的这个

[apksign](https://pkg.go.dev/github.com/morrildl/playground-android/apksign)

犄角旮旯里翻出来的，没用过，记一下

[test-apks](https://github.com/obfusk/test-apks/tree/master)

测试用的安装包

## 静态检查

### staticcheck

[staticcheck](https://github.com/dominikh/go-tools)

### golangci-lint

[golangci-lint](https://github.com/golangci/golangci-lint)

### NilAway

[NilAway](https://github.com/uber-go/nilaway)

## 命令行工具

### go-blueprint

- [go-blueprint](https://github.com/Melkeydev/go-blueprint)

> 快速生成 Go Web 项目结构的工具。这是一个用于快速搭建 Go 语言 Web 项目的命令行工具，集成了 Chi、Gin、Fiber、Echo 等多种流行的 Go 框架。它支持选择 MySQL、Postgres、Redis 等主流数据库，还提供了 WebSocket 和 Docker 等高级设置。用户只需选择技术栈，即可生成一套完整的 Go Web 项目架子。

## 懒得分类

### go-sail

`github.com/keepchen/go-sail`

一个轻量的渐进式web框架，使用Go语言实现。内置集成了多种常见的组件。
新框架，观望一下。

### Goh

`github.com/OblivionOcean/Goh`

项目说明：一款Go语言的预编译快速模板引擎。

## TODO LIST

### samber

`github.com/samber/lo`
`github.com/samber/do`
`github.com/samber/mo`

samber的这几个包都很实用，而且命名也很有意思，有空研究一下。

### gofakeit

`github.com/brianvoe/gofakeit`

批量生产假数据

### go-linq

`github.com/ahmetb/go-linq/v3`

language integrated query (LINQ) 语言集成查询
可以像sql一样查询可迭代的数据结构

### sync

`sync`

标准库，实现了基础的同步原语，有空多看看。

`golang.org/x/sync/errgroup`

对 `sync.WaitGroup` 的封装，额外提供错误返回功能。

`golang.org/x/sync/singleflight`

合并相同请求，降低查询数据库次数。

### robfig/cron

`github.com/robfig/cron/v3`

很实用的定时任务库，cron表达式也有学习价值。
