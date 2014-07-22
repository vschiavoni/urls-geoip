#!/bin/bash
echo "Handling HyperGraph partitions"
lua parse_hypergraph_clusters.lua
echo "Handling Random partitions"
lua parse_random_clusters.lua
echo "Handling KMeans partitions"
lua parse_kmeans_clusters.lua