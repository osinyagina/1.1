#!/bin/bash

S3_FILE_PATH = "https://storage.yandexcloud.net/hackathon"
S3_FILE_NAME = "events-2022-Sep-30-2134.parquet"
HDFS_PATH = "/user/master/data"
PATH_TO_SCRIPTS = ""
PG_USER = "de_student"
PG_PASSWORD = "de_student"
PG_HOST = "84.201.156.187"
PG_PORT = 5432
PG_SCHEMA = "de_student"


# Загрузка данных из S3 на hdfs
hdfs dfs -mkdir -p $HDFS_PATH
hdfs dfs -cp $S3_FILE_PATH $HDFS_PATH

# Создание схемы БД
python postgres_inner_scripts.py /scripts/init_schema $PG_USER $PG_PASSWORD $PG_HOST $PG_PORT $PG_SCHEMA

# Загрузка данных из hdfs на postgres
python hdfs_to_stg.py $HDFS_PATH stg.events $PG_USER $PG_PASSWORD $PG_HOST $PG_PORT $PG_SCHEMA

# Загрузка из stg в dds
python postgres_inner_scripts.py /scripts/dds $PG_USER $PG_PASSWORD $PG_HOST $PG_PORT $PG_SCHEMA

# Загрузка из dds в cdm
python postgres_inner_scripts.py /scripts/cdm $PG_USER $PG_PASSWORD $PG_HOST $PG_PORT $PG_SCHEMA

# Запуск bash-команды
echo "Запуск завершен"
