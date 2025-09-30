#/bin/bash

#singularity run --oci --bind "$PWD":/workspace ./kmeans.sif
singularity run -B "$PWD":/workspace kmeans.sif
