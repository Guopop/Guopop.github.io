# Gitlab 安装与使用

### Docker 安装

```shell
yum update
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
docker -v 
```

<img src="D:\file\md_file\guopop.github.io\images\image-20210227101555647.png" alt="image-20210227101555647"  />

```shell
# 启动docker服务
systemctl start docker
# 开机启动docker服务
systemctl enable docker
```

```sh
# 更换docker阿里源
# https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors 获取源地址
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://yb0l33ts.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```



### Docker Compose 安装

```shell
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

<img src="D:\file\md_file\guopop.github.io\images\image-20210227103924459.png" alt="image-20210227103924459"  />

### Gitlab 安装

```shell
mkdir /root/gitlab 
cd /root/gitlab
vim /root/gitlab/docker-compose.yml
```

```yaml
version: '3' 
services: 
  web: 
    image: 'gitlab/gitlab-ce:latest'
    restart: always 
    hostname: '39.105.47.81' 
    container_name: 'gitlab' 
    environment: 
      GITLAB_OMNIBUS_CONFIG: | 
        external_url 'http://39.105.47.81:8880' 
        gitlab_rails['gitlab_shell_ssh_port'] = 8822 
        gitlab_rails['time_zone'] = 'Asia/Shanghai' 
    ports: 
      - '8880:8880' 
      - '8443:443' 
      - '8822:22' 
    volumes: 
      - '/root/gitlab/config:/etc/gitlab' 
      - '/root/gitlab/logs:/var/log/gitlab' 
      - '/root/gitlab/data:/var/opt/gitlab'
```

```shell
# 安装并启动gitlab
docker-compose up -d
# 查看安装成功
docker ps
```

![image-20210227112704491](D:\file\md_file\guopop.github.io\images\image-20210227112704491.png)

访问http://39.105.47.81:8880/ 即可访问gitlab主页

第一次设置管理员用户名及登录密码

设置中文显示

![image-20210227113419104](D:\file\md_file\guopop.github.io\images\image-20210227113419104.png)