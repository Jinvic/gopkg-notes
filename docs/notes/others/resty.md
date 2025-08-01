# resty

`resty.dev/v3`
`github.com/go-resty/resty/v2`

`resty`这个库正在进行`v3`版本的开发，其中包括较多破坏性变动。为了业务稳定性，目前还是用的v2。如果是个人使用，可以直接试试v3。

## 基础

```go
// 声明客户端
client := resty.New()

// 调试模式
client.SetDebug(true)
```

## 查询参数

**key-value**:

```go
c.R().
    SetQueryParam("search", "kitchen papers").
    SetQueryParam("size", "large").
    Get("/search")

// Result:
//     /search?search=kitchen%20papers&size=large
```

**map[string]string**:

```go
c.R().
    SetQueryParams(map[string]string{
      "search": "kitchen papers",
      "size": "large",
    }).
    Get("/search")

// Result:
//     /search?search=kitchen%20papers&size=large
```

**url.Values**:

```go
c.R().
    SetQueryParamsFromValues(url.Values{
        "status": []string{"pending", "approved", "open"},
    }).
    Get("/search")
// Result:
//     /search?status=pending&status=approved&status=open
```

**query string**:

```go
c.R().
    SetQueryString("productId=232&template=fresh-sample&cat=resty&source=google&kw=buy a lot more").
    Get("/search")

// Result:
//     /search?cat=resty&kw=buy+a+lot+more&productId=232&source=google&template=fresh-sample
```

## 表单参数

**map[string]string**:

```go
client.R().
    SetFormData(map[string]string{
        "access_token": "BC594900-518B-4F7E-AC75-BD37F019E08F",
        "user_id": "3455454545",
    })
```

**url.values**:

```go
client.R().
    SetFormDataFromValues(url.Values{
        "search_criteria": []string{"book", "glass", "pencil"},
    })
```

## 路径参数

resty使用类似模板的形式构建路径参数。
也可以使用go自带的类似方法（如`fmt.Sprintf(template,value)`）来构建路径。

**key-value**:

```go
c.R().
    SetPathParam("userId", "sample@sample.com").
    Get("/v1/users/{userId}/details")

// Result:
//     /v1/users/sample@sample.com/details
```

**map[string]string**:

```go
c.R().
    SetPathParams(map[string]string{
        "userId":       "sample@sample.com",
        "subAccountId": "100002",
        "path":         "groups/developers",
    }).
    Get("/v1/users/{userId}/{subAccountId}/{path}/details")

// Result:
//   /v1/users/sample@sample.com/100002/groups%2Fdevelopers/details
```

## 请求体类型

**struct & map[string]string**:

对于结构化请求体，将自动转换为`application/json`。

```go
res, err := client.R().
    SetBody(User{
        Username: "testuser",
        Password: "testpass",
    }). // default request content type is JSON
    SetResult(&LoginResponse{}). // or SetResult(LoginResponse{}).
    SetError(&LoginError{}).     // or SetError(LoginError{}).
    Post("https://myapp.com/login")

res, err := client.R().
    SetBody(map[string]string{
        "username": "testuser",
        "password": "testpass",
    }). // default request content type is JSON
    SetResult(&LoginResponse{}). // or SetResult(LoginResponse{}).
    SetError(&LoginError{}).     // or SetError(LoginError{}).
    Post("https://myapp.com/login")
```

**string & btyes**:

对于字符串/字节串，需要手动设置类型。

```go
res, err := client.R().
    SetContentType("application/json").
    SetBody(`{"username":"testuser", "password":"testpass"}`).
    SetResult(&LoginResponse{}). // or SetResult(LoginResponse{}).
    SetError(&LoginError{}).     // or SetError(LoginError{}).
    Post("https://myapp.com/login")

res, err := client.R().
    SetContentType("application/json").
    SetBody([]byte(`{"username":"testuser", "password":"testpass"}`)).
    SetResult(&LoginResponse{}). // or SetResult(LoginResponse{}).
    SetError(&LoginError{}).     // or SetError(LoginError{}).
    Post("https://myapp.com/login")
```

## 响应解析

Resty 可以使用 `Request.SetResult` 和 `Request.SetError` 方法， 根据响应头 `Content-Type` 自动对 `JSON` 和 `XML` 进行反序列化。

```go
res, err := client.R().
    SetBody(User{
        Username: "testuser",
        Password: "testpass",
    }). // default request content-type is JSON
    SetResult(&LoginResponse{}).
    SetError(&LoginError{}).
    Post("https://myapp.com/login")

fmt.Println(err)
fmt.Println(res.Result().(*LoginResponse))
fmt.Println(res.Error().(*LoginError))  
```
