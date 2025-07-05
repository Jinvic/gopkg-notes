# zip

[zip](https://pkg.go.dev/archive/zip)

压缩解压,go的标准库

## 解压

使用`reader,err := zip.OpenReader(path)`打开压缩包，之后遍历`_, file := range reader.File`，就可以正常使用文件句柄file。如果需要解压文件出来，就新建文件后复制过去。

## 压缩

首先新建空文件，用`zipWriter, err := zip.NewWriter(path)`方法打开。对需要压缩的文件，打开后用`info, err := file.Stat()`方法获取文件信息，`header, err := zip.FileInfoHeader(info)`方法转换成文件头，`fileWriter, err := zipWriter.CreateWriter(header)`方法转换成压缩包内的写入接口，最后`io.Copy(fileWriter, file)`复制文件进去。
