from dask.distributed import Client
from blazingsql import BlazingContext
from dask_cuda import LocalCUDACluster

# initalize BlazingContext with the Dask Client of local GPUs to distribute query execution
bc = BlazingContext(dask_client=Client(LocalCUDACluster()), network_interface='lo')

# register public AWS S3 bucket 
bc.s3('blazingsql-colab', bucket_name='blazingsql-colab')

# create a table from that S3 bucket
col_names = ['key', 'fare', 'pickup_x', 'pickup_y', 'dropoff_x', 'dropoff_y', 'passenger_count']
bc.create_table('taxi', 's3://blazingsql-colab/taxi_data/taxi_00.csv', names=col_names)

# query the table & write results locally as parquet 
bc.sql('SELECT * FROM taxi').to_parquet(f'../../data/yellow_cab')
