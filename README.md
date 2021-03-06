# Chef Percona Cluster

## Description
[Percona XtraDB Cluster 5.6x](https://www.percona.com/software/mysql-database/percona-xtradb-cluster)をChefにてインストールするためのCookbook。

## Requirement

### Supported Platforms
* CentOS 6.x
* CentOS 7.x

### Supported Chef version
* 11.14.2以上

## Usage
```
"percona_cluster": {
    "root_password": "mysql",
    "wsrep_cluster_addresses": [ "192.168.1.10", "192.168.1.11", "192.168.1.12" ],
    "wsrep_node_address": "192.168.1.10",
    "wsrep_cluster_name": "my_cluster",
    "wsrep_sst_auth": "sstuser:s3cret"
}
```

* `root_password` - MySQLのrootパスワード
* `wsrep_cluster_addresses` - クラスター対象の全IPアドレスを配列定義。サーバのインストール順(Chef適用順)にIPアドレスを記述
* `wsrep_node_address` - クラスターIPアドレス内のインストール対象のIPアドレス
* `wsrep_cluster_name` - クラスター名称
* `wsrep_sst_auth` - Percona用のヘルスチェックユーザーとパスワードの設定'{ユーザー名}:{パスワード}'

#### chef soloの実行例
```
knife solo cook root@192.168.1.10
knife solo cook root@192.168.1.11
knife solo cook root@192.168.1.12
```

## Licence
[MIT](https://ja.wikipedia.org/wiki/MIT_License)
