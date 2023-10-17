from pyspark.sql import SparkSession
from pyspark.sql.functions import *

def _extract_csv_data(spark, path: str):
  """ function for extracting data from csv """
  df = spark.read.option("header",True) \
            .option("inferSchema", True) \
            .option("delimiter",",") \
    .csv("/tmp/resources/zipcodes.csv")
  return df

# Create a SparkSession
spark = SparkSession.builder \
   .appName("My App") \
   .getOrCreate()

df = _extract_csv_data(spark, "" )

print("THE SUM IS HERE: ", rdd.sum())
# Stop the SparkSession
spark.stop()