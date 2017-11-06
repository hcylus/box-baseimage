# 容器构建

修改shadowsocks/ssclient/shadowsocks.json
```json
{
    "server":"SERVER-IP",           # 你的服务器ip
    "server_port":PORT,             # 服务器端口
    "local_address": "127.0.0.1",   # 若想其它机器可访问，设置为0.0.0.0
    "local_port":1080,              # sock端口
    "password":"PASSWORD",          # 密码
    "timeout":300,
    "method":"aes-256-cfb"          # 加密方式
}
```
构建容器
```bash
cd _docker
./build.sh shadowsocks/ssclient
```

# 如何部署

## ssserver部署

见ssserver/README.md文件

## ssclient部署

```bash
docker run -d --name ssclient -p 8118:8118 --privileged `cat TAG`:`cat VERSION`
```

# 配置docker服务使用代理

```bash
mkdir -p /usr/lib/systemd/system/docker.service.d
touch /usr/lib/systemd/system/docker.service.d/http-proxy.conf
```
将下面的内容放在/usr/lib/systemd/system/docker.service.d/http-proxy.conf文件中
```ini
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:8118/" "NO_PROXY=localhost,127.0.0.1,gj7l88s1.mirror.aliyuncs.com,docker.io,registry.cn-hangzhou.aliyuncs.com,acs-cn-hangzhou-mirror.oss-cn-hangzhou.aliyuncs.com"
```
NO_PROXY可让其他镜像继续使用阿里云加速。

重启docker服务

```bash
systemctl daemon-reload
systemctl restart docker
```

拉去镜像测试
```bash
docker pull gcr.io/google_containers/pause:3.0
```

或者使用
```bash
curl --proxy http://localhost:8118/ http://ifconfig.es
```
