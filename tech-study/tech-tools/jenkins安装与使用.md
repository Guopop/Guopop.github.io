## Jenkins 安装

```shell
mkdir /root/jenkins/data
docker pull jenkinsci/blueocean
docker run --name jenkins -d -p 8881:8080 -p 50000:50000 -v /root/jenkins/data:/var/jenkins_home jenkinsci/blueocean
```



