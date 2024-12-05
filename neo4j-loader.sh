#!/bin/bash

# Define date range
START_DATE="2019-05-03"
END_DATE="2019-05-07"

# Function to execute Neo4j loader
execute_neo4j_loader() {
  docker-compose exec jupyterlab python dataprocessing/job/neo4j_loader.py -ds "$START_DATE" -de "$END_DATE"
}

# Execute the Neo4j loader
execute_neo4j_loader