#!/bin/bash
ruby gen_cdf.rb -f distances_hypergraph_16.txt   > data/cdf_distances_hypergraph_16.txt 
ruby gen_cdf.rb -f distances_hypergraph_32.txt   > data/cdf_distances_hypergraph_32.txt 
ruby gen_cdf.rb -f distances_hypergraph_64.txt   > data/cdf_distances_hypergraph_64.txt 
ruby gen_cdf.rb -f distances_hypergraph_128.txt  > data/cdf_distances_hypergraph_128.txt
ruby gen_cdf.rb -f distances_hypergraph_256.txt  > data/cdf_distances_hypergraph_256.txt
ruby gen_cdf.rb -f distances_hypergraph_512.txt  > data/cdf_distances_hypergraph_512.txt
ruby gen_cdf.rb -f distances_hypergraph_1024.txt > data/cdf_distances_hypergraph_1024.txt

ruby gen_cdf.rb -f distances_kmeans_16.txt   > data/cdf_distances_kmeans_16.txt 
ruby gen_cdf.rb -f distances_kmeans_32.txt   > data/cdf_distances_kmeans_32.txt 
ruby gen_cdf.rb -f distances_kmeans_64.txt   > data/cdf_distances_kmeans_64.txt 
ruby gen_cdf.rb -f distances_kmeans_128.txt  > data/cdf_distances_kmeans_128.txt
ruby gen_cdf.rb -f distances_kmeans_256.txt  > data/cdf_distances_kmeans_256.txt
ruby gen_cdf.rb -f distances_kmeans_512.txt  > data/cdf_distances_kmeans_512.txt
ruby gen_cdf.rb -f distances_kmeans_1024.txt > data/cdf_distances_kmeans_1024.txt

ruby gen_cdf.rb -f distances_random_16.txt   > data/cdf_distances_random_16.txt 
ruby gen_cdf.rb -f distances_random_32.txt   > data/cdf_distances_random_32.txt 
ruby gen_cdf.rb -f distances_random_64.txt   > data/cdf_distances_random_64.txt 
ruby gen_cdf.rb -f distances_random_128.txt  > data/cdf_distances_random_128.txt
ruby gen_cdf.rb -f distances_random_256.txt  > data/cdf_distances_random_256.txt
ruby gen_cdf.rb -f distances_random_512.txt  > data/cdf_distances_random_512.txt
ruby gen_cdf.rb -f distances_random_1024.txt > data/cdf_distances_random_1024.txt