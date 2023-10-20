from typing import Dict, Any
from pyspark.sql.types import DateType
from pyspark.sql.functions import col
from pyspark.sql import Window




def madbox_transformation(df) -> object:

    """ select and transform needed columns """
    filtered_df = df.select([
            col("event_date").cast(DateType).alias("date") ,
            col("ad_revenue")
        ])
    
    """ calculate daily revenue """
    revenue_df = filtered_df.groupBy("date").sum("ad_revenue").alias("daily_revenue")

    """ calculate cumulative revenue """
    window = (Window.partitionBy().orderBy("date")
             .rangeBetween(Window.unboundedPreceding, 0))
    cum_revenue_df = revenue_df.withColumn("cum_revenue", sum("daily_revenue").over(window))

    return cum_revenue_df
    

