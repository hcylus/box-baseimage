# 脚本.bin/docker-build.sh使用说明

## 参数说明

| 参数  | 说明 |
|------|------|
| --base-image | 更新Dockerfile.template中的FROM指令，比如jenkins/abs/Dockerfile.template |
| --image-version | 当没有设置此参数是，会使用workdir目录下的VERSION文件内容作为版本号，反之，使用此参数 |

## 样例
```bash
# 构建centos7基础镜像
.bin/docker-build.sh base/centos7
.bin/docker-build.sh jdk/
.bin/docker-build.sh jenkins/slave
.bin/docker-build.sh jenkins/ssh-slave
.bin/docker-build.sh --base-image hub.opstack.xyz/jenkins/swarm:1.0.0 \
  --image-version 1.0.0-swarn jenkins/abs
```
**构建结果**
```
[root@k8s-master _docker]# docker images
REPOSITORY                            TAG                 IMAGE ID            CREATED             SIZE
jenkins/swarm-slave   1.0.0               b9ba2351ba66        8 minutes ago       687.8 MB
jenkins/ssh-slave     1.0.0               839fb84fbf04        38 minutes ago      709.4 MB
jenkins/slave         1.0.0               36363d9a12a2        40 minutes ago      686.2 MB
core/jdk              1.8.0               82d51ba53ffa        41 minutes ago      685.9 MB
core/centos           7.3.1611            1c136db5189c        5 days ago          298.9 MB
```

# 脚本.bin/docker-rmi.sh 使用

用于清理无用images

# 脚本.bin/docker-run.sh 使用

# docker image list

1. core
2. jenkins
3. apps
