# lumberjack

`github.com/natefinch/lumberjack`

## 配置项

```go
type Logger struct {
    // Filename is the file to write logs to.  Backup log files will be retained
    // in the same directory.  It uses <processname>-lumberjack.log in
    // os.TempDir() if empty.
    Filename string `json:"filename" yaml:"filename"`

    // MaxSize is the maximum size in megabytes of the log file before it gets
    // rotated. It defaults to 100 megabytes.
    MaxSize int `json:"maxsize" yaml:"maxsize"`

    // MaxAge is the maximum number of days to retain old log files based on the
    // timestamp encoded in their filename.  Note that a day is defined as 24
    // hours and may not exactly correspond to calendar days due to daylight
    // savings, leap seconds, etc. The default is not to remove old log files
    // based on age.
    MaxAge int `json:"maxage" yaml:"maxage"`

    // MaxBackups is the maximum number of old log files to retain.  The default
    // is to retain all old log files (though MaxAge may still cause them to get
    // deleted.)
    MaxBackups int `json:"maxbackups" yaml:"maxbackups"`

    // LocalTime determines if the time used for formatting the timestamps in
    // backup files is the computer's local time.  The default is to use UTC
    // time.
    LocalTime bool `json:"localtime" yaml:"localtime"`

    // Compress determines if the rotated log files should be compressed
    // using gzip. The default is not to perform compression.
    Compress bool `json:"compress" yaml:"compress"`
    // contains filtered or unexported fields
}
```

- `Filename`
- `MaxSize` 日志文件最大大小
- `MaxAge` 日志文件最大保存时间
- `MaxBackups` 日志文件最大备份数
- `Compress` 是否压缩日志文件
- `LocalTime` 是否使用本地时间

## 用法

通过`lumberjack.Logger`得到一个`io.writer`接口，再作为各个日志库的输出。

```go
writer := &lumberjack.Logger{
    Filename:   "/var/log/myapp/foo.log",
    MaxSize:    500, // megabytes
    MaxBackups: 3,
    MaxAge:     28, //days
    Compress:   true, // disabled by default
}

// log
log.SetOutput(writer)

// slog
logger := slog.New(slog.NewJSONHandler(writer, &slog.HandlerOptions{Level: slog.LevelInfo}))

```
