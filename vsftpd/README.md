# Use Cases

1. 创建一个临时的容器
```bash
docker run --rm -it core/vsftpd:1.0.0
```

2. 自定义用户列表和权限、目录等，并挂在目录
```bash
mkdir -p config
cp data/config/vusers.json config/vusers.json
chown -F ftp:ftp !$
docker run -d -p 20-21:20-21 -p 21100-21110:21100-21110 \
  --name vsftpd --restart=always -v `pwd`/ftpdata:/home/ftp \
  -v `pwd`/data/config/vusers.json:/config/vusers.json core/vsftpd:1.0.0

docker run --rm -it -p 20-21:20-21 -p 21100-21110:21100-21110 \
  --name vsftpd core/vsftpd:1.0.0

# test 
docker run --rm -it -v `pwd`/testdata:/testdata core/vsftpd:1.0.0 lftp ftp://admin@127.0.0.1

# update vusers.json
docker exec -it vsftpd vsftpd_vusers.sh

```
