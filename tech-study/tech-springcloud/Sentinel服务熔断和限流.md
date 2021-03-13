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
nohup java -Dserver.port=8080 -Dcsp.sentinel.dashboard.server=localhost:8080 -Dproject.name=sentinel-dashboard -jar sentinel-dashboard.jar &
```

访问http://localhost:8080 账号/密码：sentinel/sentinel

<img src="https://guopop.oss-cn-beijing.aliyuncs.com/img/image-20210313103342282.png" alt="image-20210313103342282" style="zoom:50%;" />

安装成功！！！

