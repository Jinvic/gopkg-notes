# flag

## 参考

- [flag | Golang 中文学习文档](https://golang.halfiisland.com/essential/std/flag.html)

## 用法

```go
name := flag.String("name", "张三", "姓名")
age := flag.Int("age", 15, "年龄")
sex := flag.Bool("sex", true, "性别")
```

```go
var name string
var age int
var sex bool
flag.StringVar(&name, "name", "张三", "姓名")
flag.IntVar(&age, "age", 15, "年龄")
flag.BoolVar(&sex, "sex", true, "性别")
```

```go
func Args() []string //返回所有非命令参数

func NArg() int //返回非命令行参数的个数

func NFlag() int //返回命令行参数的个数
```

## 示例

```go
package main

import (
    "flag"
)

func main() {
    var name string
    var age int
    var sex bool
    flag.StringVar(&name, "name", "张三", "姓名")
    flag.IntVar(&age, "age", 15, "年龄")
    flag.BoolVar(&sex, "sex", true, "性别")

    flag.Parse()
    fmt.Println(name, age, sex)
}
```

```pwsh
PS D:\WorkSpace\Code\GoProject\bin> .\main.exe
张三 15 true
PS D:\WorkSpace\Code\GoProject\bin> .\main.exe -h
Usage of D:\WorkSpace\Code\GoProject\bin\main.exe:
  -age int
        年龄 (default 15)
  -name string
        姓名 (default "张三")
  -sex
        性别 (default true)
PS D:\WorkSpace\Code\GoProject\bin> .\main.exe -age 15 -name "李四" -sex=false
李四 15 false
```
