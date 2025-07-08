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

## 命令示例

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

- `Use`: 具体命令
- `Short`: 简短介绍
- `Long`: 详细介绍
- `Run`: 具体逻辑
