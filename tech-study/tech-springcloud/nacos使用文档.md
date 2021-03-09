# Nacos使用文档

## 什么是Nacos

Nacos 致力于帮助您发现、配置和管理微服务。Nacos 提供了一组简单易用的特性集，帮助您快速实现动态服务发现、服务配置、服务元数据及流量管理。

Nacos 帮助您更敏捷和容易地构建、交付和管理微服务平台。 Nacos 是构建以“服务”为中心的现代应用架构 (例如微服务范式、云原生范式) 的服务基础设施。



![nacos_map](https://guopop.oss-cn-beijing.aliyuncs.com/img/nacosMap.jpg)

## docker 部署nacos

```sh
docker pull nacos/nacos-server
docker run -d -p 8848:8848 --env MODE=standalone  --name nacos  nacos/nacos-server
```

访问http://localhost:8848/nacos  登录成功 nacos/nacos

## nacos config 配置

![image-20210309183018638](https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210309183018638.png)

![image-20210309183131090](D:\file\md_file\guopop.github.io\images\image-20210309183131090.png)

![image-20210309183152020](D:\file\md_file\guopop.github.io\images\image-20210309183152020.png)

新建bootstrap.yml文件

```yaml
spring:
  application:
    name: nacos-config
  cloud:
    nacos:
      config:
        server-addr: 39.105.47.81:8848
        file-extension: yml
```

```java
package me.guopop.nacosconfig;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.annotation.PostConstruct;

@Slf4j
@SpringBootApplication
public class NacosConfigApplication {

	@Value("${user.name}")
	private String userName;

	@Value("${user.age}")
	private int userAge;

	@PostConstruct
	public void init() {
		log.info("[init] user name: {}, age: {}", userName, userAge);
	}

	public static void main(String[] args) {
		SpringApplication.run(NacosConfigApplication.class, args);
	}
}
```

启动应用

![image-20210309183316429](D:\file\md_file\guopop.github.io\images\image-20210309183316429.png)

配置成功！！！