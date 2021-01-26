### URBS DATA PROCESSING 

### Build docker-image

``` 
docker-compose build
```

### Download URBS Data
```

docker-compose exec jupyterlab python dataprocessing/job/download_files.py -s "2019-05-01" -e "2019-05-07" -fd linhas -fl linhas.json.xz

-fd: linhas, pontoslinha, tabelalinha, trechositinerarios, tabelaveiculo, veiculos
-fl: linhas.json.xz, pontosLinha.json.xz, tabelaLinha.json.xz, trechosItinerarios.json.xz, tabelaVeiculo.json.xz, veiculos.json.xz
 
```

### Decompress URBS Data
```
docker-compose exec jupyterlab python dataprocessing/job/decompress_files.py -s "2019-05-01" -e "2019-05-07" -fd linhas -fl linhas.json.xz

-fd: linhas, pontoslinha, tabelalinha, trechositinerarios, tabelaveiculo, veiculos
-fl: linhas.json.xz, pontosLinha.json.xz, tabelaLinha.json.xz, trechosItinerarios.json.xz, tabelaVeiculo.json.xz, veiculos.json.xz

```

### Execute trusting processor
```
docker-compose exec jupyterlab  python dataprocessing/job/trust_ingestion.py -d "2019-05"
```

### Execute refined processor 
```

 docker-compose exec jupyterlab  python dataprocessing/job/refined_ingestion.py -d "2019-05-03" -j [line,timetable,bus-stop, tracking ]
```


### Execute Neo4j processor
```

docker-compose exec jupyterlab  python dataprocessing/job/neo4j_ingestion.py -d "2019-05-03" 
```