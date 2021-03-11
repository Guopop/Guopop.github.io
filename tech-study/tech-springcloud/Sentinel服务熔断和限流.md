# Sentinel 服务熔断和限流

我们需要针对突发的流量来进行限制，在尽可能处理 请求的同时来保障服务不被打垮，这就是流量控制。

我们需要对不稳定的弱依赖服务进行 熔断降级，暂时切断不稳定调用，避免局部不稳定因素导致整体的雪崩。

Sentinel 是阿里巴巴开源的，面向分布式服务架构的高可用防护组件，主要以流量为
切入点，从流量控制、流量整形、熔断降级、系统自适应保护、热点防护等多个维度来帮助 开发者保障微服务的稳定性。

![features-of-sentinel](https://github.com/alibaba/Sentinel/raw/master/doc/image/sentinel-features-overview-en.png)