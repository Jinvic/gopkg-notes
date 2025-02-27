# go-playground/validator

- [Validator | Go中文学习文档](https://golang.halfiisland.com/community/pkgs/validate/Validator.html)

Gin框架的默认验证器。单独使用时标签为`validate`,在gin框架中标签为`binding`。格式为：`validate:"tag1=value1,tag2=value2 value3,..."`。

将所有验证项列一边也不现实，记一下常用的一些：

## 常用

| Tag                    |Description|
| -                      | :-|
| `dir`                  | 文件目录|
| `file`                 | 文件路径  |
| `isdefault`            | 验证当前字段的值是否是默认静态值|
| `len`                  | 字段长度|
| `max`                  | 最大值|
| `min`                  | 最小值|
| `oneof`                | 是否是列举的值的其中的一个|
| `oimtempty`            | 如果字段未设置，则忽略它|
| `required`            | 必须值|
| `unique`              | 验证每个`arr \| map \| slice` 值是否唯一 |

关于`required`，还有各种条件衍生，以及相反的`excluded`条件衍生，具体查文档。

### 比较

| Tag   | Description |
| ----- | ----------- |
| `eq`  | 等于        |
| `gt` | 大于        |
| `gte` | 大于等于    |
| `lt`  | 小于        |
| `lte` | 小于等于    |
| `ne`  | 不等于      |

处理直接于具体值比较，还可以加上`field`与其他字段比较，具体见文档。

此外还有多维域验证，自定义别名及验证函数等知识点，以后等用到再展开。
