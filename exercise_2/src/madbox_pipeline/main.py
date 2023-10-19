import sys
sys.path.append("src")
from utils import get_spark_context

def _extract_csv_data(spark, path: str):
  """ function for extracting data from csv """
  df = spark.read.option("header",True) \
            .option("inferSchema", True) \
            .option("delimiter",",") \
    .csv("/tmp/resources/zipcodes.csv")
  return df

if __name__ == "__main__":

    # Regular Spark job executed on a Docker container
    spark = get_spark_context("employees")
    df = _extract_csv_data(spark, "" )
    spark.stop()
