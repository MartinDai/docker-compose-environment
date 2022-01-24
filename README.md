# Docker环境部署使用说明

## _进入当前目录，根据实际情况选择需要的容器组合命令执行_

目前配置使用的是适用于Apple M1芯片（arm64）版本的镜像，如果在其他操作系统上执行，需要根据实际情况替换镜像

## Elasticsearch主从集群+Kibana服务+Cerebro服务

```
docker-compose -f docker-compose-es.yml up -d
```
- 注意需要修改`elasticsearch`目录下的`master`和`slave`两个文件夹中的`config/elasticsearch.yml`文件中的ip为本机内网IP
- 这个组合比较消耗内存，至少保证docker有3.5G的空闲可分配内存再启动
- kibana管理页面：http://localhost:5601
- cerebro管理页面：http://localhost:9000

## MinIO服务

```
docker-compose -f docker-compose-minio.yml up -d
```
- MinIO管理页面：http://localhost:19001 ，登录账号密码：minio/miniostorage

## Thanos+Prometheus集群（依赖MinIO）

```
docker-compose -f docker-compose-prometheus1.yml up -d
docker-compose -f docker-compose-prometheus2.yml up -d
docker-compose -f docker-compose-thanos.yml up -d
```
- 注意需要修改`thanos`目录下的`bucket_config.yml`文件中的ip为本机内网IP
- prometheus1管理页面：http://localhost:9090/graph
- prometheus2管理页面：http://localhost:9091/graph
- thanos管理页面：http://localhost:19192/graph

## Zookeeper集群

```
docker-compose -f docker-compose-zk.yml up -d
```

## clickhouse 2分片集群

```
docker-compose -f docker-compose-clickhouse-cluster-2s.yml up -d
```
- 需要修改`docker-compose-clickhouse-cluster-2s.yml`文件中所有的hostname为本机内网IP
- 需要修改`clickhouse/2s`目录下的所有node文件夹中所有`metrika.xml`的host为本机内网IP

## clickhouse 2分片1副本集群

```
docker-compose -f docker-compose-clickhouse-cluster-2s-1r.yml up -d
```
- 需要修改`docker-compose-clickhouse-cluster-2s-1r.yml`文件中所有的hostname为本机内网IP
- 需要修改`clickhouse/2s_1r`目录下的所有node文件夹中所有`metrika.xml`的host为本机内网IP
- 本集群需要依赖zookeeper，所以需要部署zookeeper集群

## Grafana服务

```
docker-compose -f docker-compose-grafana.yml up -d
```
- 管理页面：http://localhost:3000 ，登录账号密码：admin/admin

## Loki服务（依赖MinIO）

```
docker-compose -f docker-compose-loki.yml up -d
```
- 注意需要修改`loki`目录下的`local-config.yaml`文件中的`172.16.2.231`为本机内网IP

## Promtail服务（依赖Loki）

```
docker-compose -f docker-compose-promtail.yml up -d
```
- 需要替换compose文件中的`/Users/martin/develop/projects/SpringBoot-Project/logs`为需要上传的日志目录
- 注意需要修改`promtail`目录下的`config.yml`文件中的`172.16.2.231`为本机内网IP
- 注意需要修改`promtail`目录下的`config.yml`文件中`__path__`的值为实际要抓取的日志文件