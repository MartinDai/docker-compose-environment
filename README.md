## Docker环境部署使用说明

### _进入当前目录，根据实际情况选择需要的容器组合命令执行_

### Elasticsearch主从集群+Kibana服务+Cerebro服务

```
docker-compose -f docker-compose-es.yml up -d
```
- 注意需要`elasticsearch`目录下的`master`和`slave`两个文件夹中的`config/elasticsearch.yml`文件中的ip为本机内网IP
- 这个组合比较消耗内存，至少保证docker有3.5G的空闲可分配内存再启动
- kibana管理页面：http://localhost:5601
- cerebro管理页面：http://localhost:9000

### Thanos+MINio+Prometheus集群

```
docker-compose -f docker-compose-minio.yml up -d
docker-compose -f docker-compose-prometheus1.yml up -d
docker-compose -f docker-compose-prometheus2.yml up -d
docker-compose -f docker-compose-thanos.yml up -d
```
- 注意需要修改当前目录下的`thanos/bucket_config.yml`文件中的ip为本机内网IP
- prometheus1管理页面：http://localhost:9090/graph
- prometheus2管理页面：http://localhost:9091/graph
- thanos管理页面：http://localhost:19192/graph

### Zookeeper集群

```
docker-compose -f docker-compose-zk.yml up -d
```

### clickhouse集群

```
docker-compose -f docker-compose-clickhouse1.yml up -d
docker-compose -f docker-compose-clickhouse2.yml up -d
docker-compose -f docker-compose-clickhouse3.yml up -d
```
- 注意需要修改`clickhouse`目录下的所有node文件夹中所有`metrika.xml`的host为本机内网IP
- clickhouse集群需要依赖zookeeper，所以需要部署zookeeper集群
