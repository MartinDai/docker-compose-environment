# Docker环境部署使用说明

## _进入当前目录，根据实际情况选择需要的容器组合命令执行_

配置只针对于arm64系统环境验证过，如果在其他操作系统上执行，需要根据实际情况选择是否替换镜像

## ClickHouse 2分片集群

```shell
docker-compose -f docker-compose-clickhouse-cluster-2s.yml up -d
```
- 需要修改`docker-compose-clickhouse-cluster-2s.yml`文件中所有的hostname为本机内网IP
- 需要修改`clickhouse/2s`目录下的所有node文件夹中所有`metrika.xml`的host为本机内网IP

## ClickHouse 2分片1副本集群

```shell
docker-compose -f docker-compose-clickhouse-cluster-2s-1r.yml up -d
```
- 需要修改`docker-compose-clickhouse-cluster-2s-1r.yml`文件中所有的hostname为本机内网IP
- 需要修改`clickhouse/2s_1r`目录下的所有node文件夹中所有`metrika.xml`的host为本机内网IP
- 本集群需要依赖zookeeper，所以需要部署zookeeper集群

## CloudBeaver服务（Web版DBeaver）

```shell
docker-compose -f docker-compose-cloudbeaver.yml up -d
```
- 管理页面：http://127.0.0.1:8978

## Consul服务

```bash
docker-compose -f docker-compose-consul.yml up -d
```
- 后台管理页面：http://localhost:8500

## Dubbo-Admin服务

```shell
docker-compose -f docker-compose-dubbo-admin.yml up -d
```
- 注意需要修改docker-compose-dubbo-admin.yml文件中的zookeeper配置ip为目标ip
- Dubbo-Admin页面：http://127.0.0.1:8088 账号密码：root/root

## Elasticsearch主从集群+Kibana服务+Elasticvue服务

```shell
docker-compose -f docker-compose-elasticsearch.yml up -d
```
- 注意需要修改`elasticsearch`目录下的`master`和`slave`两个文件夹中的`config/elasticsearch.yml`文件中的ip为本机内网IP
- 这个组合比较消耗内存，至少保证docker有3.5G的空闲可分配内存再启动
- Kibana管理页面：http://127.0.0.1:5601
- Elsticvue管理页面：http://127.0.0.1:18080

## Flink服务

```shell
docker-compose -f docker-compose-flink.yml up -d
```
- Dashboard页面：http://127.0.0.1:8081

## Grafana服务

```shell
docker-compose -f docker-compose-grafana.yml up -d
```
- 管理页面：http://127.0.0.1:3000 登录账号密码：admin/admin

## Kafka+UI服务

```shell
docker-compose -f docker-compose-kafka.yml up -d
```
- kafka-ui页面：http://127.0.0.1:9999

## LobeChat服务

```shell
docker-compose -f docker-compose-lobe-chat.yml up -d
```
- 主页面：http://localhost:3210

## LocalAI服务

镜像+内置模型约占用20GB左右

```shell
docker-compose -f docker-compose-localai.yml up -d
```
- 主页面：http://localhost:8181

## Loki服务（依赖MinIO）

```shell
docker-compose -f docker-compose-loki.yml up -d
```
- 注意需要修改`loki`目录下的`local-config.yaml`文件中的`172.16.2.231`为本机内网IP

## MCP Inspector服务

```shell
docker-compose -f docker-compose-mcp-inspector.yml up -d
```
- 主页面：http://localhost:5173

## Memcached+exporter服务

```shell
docker-compose -f docker-compose-memcached.yml up -d
```

## MinIO服务

```shell
docker-compose -f docker-compose-minio.yml up -d
```
- MinIO管理页面：http://127.0.0.1:19001 账号密码：minio/miniostorage

## MySQL+exporter服务

```shell
docker-compose -f docker-compose-mysql.yml up -d
```
- 账号密码：root/root

## Neo4j服务

```shell
docker-compose -f docker-compose-neo4j.yml up -d
```
- Web页面：http://127.0.0.1:7474/browser/

## OpenGauss服务

```shell
docker-compose -f docker-compose-opengauss.yml up -d
```
- 账号密码：gauss/Gauss@123

## PostgreSQL+exporter服务

```shell
docker-compose -f docker-compose-postgresql.yml up -d
```
- 账号密码：postgres/postgres-local

## Prometheus

```shell
docker-compose -f docker-compose-prometheus.yml up -d
```
- 管理页面：http://127.0.0.1:9090/graph

## Prometheus集群+Thanos（依赖MinIO）

```shell
docker-compose -f docker-compose-prometheus1.yml up -d
docker-compose -f docker-compose-prometheus2.yml up -d
docker-compose -f docker-compose-thanos.yml up -d
```
- 注意先部署MinIO，并且在管理页面创建一个名为`thanos`的Bucket
- 注意需要修改`docker-compose-thanos.yml`文件和`thanos`目录下的`bucket_config.yml`文件中的ip为本机内网IP
- Prometheus1管理页面：http://127.0.0.1:9081/graph
- Prometheus2管理页面：http://127.0.0.1:9082/graph
- Thanos管理页面：http://127.0.0.1:19192/graph

## Promtail服务（依赖Loki）

```shell
docker-compose -f docker-compose-promtail.yml up -d
```
- 需要替换compose文件中的`/Users/martin/develop/projects/SpringBoot-Project/logs`为需要上传的日志目录
- 注意需要修改`promtail`目录下的`config.yml`文件中的`172.16.2.231`为本机内网IP
- 注意需要修改`promtail`目录下的`config.yml`文件中`__path__`的值为实际要抓取的日志文件

## RabbitMQ服务

```shell
docker-compose -f docker-compose-rabbitmq.yml up -d
```
- Management页面：http://127.0.0.1:15672 账号密码：rabbitmq/rabbitmq-local
- Metrics地址：http://127.0.0.1:15692/metrics

## Redis+exporter服务

```shell
docker-compose -f docker-compose-redis.yml up -d
```

## Redis Cluster集群服务(3主3从)

```shell
docker-compose -f docker-compose-redis-cluster.yml up -d
```
- 启动完成后，进入其中一个容器节点，执行以下命令，创建集群
```shell
redis-cli --cluster create 127.0.0.1:6479 127.0.0.1:6579 127.0.0.1:6679 127.0.0.1:6779 127.0.0.1:6879 127.0.0.1:6979 --cluster-replicas 1
```

## RocketMQ服务+Exporter服务+Dashboard服务

```shell
docker-compose -f docker-compose-rocketmq.yml up -d
```
- 注意需要修改rocketmq/broker/conf/broker.conf文件内的brokerIP1属性为本机内网IP
- Metrics地址：http://127.0.0.1:5557/metrics
- Rocketmq-Dashboard页面：http://127.0.0.1:28080

## VictoriaMetrics服务

```shell
docker-compose -f docker-compose-victoria-metrics.yml up -d
```
- 主页面：http://localhost:8428

## Zookeeper集群+ZooNavigator服务

```shell
docker-compose -f docker-compose-zookeeper.yml up -d
```
- ZooNavigator管理页面：http://127.0.0.1:9000
