# K-Means Clustering of Resting-State fMRI Data  

This repository contains code, data, and results from applying **K-Means clustering** to a large resting-state fMRI dataset. The primary objective is to evaluate the reproducibility of brain connectivity patterns across different clustering distances.  

---

## Dataset  

We utilized a large resting-state fMRI dataset consisting of **20-minute recordings from 285 participants (~60 GB)**.  
The dataset was originally described in [Lumaca et al. (2024)](https://www.nature.com/articles/s41467-024-52479-z).  

---

## fMRI Preprocessing  

The preprocessing pipeline followed state-of-the-art practices:  

- **Initial preprocessing:** Conducted using the [fMRIPrep pipeline](https://www.nature.com/articles/s41592-018-0235-4).  
- **Denoising steps:**  
  1. Confound removal (motion, CSF, WM, global signal)  
  2. Demeaning  
  3. Detrending  
  4. Band-pass filtering (0.008 – 0.09 Hz)  
  5. ROI extraction using the **232-region Schaefer–Tian cortical-subcortical atlas**  
- **Feature extraction:** Instantaneous phase coherence  

---

## K-Means Clustering  

We developed a **high-performance clustering algorithm** tailored for large-scale neuroimaging data.  

- The **implementation** is available in the `code` directory, along with a detailed `README` for usage instructions.  
- The **resulting connectivity patterns** are stored in the `data` directory.  
- Analyses were replicated for:  
  - **Cluster numbers:** k = 3–8  
  - **Preprocessing variants:** with and without global signal regression  
  - **Clustering distances:** Euclidean, Manhattan, and Cosine  

---

## Key Findings  

A comprehensive summary of the methodology, benchmarking, and results can be found in **`Neurolingo_Report.pdf`**.  
In brief:  

- The developed algorithm **substantially outperforms** the benchmark implementation.  
- Clustering solutions exhibit **high topological similarity** to the benchmark.  
- Different distance metrics yield **distinct brain connectivity patterns**.  
- There is **no consensus** regarding the optimal number of brain connectivity patterns.  

---

## Contact  

For further information:  

- **Analysis inquiries:** paradeisios.boulakis@uliege.be  
- **Software inquiries:** tsalidis@neurolingo.gr  


