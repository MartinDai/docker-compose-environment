-- 创建query_log的分布式表
CREATE TABLE IF NOT EXISTS system.query_log_all AS system.query_log ENGINE = Distributed(cluster_2s, system, query_log);
