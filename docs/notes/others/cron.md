# cron

`github.com/robfig/cron/v3`

`robfig/cron`是一个很实用的定时任务库，cron表达式也有学习价值。

关于cron表达式，有Linux的cron工具的标准格式，以及Quartz的格式。在v3版本中使用的是标准格式。详见[wiki](https://en.wikipedia.org/wiki/Cron)。当然，也可以通过自定义解析器的方式实现其他格式。

Field name   | Mandatory? | Allowed values  | Allowed special characters
----------   | ---------- | --------------  | --------------------------
Minutes      | Yes        | 0-59            | * / , -
Hours        | Yes        | 0-23            | * / , -
Day of month | Yes        | 1-31            | * / , - ?
Month        | Yes        | 1-12 or JAN-DEC | * / , -
Day of week  | Yes        | 0-6 or SUN-SAT  | * / , - ?

```bash
  * * * * * <command to execute>
# | | | | |
# | | | | day of the week (0–6) (Sunday to Saturday; 
# | | | month (1–12)             7 is also Sunday on some systems)
# | | day of the month (1–31)
# | hour (0–23)
# minute (0–59)
```

如果不确定自己的表达式的正确性，可以找一个相关的cron解析器，或者询问LLM等。

cron库的使用很简单，如下是一个简单的工程化示例，包括并发控制和手动触发等，可以按这个格式集成到项目中。

```go
// schedule.go

var (
    Cron *cron.Cron
    mu   sync.Map
)

func init() {
    Cron = cron.New()
    AddSchedules()
    Cron.Start()
}

// 添加定时任务
func AddSchedules() {
    // 每年12月1日0点0分0秒执行
    _, err := Cron.AddFunc("0 0 1 12 *", func() {
        err := YearlyCreateTableSchedule()
        if err != nil {
            global.Log.Error("YearlyCreateTableSchedule", zap.Error(err))
        }
    })
    if err != nil {
        global.Log.Error("AddSchedules", zap.Error(err))
    }
}

// 具体的定时任务
func YearlyCreateTableSchedule() error {
    // 并发控制
    mu, _ := mu.LoadOrStore("YearlyCreateTableSchedule", &sync.Mutex{})
    mutex := mu.(*sync.Mutex)
    mutex.Lock()
    defer mutex.Unlock()

    year := time.Now().Year()
    err := user_info.CreateTable(year)
    if err != nil {
        return err
    }
    return nil
}

// 可选：手动启动定时任务
func StartScheduleManually(scheduleName string) error {
    switch scheduleName {
    case "YearlyCreateTableSchedule":
        err := YearlyCreateTableSchedule()
        if err != nil {
            return err
        }
    }
    return nil
}

// main.go

func main() {
    defer schedule.Cron.Stop()
}

```
