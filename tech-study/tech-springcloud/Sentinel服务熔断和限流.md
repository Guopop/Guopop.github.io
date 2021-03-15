# Sentinel 服务熔断和限流

我们需要针对突发的流量来进行限制，在尽可能处理 请求的同时来保障服务不被打垮，这就是流量控制。

我们需要对不稳定的弱依赖服务进行 熔断降级，暂时切断不稳定调用，避免局部不稳定因素导致整体的雪崩。

Sentinel 是阿里巴巴开源的，面向分布式服务架构的高可用防护组件，主要以流量为
切入点，从流量控制、流量整形、熔断降级、系统自适应保护、热点防护等多个维度来帮助 开发者保障微服务的稳定性。

![features-of-sentinel](https://github.com/alibaba/Sentinel/raw/master/doc/image/sentinel-features-overview-en.png)

Sentinel 的使用可以分为两个部分:

- 核心库（Java 客户端）：不依赖任何框架/库，能够运行于 Java 7 及以上的版本的运行时环境，同时对 Dubbo / Spring Cloud 等框架也有较好的支持（见 [主流框架适配](https://github.com/alibaba/Sentinel/wiki/主流框架的适配)）。
- 控制台（Dashboard）：控制台主要负责管理推送规则、监控、集群限流分配管理、机器发现等。

## Sentinel Dashboard 安装

```sh
mkdir sentinel
wget https://github.com/alibaba/Sentinel/releases/download/1.8.1/sentinel-dashboard-1.8.1.jar
nohup java -Dserver.port=8010 -Dcsp.sentinel.dashboard.server=localhost:8010 -Dproject.name=sentinel-dashboard -jar sentinel-dashboard-1.8.1.jar &
```

访问http://localhost:8080 账号/密码：sentinel/sentinel

<img src="https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210313103342282.png" alt="image-20210313103342282" style="zoom:50%;" />

安装成功！！！

## Spring Cloud Alibaba 集成 Sentinel

pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<artifactId>data-service</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<name>data-service</name>
	<description>Demo project for Spring Boot</description>

	<parent>
		<groupId>me.guopop</groupId>
		<artifactId>mall</artifactId>
		<version>0.0.1-SNAPSHOT</version>
	</parent>

	<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<dependency>
			<groupId>com.alibaba.cloud</groupId>
			<artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
		</dependency>

		<dependency>
			<groupId>com.alibaba.cloud</groupId>
			<artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
		</dependency>
	</dependencies>

</project>
```

application.yml

```yaml
server:
  port: 8001

spring:
  application:
    name: data-service
  cloud:
    nacos:
      discovery:
        server-addr: 39.105.47.81:8848
        username: nacos
        password: nacos
    sentinel:
      enabled: true
      eager: true
      transport:
        port: 8719
        dashboard: 39.105.47.81:8010
        client-ip: 106.53.248.242
      filter:
        url-patterns: /**
```

> client-ip 为连接sentinel 服务器的服务公网ip

ProductController.java

```java
package me.guopop.data.service;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author guopop
 * @date 2021/3/12 11:26
 */
@RestController
public class ProductController {

    @GetMapping("/hello")
    public String hello() {
        return "hello world!!!!!!";
    }
}
```

启动应用，sentinel与服务连接心跳

访问http://106.53.248.242:8001/hello

访问http://39.105.47.81:8010

<img src="https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210315172715298.png" alt="image-20210315172715298" style="zoom: 50%;" />

sentinel 已经发现sentinel的服务资源

## Sentinel 配置

[Sentinel配置](https://github.com/alibaba/spring-cloud-alibaba/wiki/Sentinel)

## Bug

### 控制台发送心跳包报错

Failed to fetch metric from <http://10.10.2.30:8719/metric?startTime=1615790143000&endTime=1615790149000&refetch=false> (ConnectionException: Connection timed out)

原因：

Sentinel DashBoard 获取的的ip是客户端虚拟网卡ip

解决方法：

```yaml
spring:
    sentinel:
      transport:
        client-ip: 106.53.248.242
```

