# Portainer CE Docker Compose

Portainer CE (Community Edition) 是一个轻量级的Docker管理界面，可以帮助您轻松管理Docker容器、镜像、网络和卷。

## 功能特性

- 🐳 Docker容器管理
- 📦 镜像管理
- 🌐 网络配置
- 💾 数据卷管理
- 👥 用户和团队管理
- 📊 资源监控
- 🔒 安全配置
- 🌍 多主机管理（通过Agent）

## 快速启动

### 1. 创建数据目录

```bash
mkdir -p ./data
```

### 2. 启动 Portainer

```bash
# 启动主服务
docker-compose up -d

# 或者同时启动Agent服务
docker-compose --profile agent up -d
```

### 3. 访问界面

打开浏览器访问：`http://localhost:9000`

首次访问时需要：
1. 设置管理员用户名和密码
2. 选择管理环境（本地Docker或远程）

## 配置说明

### 端口配置

- `9000`: Portainer Web管理界面
- `8000`: Edge代理端口（用于边缘计算）
- `9001`: Portainer Agent端口（可选）

### 环境变量

- `PORTAINER_ADMIN_PASSWORD_EXPIRY`: 管理员密码过期时间
- `PORTAINER_ENABLE_EDGE_COMPUTE`: 启用边缘计算功能
- `AGENT_CLUSTER_ADDR`: Agent集群地址
- `AGENT_PORT`: Agent服务端口

### 数据持久化

数据存储在 `./data` 目录中，包含：
- 用户配置
- 应用模板
- 设置信息
- 日志文件

## 高级配置

### 1. 启用HTTPS

修改 `docker-compose.yml` 添加SSL证书挂载：

```yaml
volumes:
  - ./certs:/certs:ro
environment:
  - PORTAINER_SSL_CERT=/certs/portainer.crt
  - PORTAINER_SSL_KEY=/certs/portainer.key
ports:
  - "9443:9443"
```

### 2. 自定义网络

可以修改网络配置以适应您的环境：

```yaml
networks:
  portainer_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
```

### 3. 反向代理集成

配置文件已包含Traefik标签，可与反向代理集成：

```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.portainer.rule=Host(`portainer.local`)"
```

## 管理远程Docker主机

### 使用Portainer Agent

1. 在远程主机启动Agent：
   ```bash
   docker-compose --profile agent up -d portainer-agent
   ```

2. 在Portainer界面中添加环境：
   - 选择"Agent"作为环境类型
   - 输入Agent地址：`<远程主机IP>:9001`

### 直接TCP连接

在远程主机启用Docker TCP连接：

```bash
# 编辑Docker daemon配置
sudo systemctl edit docker.service

# 添加TCP监听
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
```

## 常用命令

```bash
# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f portainer

# 重启服务
docker-compose restart

# 更新Portainer
docker-compose pull
docker-compose up -d

# 备份数据
docker run --rm -v portainer_portainer_data:/data -v $(pwd):/backup alpine tar czf /backup/portainer-backup.tar.gz /data

# 恢复数据
docker run --rm -v portainer_portainer_data:/data -v $(pwd):/backup alpine tar xzf /backup/portainer-backup.tar.gz -C /
```

## 安全建议

1. **更改默认端口**: 修改暴露端口以提高安全性
2. **启用HTTPS**: 在生产环境中使用SSL/TLS
3. **限制网络访问**: 使用防火墙限制访问来源
4. **定期更新**: 保持Portainer版本最新
5. **强密码策略**: 设置复杂的管理员密码

## 故障排除

### 常见问题

1. **无法访问9000端口**
   - 检查防火墙设置
   - 确认Docker服务运行正常

2. **Agent连接失败**
   - 检查网络连通性
   - 确认Agent服务启动正常

3. **数据丢失**
   - 检查volume挂载配置
   - 确认./data目录权限正确

### 日志查看

```bash
# Portainer主服务日志
docker-compose logs portainer

# Agent服务日志
docker-compose logs portainer-agent
```

## 许可证

Portainer CE 采用 Zlib 许可证，可免费用于个人和商业用途。

更多信息请访问：https://www.portainer.io/
