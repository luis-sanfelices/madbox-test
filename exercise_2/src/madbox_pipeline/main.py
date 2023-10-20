import sys
sys.path.append("src")
from utils import get_spark_context, extract_csv_data, write_csv_data
from transform import madbox_transformation


if __name__ == "__main__":

  """ get spark context from master """
  spark = get_spark_context("madbox")

  """ extract data """
  events_df = extract_csv_data(spark,  ";", "./input_data/events.csv" )
  
  """ process and transform data """
  df = madbox_transformation(events_df)

  """ load data """
  write_csv_data(df, path="./output_data")

  spark.stop()
