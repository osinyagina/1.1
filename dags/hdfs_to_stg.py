import sys
import os
from pyspark import SparkContext, SparkConf
from pyspark.sql import SQLContext
import pyspark.sql.functions as F
import os
 
def main():
    
    base_input_path = sys.argv[1]
    table_output_path = sys.argv[2]
    user = sys.argv[3]
    password = sys.argv[4]
    host = sys.argv[5]
    port = sys.argv[6]
    schema = sys.argv[7]

    conf = SparkConf().setAppName(f"EventsPostgresLoaderJob")
    sc = SparkContext(conf=conf)
    sql = SQLContext(sc)
    spark.conf.set("spark.sql.legacy.timeParserPolicy", "LEGACY")


    events = spark.read.parquet(base_input_path)
    events = events.withColumn("events_timestamp", F.to_timestamp(F.col("event_timestamp"), "yyyy-MM-dd HH:mm:ss")) \
                .withColumn("date", F.to_date(F.col("event_timestamp")))

    properties = {
        "user": user,
        "password": password,
        "driver": "org.postgresql.Driver"
    }
    
    # URL подключения к PostgreSQL
    url = f"jdbc:postgresql://{host}:{port}/{schema}"
    
    # Таблица в PostgreSQL, в которую будут записаны данные
    
    # Запись DataFrame в PostgreSQL
    events.write.jdbc(url=url, table=table_output_path, mode="append", properties=properties)


if __name__ == "__main__":
        main()