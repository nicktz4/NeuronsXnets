# Visual Cortex Traces Repository

This repository contains datasets and processing pipelines from two-photon calcium imaging experiments in the primary visual cortex (V1) of mice.

---
## Overview

We performed a series of two-photon (2P) imaging and to investigate learning-related plasticity in V1 using variants of the **Mark Bear Learning paradigm**.  

The repository provides:  
- **Raw and processed neuronal activity traces** (fluorescence, neuropil, deconvolved signals).  
- **Metadata and preprocessing outputs** from [Suite2p](https://github.com/MouseLand/suite2p).  
- **A documented spike-train inference pipeline**, including neuropil decontamination using FISSA and spike train thresholding.  

---

## Experimental Setup

- **Species & preparation**: Transgenic mice expressing GCaMP6 (calcium indicators).  
- **Imaging**: 2P mesoscope, Layer 2/3 neurons, 6 Hz frame rate, FOVs of ~1.8 × 2.5 mm.  
- **Visual stimulation**: Full-field sinusoidal gratings, phase-reversal paradigms (45° familiar, 135° novel).  
- **Electrophysiology**: VEPs recorded in parallel to optimize stimulation parameters.  
- **Behavior**: Mice habituated, allowed to run on a rotary wheel during stimulus presentation.  

Experimental timelines followed structured multi-day paradigms with spontaneous activity, familiar/novel visual stimulation, and direction tuning measurements.  

---

## Dataset Contents

Each dataset consists of multiple NumPy arrays and dictionaries produced by **Suite2p** and subsequent analyses.  
This is an example data repository for a mouse and Day 1 of 30 minutes of spontaneous recoding.

| Filename   | Description                                                                 | Format / Type | Example Day | Condition     |
|------------|-----------------------------------------------------------------------------|---------------|-------------|---------------|
| `F.npy`    | Fluorescence traces (ROIs × timepoints)                                     | `N × T` array | D1          | Spontaneous   |
| `Fneu.npy` | Neuropil fluorescence traces                                                | `N × T` array | D1          | Spontaneous   |
| `spks.npy` | Deconvolved spike probability traces                                        | `N × T` array | D1          | Spontaneous   |
| `stat.npy` | Cell-wise statistics                                                        | List of dicts | D1          | Spontaneous   |
| `ops.npy`  | Options and intermediate outputs from Suite2p                               | Dict          | D1          | Spontaneous   |
| `iscell.npy` | ROI classification (cell vs. non-cell, probability)                       | `N × 2` array | D1          | Spontaneous   |
| `F_FISSA.npy` | Fluorescence traces after removing neuropil contamination using FISSA    | `N × T` array | D1          | Spontaneous   |



---

## Spike Train Inference Pipeline

To convert raw 2P imaging data into spike train estimates, we provide a reproducible multi-step pipeline:  

1. **ROI Detection (Suite2p)**  
   - Automatic segmentation of neuronal ROIs.  
   - Extraction of raw fluorescence traces.  

2. **Neuropil Decontamination (FISSA)**  
   - Separation of somatic vs. neuropil signals using blind source separation.  
   - Outputs corrected traces for each ROI.  

3. **Deconvolution (OASIS, AR(1) model)**  
   - Infers calcium concentration and spike rates from fluorescence traces.  
   - Produces continuous deconvolved traces.  

4. **Thresholding (3nz method)**  
   - Converts continuous spike estimates into binary spike trains.  
   - Supports fixed and adaptive thresholding.  

---

## Usage

### Dependencies
- Python 3.8+  
- [Suite2p](https://github.com/MouseLand/suite2p)  
- [FISSA](https://github.com/rochefort-lab/fissa)  
- [OASIS](https://github.com/j-friedrich/OASIS)  
- NumPy, SciPy, Matplotlib  

---

## License

This dataset and pipeline are released under the **MIT License**.  
