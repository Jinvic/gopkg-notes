# gorilla/websocket

`github.com/gorilla/websocket`

[参考](https://cloud.tencent.com/developer/article/2365666)

## Upgrader

`Upgrader`指定用于将 HTTP 连接升级到 WebSocket 连接

```go
type Upgrader struct {
    HandshakeTimeout time.Duration
    ReadBufferSize, WriteBufferSize int
    WriteBufferPool BufferPool
    Subprotocols []string
    Error func(w http.ResponseWriter, r *http.Request, status int, reason error)
    CheckOrigin func(r *http.Request) bool
    EnableCompression bool
}
```

- `HandshakeTimeout：` 握手完成的持续时间
- `ReadBufferSize`和`WriteBufferSize`：以字节为单位指定I/O缓冲区大小。如果缓冲区大小为零，则使用HTTP服务器分配的缓冲区
- `CheckOrigin` ： 函数应仔细验证请求来源 防止跨站点请求伪造

这里一般会设置下CheckOrigin来解决跨域问题,也可以`var upgrader = websocket.Upgrader{} // use default options`使用默认配置。

## Conn

`Conn`类型表示WebSocket连接，这个结构体的组成包括两部分，写入字段（Write fields）和 读取字段（Read  fields）

```go
type Conn struct {
 conn        net.Conn
 isServer    bool
 ...

 // Write fields
 writeBuf      []byte        
 writePool     BufferPool
 writeBufSize  int
 writer        io.WriteCloser 
 isWriting     bool           
 ...
 // Read fields
 readRemaining int64
 readFinal     bool  
 readLength    int64 
 messageReader *messageReader 
 ...
}
```

`isServer` 字段来区分我们是否用Conn作为客户端还是服务端，也就是说说gorilla/websocket中同时编写客户端程序和服务器程序，但是一般是Web应用程序使用单独的前端作为客户端程序。

## 服务端示例

以gin框架为例

### 建立连接

```go
var upgrader = websocket.Upgrader{} // use default options

func main() {
 router := gin.Default()
 router.GET("/ws", func(c *gin.Context) {
  wsHandler(c.Writer, c.Request)
 })
 router.Run("localhost:8080")
}

func wsHandler(w http.ResponseWriter, r *http.Request) {
 //转换为升级为websocket
 conn, err := upGrader.Upgrade(w, r, nil)
 //释放连接
 defer conn.Close()

 for {
  //接收消息
  messageType, message, err := conn.ReadMessage()
  log.Println("server receive messageType", messageType, "message", string(message))
  //发送消息
  err = conn.WriteMessage(messageType, []byte("pong"))
 }
}
```

## 客户端示例

```go
 //服务器地址 websocket 统一使用 ws://
 url := "ws://localhost:8080/ws"
 //使用默认拨号器，向服务器发送连接请求
 conn, _, err := websocket.DefaultDialer.Dial(url, nil)
 //关闭连接
 defer conn.Close()
 //发送消息
 go func() {
  for {
   err := conn.WriteMessage(websocket.BinaryMessage, []byte("ping"))
   time.Sleep(time.Second * 2)
  }
 }()
 //接收消息
 for {
  _, data, err := conn.ReadMessage()
  fmt.Println("client receive message: ", string(data))
 }
```

## 收发消息

```go
for {
    messageType, p, err := conn.ReadMessage()
    if err != nil {
        log.Println(err)
        return
    }
    if err := conn.WriteMessage(messageType, p); err != nil {
        log.Println(err)
        return
    }
}
```

- `messageType`: `int`，消息类型，值为 `websocket.BinaryMessage` 或 `websocket.TextMessage`
- `p`: `[]byte`，消息内容。

也可以使用 `io.Reader` 或 `io.WriteCloser` 收发消息：

```go
for {
    messageType, r, err := conn.NextReader()
    if err != nil {
        return
    }
    w, err := conn.NextWriter(messageType)
    if err != nil {
        return err
    }
    if _, err := io.Copy(w, r); err != nil {
        return err
    }
    if err := w.Close(); err != nil {
        return err
    }
}
```

## 控制消息

```go
func (c *Conn) WriteControl(messageType int, data []byte, deadline time.Time) error

func (c *Conn) SetCloseHandler(h func(code int, text string) error)
func (c *Conn) SetPingHandler(h func(appData string) error)
func (c *Conn) SetPongHandler(h func(appData string) error)
```

也可以正常使用`WriteMessage()`或`NextWriter()`发送控制消息。

控制消息包括`CloseMessage`、`PingMessage` 和 `PongMessage`。

可以通过SetHandler设置接收到控制消息时的回调，示例：

```go
func Ping() {
    conn := GetConn()
    defer conn.Close()

    done := make(chan struct{})

    conn.SetPongHandler(func(appData string) error {
        done <- struct{}{}
        return nil
    })

    conn.WriteMessage(websocket.PingMessage, []byte("ping"))

    go func() {
        conn.ReadMessage()
    }()

    select {
    case <-time.After(time.Second * 5):
        fmt.Println("Server is dead: timeout")
        return
    case <-done:
        fmt.Println("Server is alive")
        return
    }
}
```
