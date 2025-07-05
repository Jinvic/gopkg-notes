# zap

- [zap](https://github.com/uber-go/zap)
- [Golang中文学习文档](https://golang.halfiisland.com/community/pkgs/logs/Zap.html)
- [Go语言中文文档](https://www.topgoer.com/%E9%A1%B9%E7%9B%AE/log/ZapLogger.html)
第二个教程更好理解。

zap有sugar和logger两种写法。sugar支持printf风格但性能相对较低。这里以logger为例。

## 快速入门

```go
logger, err := zap.NewProduction()
if err != nil {
 log.Fatalf("Error creating logger: %v", err)
}
defer logger.Sync() 
```

这样就创建了一个最基础的logger，把日志写入到标准输出。语法如下：
`func (log *Logger) MethodXXX(msg string, fields ...Field)`
MethodXXX是方法名,即Info/Error/Debug/Panic等，msg是日志内容，fields是一些额外的信息，比如时间戳、日志级别、错误信息等。每个zapcore.Field其实就是一组键值对参数。

## 高级配置

可以通过`zap.New(core)`方法自定义配置，需要先创建一个core。

```go
core := zapcore.NewCore(encoder, writer, level)
logger := zap.New(core)
```

`encoder`：编码器(如何写入日志)
`writer`：指定日志将写入的地方
`level`：指定日志级别

JSON Encoder：`zapcore.NewJSONEncoder(zap.NewProductionEncoderConfig())`
Console Encoder：`zapcore.NewConsoleEncoder(zap.NewProductionEncoderConfig())`

写入文件：`zapcore.AddSync(file)`
多重写入：`zapcore.NewMultiWriteSyncer(zapcore.AddSync(os.Stdout), zapcore.AddSync(file))`

level使用默认值就行 `zapcore.InfoLevel`
