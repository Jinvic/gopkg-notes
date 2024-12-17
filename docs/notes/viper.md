# viper

[viper](https://github.com/spf13/viper)

[Golang中文学习文档](https://golang.halfiisland.com/community/pkgs/config/Viper.html)

基本用法如下：

## 设置默认值

`viper.SetDefault(key,value)`

## 读取配置文件

```go
viper.SetConfigName("config.yml") // 读取名为config的配置文件，没有设置特定的文件后缀名
viper.SetConfigType("yaml")       // 当没有设置特定的文件后缀名时，必须要指定文件类型
viper.AddConfigPath("./")         // 在当前文件夹下寻找
viper.AddConfigPath("$HOME/")     // 使用变量
viper.AddConfigPath(".")          // 在工作目录下查找
err := viper.ReadInConfig() //读取配置
```

## 访问配置方法

- `Get(key string) : interface{}`
- `GetBool(key string) : bool`
- `GetFloat64(key string) : float64`
- `GetInt(key string) : int`
- `GetIntSlice(key string) : []int`
- `GetString(key string) : string`
- `GetStringMap(key string) : map[string]interface{}`
- `GetStringMapString(key string) : map[string]string`
- `GetStringSlice(key string) : []string`
- `GetTime(key string) : time.Time`
- `GetDuration(key string) : time.Duration`
- `IsSet(key string) : bool`
- `AllSettings() : map[string]interface{}`

当访问嵌套配置的时候通过.分隔符进行访问，例如`GetString("server.database.url")`。

进阶用法详见文档。
