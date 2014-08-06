#/bin/bash
awk '{a[FNR]+=$2;b[FNR]++; sumsq[FNR]+=($2)^2} END {for(i=1;i<=FNR;i++) print i, a[i]/b[i], sqrt((sumsq[i] - a[i]^2/NR)/NR);}' random_partitions/imbalance*