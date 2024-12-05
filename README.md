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



### References and useful content

#### Complex Networks

---

##### Books

- [Network Science Book](http://networksciencebook.com) by Albert-László Barabási, is an introductory ebook.
- [Social Network Analysis - Methods and Applications] by Stanley Wasserman and Katherine Faust.

---

##### Websites

- [Complexity Explorer Santa Fe Institute](https://www.complexityexplorer.org/): Offers online courses.
- [New England Complex Systems Institute](https://necsi.edu/): Provides various resources and papers.
- [Going Underground: Graphing and Pathfinding London Tube Lines](https://neo4j.com/blog/going-underground-graphing-pathfinding-london-tube-lines/): Describes how to use Neo4j on public transportation.
- [The Seven Bridges of Königsberg: A Dog's Eye View](https://neo4j.com/blog/seven-bridges-of-konigsberg-dogs-eye-view/): Describes how to use Neo4j on pathfinding.
- [D7.2: GES3 Data Integration](https://www.eubra-bigsea.eu/sites/default/files/EUBRra-BIGSEA_D7.2_GES3DataIntegration_v1.pdf): Document about URBS data integration.
- [Coalescing Networks for Performant Graph Analysis](http://kuanbutts.com/2018/04/01/spectral-cluster-transit/): Explains how to use Python and GTFS for creating network transit graphs.
- [Identifying Urban Zones with Spectral Clustering](http://kuanbutts.com/2017/10/21/spectral-cluster-berkeley/): Berkeley GraphXD.

---

##### Papers

- [Systemic Delay Propagation in the US Airport Network](https://www.nature.com/articles/srep01159/)
- [Hierarchical Structure and the Prediction of Missing Links in Networks](https://www.nature.com/articles/nature06830)
- [Open Graph Benchmark: Datasets for Machine Learning on Graphs](https://arxiv.org/pdf/2005.00687.pdf)
- [T-GCN: A Temporal Graph Convolutional Network for Traffic Prediction](https://arxiv.org/pdf/1811.05320.pdf)
- [Graph Metrics for Temporal Networks](https://arxiv.org/pdf/1306.0493.pdf)
- [Applications of Temporal Graph Metrics to Real-World Networks](https://arxiv.org/pdf/1305.6974.pdf)
- [Time-Varying Graphs and Social Network Analysis: Temporal Indicators and Metrics](https://www.labri.fr/perso/acasteig/files/SQFCA11.pdf)

---

##### Miscellaneous

- [Temporal Graph Networks](https://towardsdatascience.com/temporal-graph-networks-ab8f327f2efe)
- [Visualizing Shortest Paths with NeoMap](https://medium.com/neo4j/visualizing-shortest-paths-with-neomap-0-4-0-and-the-neo4j-graph-data-science-plugin-18db92f680de)
- [StellarGraph](https://www.stellargraph.io/)
- [NetworkX](https://networkx.github.io/)
- [Data to Viz](https://www.data-to-viz.com)
- [Ludwig AI](https://ludwig-ai.github.io/ludwig-docs/getting_started/)
- [PyCaret](https://pycaret.org/tutorial/)
- [Urban Computing Foundation](https://eng.uber.com/urban-computing-foundation/)
- [UC Foundation](https://uc.foundation/)
- [PyDeck](https://medium.com/vis-gl/pydeck-unlocking-deck-gl-for-use-in-python-ce891532f986)
- [Geoplot](https://residentmario.github.io/geoplot/)
- [Kepler.gl NYC Trips Demo](https://kepler.gl/demo/nyctrips)
- [Neo4j GOT Guide](https://guides.neo4j.com/got)
- [Five Graph Algorithms for Data Scientists](https://towardsdatascience.com/data-scientists-the-five-graph-algorithms-that-you-should-know-30f454fa5513)
- [H3-Py](https://github.com/uber/h3-py)
- [Python Optimal Transport](https://pythonot.github.io/)
- [Neo4j Sandbox Graph Algorithms](https://guides.neo4j.com/sandbox/graph-algorithms/)
- [PyTorch Geometric](https://pytorch-geometric.readthedocs.io/en/latest/#)
- [Deep Graph Library](https://www.dgl.ai/)
- [Open Graph Benchmark (OGB)](https://ogb.stanford.edu/docs/dataset_overview/)
- [Reverse Geocoder](https://github.com/thampiman/reverse-geocoder)

