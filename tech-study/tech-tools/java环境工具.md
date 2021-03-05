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

## Git 安装

```shell
yum install git
git version
```

![image-20210303183416294](D:\file\md_file\guopop.github.io\images\image-20210303183416294.png)

