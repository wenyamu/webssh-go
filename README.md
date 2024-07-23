# webssh-go
> https://github.com/Jrohy/webssh
> 
## 创建镜像
> 变量名必须大写
>
> `VERSION=1.27` 镜像版本
> 
> `ARCH=amd64` 系统架构，amd64 或 arm64

```sh
docker build \
--build-arg VERSION=1.27 \
--build-arg ARCH=amd64 \
-t my_image:tag .
```

## 或者
> `dpkg --print-architecture` 输出 amd64 或 arm64 或 musl-linux-amd64 或 musl-linux-arm64 等形式的字符串
> 
> `awk -F '-' '{print $NF}'` 以'-'连接符分隔字符串，并返回最后一个值
>
> `echo "musl-linux-amd64" | awk -F '-' '{print $NF}'` 返回 `amd64`
>
> `echo "amd64" | awk -F '-' '{print $NF}'` 也是返回 `amd64`

```sh
docker build \
--build-arg VERSION=1.27 \
--build-arg ARCH=$(echo $(dpkg --print-architecture) | awk -F '-' '{print $NF}') \
-t my_image:tag .
```

## 或者，加上http代理，加速创建镜像
> --build-arg HTTPS_PROXY="http://192.168.1.3:1080" --build-arg HTTP_PROXY="http://192.168.1.3:1080"

```sh
docker build \
--build-arg HTTPS_PROXY="http://192.168.1.3:1080" \
--build-arg HTTP_PROXY="http://192.168.1.3:1080" \
--build-arg VERSION=1.27 \
--build-arg ARCH=$(echo $(dpkg --print-architecture) | awk -F '-' '{print $NF}') \
-t my_image:tag .
```

## 部署
> -e port=5000 指定容器内部监听端口，此变量缺省默认端口为 5032
>
> -e authInfo=user:pass 启用页面登陆验证(用户名:密码)。此变量缺省默认不需要验证
>
> -e savePass=true 启用记住密码功能，此变量缺省默认为 true
```
docker network create --ipv6 ipv6test && \
docker run -itd \
--net ipv6test \
-p 5032:5000 \
-e authInfo=user:pass \
-e port=5000 \
-e savePass=true \
-e TZ=Asia/Shanghai \
--restart always \
--name ws2 \
my_image:tag
```


