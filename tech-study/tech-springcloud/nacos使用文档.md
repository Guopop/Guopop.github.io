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

## Nacos Config 入门配置

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

## Nacos Config 实现 Bean 动态刷新

### @RefreshScope + @Value实现

```java
package me.guopop.nacosconfig;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;

@RestController
@RefreshScope
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

	@GetMapping("/user")
	public String user() {
		return String.format("[HTTP] user name: %s, age: %d", userName, userAge);
	}

	public static void main(String[] args) {
		SpringApplication.run(NacosConfigApplication.class, args);
	}
}
```

访问http://localhost:8080/user

![image-20210310171642356](https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210310171642356.png)

![image-20210310171711037](https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210310171711037.png)

修改配置，进行发布

![image-20210310171736908](https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210310171736908.png)

![image-20210310171803104](D:\file\md_file\guopop.github.io\images\image-20210310171803104.png)

数据得到刷新

### @RefreshScope + @ConfigurationProperties 实现

```java
package me.guopop.nacosconfig;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;

/**
 * @author guopop
 * @date 2021/3/10 17:26
 */
@Getter
@Setter
@RefreshScope
@ConfigurationProperties(prefix = "user")
public class User {
    private String name;

    private int age;

    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}
```

```java
package me.guopop.nacosconfig;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

@EnableConfigurationProperties(User.class)
@RestController
@RefreshScope
@Slf4j
@SpringBootApplication
public class NacosConfigApplication {

	@Value("${user.name}")
	private String userName;

	@Value("${user.age}")
	private int userAge;

	@Autowired
	private User user;

	@PostConstruct
	public void init() {
		log.info("[init] user name: {}, age: {}", userName, userAge);
	}

	@PreDestroy
	public void destroy() {
		log.info("[destroy] user name: {}, age: {}", userName, userAge);
	}

	@GetMapping("/user")
	public String user() {
//		return String.format("[HTTP] user name: %s, age: %d", userName, userAge);
        return "[HTTP] " + user;
	}

	public static void main(String[] args) {
		SpringApplication.run(NacosConfigApplication.class, args);
	}
}
```

访问http://localhost:8080/user

![image-20210310173553355](D:\file\md_file\guopop.github.io\images\image-20210310173553355.png)

![image-20210310173644947](D:\file\md_file\guopop.github.io\images\image-20210310173644947.png)

修改配置

![image-20210310173655231](D:\file\md_file\guopop.github.io\images\image-20210310173655231.png)

刷新成功！！！



### Nacos Config 监听实现Bean属性动态刷新

