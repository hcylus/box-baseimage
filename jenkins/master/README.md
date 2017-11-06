# 更新jenkins_home目录权限

```bash
chcon -Rt svirt_sandbox_file_t ./jenkins_home
```

# jenkins 账号

默认账号admin/admin123

# 如何获取插件列表

```bash
.bin/get_plugins.sh > plugins.txt
```
