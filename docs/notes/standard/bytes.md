# bytes

## buffer

**参考**：

- [看完这篇文章，你就会知道 Go 中 Buffer 到底有什么用 - 掘金](https://juejin.cn/post/7229193250903507004)

在计算机科学中，缓冲区（Buffer）是一种数据结构，它用于临时存储数据，以便稍后进行处理。在 Go 语言中，bytes.Buffer 是一个预定义的类型，用于存储和操作字节序列。

### 创建缓冲区

```go
// with initialization.
func NewBuffer(buf []byte) *Buffer
func NewBufferString(s string) *Buffer

// without initialization.
var b bytes.Buffer 
```

### 写入缓冲区

```go
func (b *Buffer) Write(p []byte) (n int, err error)
func (b *Buffer) WriteByte(c byte) error // 单个字节
func (b *Buffer) WriteRune(r rune) (n int, err error) // 单个 Unicode 字符
func (b *Buffer) WriteString(s string) (n int, err error) // 字符串
func (b *Buffer) ReadFrom(r io.Reader) (n int64, err error) // io.Reader
```

### 从缓冲区读取

```go
func (b *Buffer) Read(p []byte) (n int, err error)
func (b *Buffer) ReadByte() (byte, error)
func (b *Buffer) ReadBytes(delim byte) (line []byte, err error)
func (b *Buffer) ReadRune() (r rune, size int, err error)
func (b *Buffer) ReadString(delim byte) (line string, err error)
func (b *Buffer) WriteTo(w io.Writer) (n int64, err error)
```

### 其他

```go
// 截取缓冲区
func (b *Buffer) Truncate(n int) 
// 扩容缓冲区
func (b *Buffer) Grow(n int) 
// 重置缓冲区
func (b *Buffer) Reset() 
```

### 序列化和反序列化

以json为例：

```go
type Person struct {
    Name string
    Age  int
}
​
// 将结构体编码为 JSON
p := Person{"Alice", 25}
enc := json.NewEncoder(&buf)
enc.Encode(p)
fmt.Println(buf.String()) // 输出：{"Name":"Alice","Age":25}
​
// 从 JSON 解码为结构体
var p2 Person
dec := json.NewDecoder(&buf)
dec.Decode(&p2)
fmt.Printf("Name: %s, Age: %d\n", p2.Name, p2.Age) // 输出：Name: Alice, Age: 25
```

### 应用场景

- 网络通信
- 文件操作
- 二进制数据处理
- 字符串拼接
- 格式化输出
- 图像处理
