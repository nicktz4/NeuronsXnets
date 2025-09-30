\# Efficient K-Means Clustering for Huge Datasets



This project implements efficient clustering algorithms, with a focus on scalable \*\*K-Means\*\* capable of processing \*\*large-scale, high-dimensional data\*\* on machines with limited memory.



It provides:

\- Disk-backed memory mapping to handle massive matrices.

\- Multiple distance functions (Euclidean, Cosine, Manhattan).

\- Vectorized (SIMD) optimizations using SSE.

\- Parallel implementations leveraging multi-core CPUs.

\- Docker and Singularity environments for reproducibility.



---



\##  Project Motivation



Our dataset consists of \*\*57,234 points\*\* in \*\*499,500 dimensions\*\* (~167GB text file, ~107GB binary). Running K-Means clustering on such data exceeds typical workstation memory.



\*\*Goals:\*\*

1\. Implement a performant K-Means algorithm.

2\. Enable execution on machines with as little as \*\*16GB RAM\*\*.



---



\## ✨ Features



\- \*\*Disk-backed matrix handling\*\*

&nbsp; - Data stored on disk as binary files.

&nbsp; - Memory-mapped blocks enable partial loading.

&nbsp; - Block size configurable (`-G` option).

\- \*\*Distance functions\*\*

&nbsp; - Euclidean (optimized SSE2/SSE3 implementation).

&nbsp; - Cosine similarity.

&nbsp; - Manhattan distance.

\- \*\*Parallel processing\*\*

&nbsp; - Multi-threaded execution.

&nbsp; - Thread pools (`-v3`) to avoid thread recreation overhead.

&nbsp; - Cache line alignment to minimize false sharing.

\- \*\*Data conversion utilities\*\*

&nbsp; - Convert text to binary (`text2binary`).

&nbsp; - Convert binary back to text (`binary2text`).

&nbsp; - Validate conversions (`cmpbin2txt`).

\- \*\*Containerized environment\*\*

&nbsp; - Docker image and Singularity image (`kmeans.sif`).

&nbsp; - Reproducible execution across systems.



---



\##  Tools Overview



\### Data Preparation



\#### `text2binary`

Convert large text datasets to efficient binary format.



\*\*Usage:\*\*

`./build/text2binary \[-h] \[-t] \[-m] \[-c] \[-G <num>] <input text file> <output binary file>`





\*\*Options:\*\*

\- `-t`: Transpose matrix.

\- `-m`: Load data fully into memory before dumping.

\- `-c`: Check for NaN values.

\- `-G <num>`: Use memory-mapped blocks of specified size (GB).



---



\#### `binary2text`

Export binary data back to text.



\*\*Usage:\*\*

`./build/binary2text \[-t] \[-m] <input binary file> <output text file>`



\*\*Options:\*\*

\- `-t`: Transpose output.

\- `-m`: Load fully in memory before writing.



---



\#### `cmpbin2txt`

Compare binary and text files for validation.



\*\*Usage:\*\*

`./build/cmpbin2txt \[-t] \[-m] <binary file> <text file>`



\*\*Options:\*\*

\- `-t`: Binary file is transposed.

\- `-m`: Load in memory before comparison.



---



\### Clustering Program



\#### `cluster`

Run K-Means clustering.



\*\*Usage:\*\*

`./build/cluster \[-p] \[-s] \[-v2] \[-v3] -G <num> -K <num\_clusters> -N <num\_iterations> -D <distance> <input\_binary\_file> <output\_centroids\_file> <output\_labels\_file>`



\*\*Options:\*\*

\- `-p`: Enable parallel (multi-threaded) execution.

\- `-s`: Use scalar (non-vectorized) distance functions.

\- `-v2`: Enable cache-line alignment optimizations.

\- `-v3`: Use thread pools.

\- `-G <num>`: Memory block size (GB). Use `-G 0` to fully load into memory.

\- `-K <num\_clusters>`: Number of clusters.

\- `-N <num\_iterations>`: Max iterations.

\- `-D <distance>`: Distance function:

&nbsp; - `1` - Euclidean

&nbsp; - `2` - Cosine similarity

&nbsp; - `3` - Manhattan



\*\*Example:\*\*

`./build/cluster -p -v3 -G 8 -K 10 -N 25 -D 1 dataset.bin centroids.bin labels.txt`



---



\## ⚡ Optimizations



\- \*\*Vectorized Euclidean distance\*\*

&nbsp; - SSE2/SSE3 instructions speed up distance computations by ~2.3x.

\- \*\*Avoiding `sqrt`\*\*

&nbsp; - To compare distances, only squared sums are used.

\- \*\*Data parallelism\*\*

&nbsp; - Each thread processes different data ranges.

\- \*\*Cache-line alignment\*\*

&nbsp; - Minimizes false sharing across threads.



---



\##  Container Usage



\### Docker

The docker image can be built using the `docker\_run.sh` script. Then we can tag and push it to docker hub with scripts `docker\_tag.sh` and `docker\_push.sh` respectivelly. In order to run it we execute the script `docker\_run2.sh`.



---



\### Singularity



The environment is packaged as a Singularity container:

`kmeans.sif`





\*\*Run script:\*\*

`singularity\_run.sh`



This script:

\- Maps your current directory to `/workspace` inside the container.

\- Allows direct execution of all tools.



\*\*Example workflow:\*\*

Copy `kmeans.sif`, `singularity\_run.sh` and `build` folder into /data

`cd /data`

`./singularity\_run.sh`



Inside container

`./build/cluster ...`





---



\##  Performance Benchmark



| Implementation             | Real Time          |

|----------------------------|--------------------|

| Scalar Euclidean Distance  | ~37 min            |

| Vectorized SSE3 Distance   | ~15 min            |



\*Measured with 26 iterations on the same dataset.\*



---



\##  Future Work



\- Additional clustering algorithms (`-C` option reserved).

\- GPU acceleration.

\- More distance functions.

\- Dynamic memory tuning.



---



\## 六‍ Contributing



Contributions welcome! Feel free to open issues and pull requests.



---



\##  License



\[MIT License](LICENSE)



---



\##  Contact



For questions or support, please contact:



\- \*\*Maintainer:\*\* \[Christos Tsalidis]

\- \*\*Email:\*\* \[tsalidis@neurolingo.gr]

\- \*\*Organization:\*\* \[Neurolingo]



