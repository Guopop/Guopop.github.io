

## JDK 安装 

```shell
yum install -y java-1.8.0-openjdk-devel
java -version
```

![image-20210303182127658](https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210303182127658.png)

## Maven 安装

```shell
wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
ln -s /opt/apache-maven-3.6.3 /opt/maven
mvn -v
```

![image-20210303182839534](https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210303182839534.png)

[阿里云maven仓库](https://help.aliyun.com/document_detail/102512.html)

```sh
cd /opt/maven/conf
vim settings.xml
```

在<mirrors>标签中添加

```xml
<mirror>
    <id>aliyunmaven</id>
    <mirrorOf>central</mirrorOf>
    <name>阿里云公共仓库</name>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```

## Git 安装

```shell
yum install git
git version
```

![image-20210303183416294](D:\file\md_file\guopop.github.io\images\image-20210303183416294.png)

