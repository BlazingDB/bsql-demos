# bsql-demos
Demo Python notebooks using BlazingSQL with the RAPIDS AI ecoystem.

## Layout
| Notebook Title | Description |
|----------------|----------------|
| blazingsql_demo | How to set up and get started with BlazingSQL and the RAPIDS AI suite |
| Netflow Demo | Query 65M rows of network security data (netflow) with BlazingSQL and then pass to Graphistry to visualize and interact with the data |
| Taxi Demo | Train a linear regression model with cuML on 55 million rows of public NYC Taxi Data loaded with BlazingSQL |
| BlazingSQL vs. Apache Spark | Analyze 20 million rows of net flow data. Compare BlazingSQL and Apache Spark timings for the same workload |
| Federated Query Demo | In a single query, join an Apache Parquet Gilem a CSV, and a GPU DataFrame (GDF) in GPU memory |

## Using bsql-demos in Google Colaboratory
For easiest use of `bsql-demos`
- use `open in colab` (Google Chrome extension) to automatically open any notebook in Google Colaboratory
  - The extension can be found in the Chrome store [here](https://chrome.google.com/webstore/detail/open-in-colab/iogfkhleblhcpcekbiedikdehleodpjo) or on GitHub [here](https://github.com/googlecolab/open_in_colab) 
