### URBS DATA PROCESSING 

1. Build docker-image

``` 
docker-compose build
```

2. Download, Extract and Process data

```
bash process-data.sh
```

3. Setup neo4j database

```
Copy the content of dataprocessing/job/cypher/setup.cypher and run into neo4j console.
```

4. Ingest data into neo4j

```
bash neo4j-loader.sh
```

