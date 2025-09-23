# jwt

[jwt](https://pkg.go.dev/github.com/golang-jwt/jwt/v5)

教程：
[Golang中文学习文档](https://golang.halfiisland.com/community/pkgs/auth/jwt.html)

## JWT结构

在RFC标准中，JWT由`Header` 头部,`Payload` 载荷,`Signature` 签名组成一个字符串，格式就是`header.payload.signature`，这就是一个JWT令牌的标准结构。
头部只是声明一些基本信息，通常由两部分组成，令牌的类型，和签名所使用的加密算法。
JWT的第二部分是载荷部分，主要包含声明(claims)部分，声明部分通常是关于一个实体的数据，比如一个用户。
在获得了编码的头部和编码的载荷部分后，就可以通过头部所指明的签名算法根据前两个部分的内容再加上密钥进行加密签名，所以一旦JWT的内容有任何变化，解密时得到的签名都会不一样。

这里以HMAC对称加密为示例，使用类型[]byte的值用于签名和验证。

## 创建与签名token

`func NewWithClaims(method SigningMethod, claims Claims) *Token`

其中`method`是签名方法，`claims`是载荷部分，返回一个`Token`结构体。

claims可以使用预定义的`jwt.RegisteredClaims`，也可以使用`jwt.MapClaims`快捷定义，本质是一个`map[string]interface{}`。又或者自定义一个Claims结构体，将预定义的`jwt.RegisteredClaims`作为匿名字段嵌入，从而实现扩展。

```go
secret := []byte("my secret")
token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
 "username": "admin",
 "role": "admin",
})
tokenString, err := token.SignedString(secret)
```

## 解析token与错误处理

```go
// 传入token字符串和验证钩子函数，返回值就是一个Token结构体
token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
    // 验证签名算法是否匹配
    if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
        return nil, fmt.Errorf("不匹配的签名算法: %s", token.Header["alg"])
    }
    // 返回验证密钥
    return secret, nil
})

if token.Valid {
    fmt.Println("token合法")
} else if errors.Is(err, jwt.ErrTokenMalformed) {
    fmt.Println("传入的字符串甚至连一个token都不是...")
} else if errors.Is(err, jwt.ErrTokenExpired) || errors.Is(err, jwt.ErrTokenNotValidYet) {
    fmt.Println("token已经过期或者还没有生效")
} else {
    fmt.Println("token处理异常...")
}
```

## 自定义Claim解析

```go
token, err := jwt.ParseWithClaims(tokenstring, &MyClaims{}, func(token *jwt.Token) (interface{}, error) {
    return secret, nil
}, jwt.WithValidMethods([]string{"HS256"})) // 使用option进行验证

// 类型断言
if claims, ok := token.Claims.(*MyClaims); ok && token.Valid {
    fmt.Println(claims)
} else {
    fmt.Println(err)
}
```

**注意**：使用自定义Claim需要定义一系列方法来实现`jwt.Claims`接口。
