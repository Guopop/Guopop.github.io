# Spring Cloud Alibaba 与Netflix对比

### Spring Cloud 版本发布规则

Spring Cloud遵循**Pivotal OSS support policy** 协议对**主要版本**提供3年的支持。此外，在Spring Cloud的主要或次要版本发布后，若存在严重的bug和安全问题，就会再维护一段时间（6-12个月不等）。

- **2020.0版本**：（支持Spring Boot 2.4.x）它是**主要版本**，按计划会支持到2023年12月份

​	- 它是自Finchley后的又一主要版本

- **Hoxton版本**：（支持Spring Boot 2.2.x和2.3.x）作为Finchley发行系列的一个次要版本，它的常规维护将持续到2021年6月底。从2020-07开始进入到特殊维护期（不加新功能，只改紧急bug），2021-12月底就只会发布重大错误/安全补丁了
- **Greenwich版本**：（支持Spring Boot 2.1.x）2020-01就停止维护了，2020-12-31号也将终结它的特殊维护期
- **Finchley版本**：（支持Spring Boot 2.0.x）它是一个**主要版本**的开始，2018年发布

![image-20210310155238496](https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210310155238496.png)

### Spring Cloud 2020.0.0 

Spring Cloud 2020.0.0版本**彻底删除**掉了Netflix除Eureka外的**所有**组件

### Spring Cloud Alibaba 替换方案

| 组件          | Spring Cloud Netflix | Spring Cloud Alibaba | Spring Cloud              |
| ------------- | -------------------- | -------------------- | ------------------------- |
| 分布式配置    | Archaius             | Nacos                | Spring Cloud Config       |
| 服务注册/发现 | Eureka               | Nacos                |                           |
| 服务熔断      | Hystrix              | Sentinel             |                           |
| 服务调用      | Feign                | Dubbo RPC            | OpenFeign                 |
| 服务路由      | Zuul                 | Dubbo PROXY          | Spring Cloud Gateway      |
| 分布式消息    |                      | RocketMQ             | RabbitMQ                  |
| 负载均衡      | Ribbon               | Dubbo LB             | Spring Cloud LoadBalancer |
| 分布式事务    |                      |                      | Seata                     |
| 数据链路跟踪  |                      |                      | Sleuth                    |

阿里云脚手架可以方便创建项目骨架

组件文档都有中文

阿里云开发者平台也有相应的教程

### 平台开发组件选型

|               | 组件                      |
| ------------- | ------------------------- |
| 分布式配置    | Nacos                     |
| 服务注册/发现 | Nacos                     |
| 服务熔断      | Sentinel                  |
| 服务调用      | OpenFeign                 |
| 服务路由      | Spring Cloud Gateway      |
| 分布式消息    | RocketMQ                  |
| 负载均衡      | Spring Cloud LoadBalancer |
| 分布式事务    | Seata                     |

