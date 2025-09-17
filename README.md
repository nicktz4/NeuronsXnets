# 🧠 Mesoscopic Two-Photon Imaging Dataset  

This repository contains experimental data from a **120-minute mesoscopic two-photon imaging session** of a single adult mouse. The dataset includes neural activity, behavioral measurements, stimulus recordings, anatomical assignments, and direction tuning analyses.  

---

## 📌 Overview  

- **Subjects**: Five adult mice (10–12 weeks), expressing **GCaMP6s** in pyramidal neurons (F1 cross between BL6-SLC17a7-Cre × Ai162, JAX stocks 023527 & 031562).  
- **Imaging**: Mesoscopic two-photon covering dorsal V1 and nearby extrastriate cortex.  
- **Timing**:  
  - Imaging performed ≥2 weeks post-craniotomy.  
  - Acquisition rate: **6.3 Hz**.  
  - Field of view: ~**1.2 × 1.2 mm²**.  
- **Session Design**:  
  - **First 60 min (stimulus presentation)**: Gaussian noise videos with optical flow in **16 random motion directions**.  
  - **Second 60 min (spontaneous activity)**: Head-fixed, treadmill, quiet wakefulness.  

⚠️ **This repository corresponds to a single mouse dataset.**  

Each dataset contains **8 imaging plane scanfields** (indexed `0–7`).  

---

## 📂 Repository Structure  

### 1. **Behavior & Stimulus Data**  
File: `Behavior_Stimuli.pkl`  

Contains timestamps, treadmill velocity, pupil data, and alignment information.  

**Key Variables**  
- `frame_behaviour_clock` – ScanImage slice timestamps (behavior clock).  
- `frame_stimulus_clock` – ScanImage slice timestamps (stimulus clock).  
- `treadmill_time`, `treadmill_vel` – Wheel motion.  
- `eye_timestamps`, `pupil_radius`, `pupilX`, `pupilY` – Pupil tracking.  
- `timestamps_monet` – Stimulus timestamps.  
- `timestamps_spontaneous` – Spontaneous timestamps.  
- `fps` – Sampling rate (Hz).  
- `spontaneous_start`, `spontaneous_end` – Spontaneous activity window.  

**Alignment procedure:**  
1. Match spontaneous events to `frame_stimulus_clock`.  
2. Divide corresponding frame index by 4.  

✅ Example: For `{animal_id: 24705, session: 3, scan_idx: 24}`, spontaneous activity = frames `26,905–50,052`.  

---

### 2. **Imaging Plane Data**  

#### Fluorescence (`Fluorescence.pkl`)  
- `list_total_cells` – Per-field neuron IDs.  
- `list_fluo` – Raw background-subtracted fluorescence traces.  
- `list_background` – Background component.  
- `list_mask` – Pixel weight masks.  

#### Deconvolved (`Deconvolved.pkl`)  
- `list_tracez` – Deconvolved spike probability amplitudes.  
- Method: **Constrained NMF + AR(2) autoregressive deconvolution** (Pnevmatikakis et al.).  

---

### 3. **Direction Tuning**  
File: `DirectionTuning.pkl`  

- Direction/orientation selectivity quantified via **von Mises fitting**.  
- **Tuning classification**:  
  - **Monopeaked**: Major peak ≥ 3× minor peak.  
  - **Bipeaked**: Otherwise.  

**Stored Variables**  
- `list_dir_pref` – Preferred direction.  
- `list_dir_peaks` – Peak directions.  
- `list_amps` – Peak amplitudes.  
- `list_von_pred_adv` – Adjusted explained variance.  
- `list_von_pval` – Significance (shuffle test).  
- `list_base`, `list_sharps` – Baseline & selectivity indices.  

---

### 4. **Receptive Field Maps**  
File: `RFmaps.pkl`  

- `list_RFmaps` – ON/OFF receptive field maps.  
- `list_mapped_cells` – Cells with valid maps.  

---

### 5. **Anatomical Data**  

#### Anatomy (`Anatomy.pkl`)  
- `x_cell, y_cell, z_cell` – 3D cell coordinates.  
- `uid_master` – Master neuron list across fields.  
- `areamem` – Brain area assignment (V1, LM, AL, RL, A, POR, etc.).  
- `x_field, y_field, field_depth` – Scanfield center coordinates.  

#### Anatomy with Mask (`Anatomy_with_mask.pkl`)  
- Includes `px_x, px_y` (pixel coordinates), `ms_delay` (timing correction).  
- Extended for **visualization and overlay**.  

---

### 6. **Stimulus Movies (Monet Data)**  
File format: `monet_movie_XXX`  

- `list_mvx` – 15s movies (900 frames each).  
- Dimensions: height × width × frames.  
- Alignment:  
  - Use `timestamps_monet` + `frame_stimulus_clock`.  
  - Each imaging frame = 4 stimulus timestamps.  

**Stimulus Example (Fig. 1)**  
- Gaussian noise “waves” drifting in **16 directions**.  
- Directions presented in random order.  

---

## 🔄 Reconstructing Raw Fluorescence  

1. Load cell pixel coordinates (`px_x`, `px_y`) from `Anatomy_with_mask`.  
2. Get mask weights (`list_mask`) from `Fluorescence.pkl`.  
3. Multiply corresponding background trace (`list_background`) by mask weight.  
4. Add to background-subtracted fluorescence (`list_fluo`).  

---

## 📑 Citation  

If you use this dataset, please cite:  
```
[Author(s)], [Year]. Mesoscopic two-photon imaging dataset of visual cortex. 
Available at: https://github.com/[your-repo-link]
```

---

## 📬 Contact  

For questions or issues, please open a GitHub issue or contact:  
- [Your Name / Lab]  
- [Your Email / Lab Website]  
