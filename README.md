# databricks-insights
A repository demonstrating the use of Databricks Spark clusters from within the ArcGIS Insights kernel gateway.

## About
Scaling business intelligence is a challenge. Combining Spark managed by Databricks with ArcGIS Insights can make it easier.
You can read more about the process and analysis [here.](https://www.esri.com/arcgis-blog/products/insights/analytics/business-intelligence-at-scale-leveraging-apache-spark-within-arcgis-insights/)

Want the same thing for ArcGIS Pro Notebooks? Check out @mraad's repository [here.](https://github.com/mraad/spark-esri)

## Prereqs
- conda installed and accessible in your path environment variable [docs](https://docs.anaconda.com/anaconda/install/)
- java 8 installed and selected as the default (installation and setup varies by platform)
- ArcGIS Insights Desktop client [download here](https://www.esri.com/en-us/arcgis/products/arcgis-insights/resources/desktop-client-download)
- A Databricks Subscription [free trial](https://docs.databricks.com/getting-started/try-databricks.html)

## Setup
`conda env create -f insights-dbc.yml`

`conda activate insights-dbc`

When that's done, ensure that databricks-connect was successfully installed and respects your pyspark path:

`databricks-connect get-spark-home`

If that fails with `CommandNotFound`, run:

`pip install databricks-connect==6.5 # replace 6.5 with your cluster version`

Make sure you have the following available from your Databricks environment before moving on:
- A Spark cluster, with at least the following configuration parameters:
  - `spark.databricks.service.server.enabled true`
  - `spark.databricks.service.port 8787 # 8787 required for Azure, can be other for AWS`
- Workspace URL
- Access Token
- Cluster ID
- Port

You can find details on these configs in the [Databricks Connect docs](https://docs.databricks.com/dev-tools/databricks-connect.html#step-2-configure-connection-properties)

Next, interactively configure the Databricks environment:

`databricks-connect configure`

And, test that configuration:

`databricks-connect test # Warning: this will start your Databricks cluster if it isn't already up`

If you passed all the tests, you can spin up the kernel gateway for Insights with:

`chmod +x start_kernel.sh && ./start_kernel.sh  # mac/linux/wsl only`

Or run the command yourself:
```
jupyter kernelgateway --KernelGatewayApp.ip=0.0.0.0 \
                      --KernelGatewayApp.port=9999 \
                      --KernelGatewayApp.allow_origin='*' \
                      --KernelGatewayApp.allow_credentials='*' \
                      --KernelGatewayApp.allow_headers='*' \
                      --KernelGatewayApp.allow_methods='*' \
                      --JupyterWebsocketPersonality.list_kernels=True
```

Your terminal should now be reporting there is an open kernel gateway at `0.0.0.0:9999`.

From ArcGIS Insights, launch the scripting console from the top right corner and enter in `0.0.0.0:9999` as the URL then click connect.

Congrats! You now have an ArcGIS Insights kernel that will remotely execute Spark jobs on your Databricks cluster.

The insights-spark-well-clusters notebook is an export from Insights that demonstrates what I did for my first test of this environment. To reproduce it, add [this data](https://hifld-geoplatform.opendata.arcgis.com/datasets/oil-and-natural-gas-wells/data) to your DBFS. It's HIFLD's dataset for North American Oil and Gas Wells and the notebook trains a very simple k-means model to perform clustering on that dataset.

## License

Apache BSD 2.0 @ Samuel Cook, 2020

## Contributing

Feel free to open an issue or PR, we welcome contributions of all types. :)

## To Do

- [] Docker image and compose.yml
- [] New visualization examples
