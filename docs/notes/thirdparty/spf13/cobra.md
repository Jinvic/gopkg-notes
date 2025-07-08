# cobra

`github.com/spf13/cobra`

- [官方文档](https://cobra.dev/)
- [项目地址](https://github.com/spf13/cobra)
- [生成工具](https://github.com/spf13/cobra-cli)

> Cobra 是一个 Go 语言的 CLI 框架。它包含一个用于创建强大现代 CLI 应用的库，以及一个用于快速生成基于 Cobra 的应用和命令文件的工具。

快速使用只需要掌握生成工具`cobra-cli`的用法就行。进阶内容以后有需要再学。

## cobra-cli

```bash
# 安装工具
go install github.com/spf13/cobra-cli@latest

# 初始化项目
cobra-cli init

# 添加命令
cobra-cli add serve
cobra-cli add config
cobra-cli add create -p 'configCmd' # 使用 -p 向 config 命令添加子命令
```

项目结构：

```txt
  ▾ app/
    ▾ cmd/
        config.go
        create.go
        serve.go
        root.go
      main.go
```

## 命令定义

```go
package cmd

import (
  "fmt"

  "github.com/spf13/cobra"
)

func init() {
  rootCmd.AddCommand(versionCmd)
}

var versionCmd = &cobra.Command{
  Use:   "version",
  Short: "Print the version number of Hugo",
  Long:  `All software has versions. This is Hugo's`,
  Run: func(cmd *cobra.Command, args []string) {
    fmt.Println("Hugo Static Site Generator v0.9 -- HEAD")
  },
}
```

- `Use`: 使用方法
- `Short`: 简短介绍
- `Long`: 详细介绍
- `Run`: 具体逻辑

## 设置标志

标志同时在命令内使用和init中绑定，所以需要定义为外部变量。

### 解析变量

常用的变量类型有string,int,bool等，有`Var`和`P`两个后缀，其中：

- `Var`: 带Var表示需要传入指针接收值，不带则直接返回值的指针；
- `P`: 带P表示同时指定短名称和长名称，不带则只支持长名称。

以string为例：

```go
func String(name string, value string, usage string) *string
func StringP(name, shorthand string, value string, usage string) *string
func StringVar(p *string, name string, value string, usage string)
func StringVarP(p *string, name, shorthand string, value string, usage string)
```

### 本地和持久化

有两种方式设置标志，分别表示本地和持久化：

- `Flags()`: 本地标志，只在当前命令有效；
- `PersistentFlags()`: 持久化标志，在当前命令及其子命令有效。

示例：

```go
// 本地标志
rootCmd.Flags().StringVarP(&Source, "source", "s", "", "Source directory to read from")
// 持久化标志
rootCmd.PersistentFlags().BoolVarP(&Verbose, "verbose", "v", false, "verbose output")
```

### 必选标志

标志默认是可选的，但也可以通过 `MarkFlagRequired()` 主动声明为必选，当未设置时将报错。示例：

```go
rootCmd.Flags().StringVarP(&Region, "region", "r", "", "AWS region (required)")
rootCmd.MarkFlagRequired("region")
```
