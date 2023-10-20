import os
from pyspark.conf import SparkConf
from pyspark.sql import SparkSession



def get_spark_context(app_name: str) -> SparkSession:
    """
    Helper to manage the `SparkContext` and keep all of our
    configuration params in one place.
    """

    conf = SparkConf()

    conf.setAll(
        [
            (
                "spark.master",
                os.environ.get("SPARK_MASTER_URL", " spark://spark-master:7077"),
            ),
            ("spark.driver.host", os.environ.get("SPARK_DRIVER_HOST", "local[*]")),
            ("spark.submit.deployMode", "client"),
            ("spark.driver.bindAddress", "0.0.0.0"),
            ("spark.app.name", app_name),
        ]
    )

    return SparkSession.builder.config(conf=conf).getOrCreate()

def extract_csv_data(spark, delimiter, path: str) -> object:
  """ function for extracting from csv to spark dataframe """

  df = spark.read.option("header",True) \
                 .option("inferSchema", True) \
                 .option("delimiter", delimiter) \
            .csv(path)
  return df

def write_csv_data(df, path: str, partition_number = 1) -> None:
   """ write spark dataframe to csv """
   
   df.coalesce(partition_number).write.csv(path)