#! /bin/bash

<<doc
snakemake --rerun-incomplete -j 1000 --jobscript ./jobscript.sh \
		  --timestamp --latency-wait 240 \
		  --cluster-config cluster.json --cluster './bsub_cluster.py' \
		  "$@"
doc

# invoke Snakemake in cluster mode with custom wrapper scripts

snakemake --jobs 99999 \
    --timestamp \
    --localcores 24 \
    --latency-wait 240 \
    --cluster-config cluster.json \
    --cluster "sbatch --account {cluster.account} --partition {cluster.partition} --exclusive --nodes 1 --ntasks 24 --time {cluster.time} --job-name {cluster.name} --output {cluster.output} --error {cluster.error}" \
    09vsurf_output_by_chr/chr22_vsurf_out.rda
