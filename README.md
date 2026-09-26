# ECG Signal Classification using MODWPT Feature Extraction and Machine Learning

This repository contains MATLAB scripts for classifying ECG signals into four cardiac condition categories using **Maximal Overlap Discrete Wavelet Packet Transform (MODWPT)** for feature extraction, followed by classification using multiple machine learning algorithms.

## 📋 Overview

ECG signals are decomposed using MODWPT to extract discriminative time-frequency features. Mean statistical features derived from the wavelet packet coefficients are used to train and evaluate four different classifiers, and their performance is compared using confusion matrix–based statistics.

## 🫀 Classes

The classification distinguishes between four categories:

| Label | Class | Description |
|-------|-------|-------------|
| NSR   | Normal Sinus Rhythm | Healthy/normal ECG pattern |
| ARR   | Arrhythmia | Irregular heart rhythm |
| AFIB  | Atrial Fibrillation | Rapid, irregular atrial activity |
| CHF   | Congestive Heart Failure | ECG patterns associated with heart failure |

## 📊 Dataset

- **Source:** [MIT-BIH](https://physionet.org/) publicly available ECG databases (e.g., MIT-BIH Arrhythmia Database, MIT-BIH Atrial Fibrillation Database, BIDMC Congestive Heart Failure Database, and Normal Sinus Rhythm Database), accessed via PhysioNet.
- ECG records were preprocessed and segmented, then passed through MODWPT decomposition to extract wavelet packet sub-band coefficients.
- Mean-based statistical features were computed from the decomposed signals and split into training and test sets.

## 📁 Repository Structure

```
├── KNN_meanData_classifier.m   # K-Nearest Neighbors classifier
├── NaiveBayes_meanData.m       # Naive Bayes classifier
├── RF_classifier_mean.m        # Random Forest classifier
├── SVM_classifier_mean.m       # Support Vector Machine classifier
├── confusionmatStats.m         # Utility function to compute confusion matrix statistics
├── trainm.mat                  # Training dataset (MODWPT mean features)
├── testm.mat                   # Testing dataset (MODWPT mean features)
└── README.md
```

## 🔧 File Descriptions

- **`KNN_meanData_classifier.m`** — Loads training/test data, trains a K-Nearest Neighbors model on the MODWPT-derived mean features, and evaluates classification performance.
- **`NaiveBayes_meanData.m`** — Trains and evaluates a Naive Bayes classifier on the same feature set.
- **`RF_classifier_mean.m`** — Trains and evaluates a Random Forest (ensemble of decision trees) classifier.
- **`SVM_classifier_mean.m`** — Trains and evaluates a Support Vector Machine classifier.
- **`confusionmatStats.m`** — Helper function that computes performance metrics (accuracy, sensitivity, specificity, precision, F1-score, etc.) from a confusion matrix, used by each classifier script.
- **`trainm.mat`** — MATLAB data file containing the training feature set and corresponding class labels (NSR / ARR / AFIB / CHF).
- **`testm.mat`** — MATLAB data file containing the test feature set and corresponding class labels.

## ⚙️ Requirements

- MATLAB (R2019b or later recommended)
- Statistics and Machine Learning Toolbox
- Wavelet Toolbox (for MODWPT-based feature extraction, if regenerating features from raw ECG signals)

## 🚀 Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/<your-repo-name>.git
   cd <your-repo-name>
   ```
2. Open MATLAB and set the repository folder as your current working directory.
3. Ensure `trainm.mat` and `testm.mat` are present in the same directory as the classifier scripts.
4. Run any classifier script directly, for example:
   ```matlab
   KNN_meanData_classifier
   ```
5. Each script will:
   - Load `trainm.mat` and `testm.mat`
   - Train the respective model on the training features
   - Predict labels on the test set
   - Generate a confusion matrix and print performance statistics via `confusionmatStats.m`

## 📈 Results

Multi-Class Performance Metrics — confusionmatStats.m

This function was written from scratch to handle 4-class ECG classification evaluation, since standard binary confusion-matrix formulas don't directly generalize. It works by:

Accepting the multi-class confusion matrix (or true/predicted label vectors) as input.
Internally re-encoding the problem as one-vs-all for each class, computing TP, FP, FN, and TN of that class against the remaining three.
Returning a MATLAB struct (stats) with the following fields, computed per class:
accuracy — Accuracy
sensitivity — Sensitivity / Recall
specificity — Specificity
precision — Precision (Positive Predictive Value)
ClassificationError — Classification error rate
Flscore — Per-class F1-score
Mathews_Corrcoef (mcc) — Matthews Correlation Coefficient
And the following aggregated/overall fields:
MicroFlscore — Micro-averaged F1-score
MacroFlscore — Macro-averaged F1-score
WeightedFlscore — Weighted-averaged F1-score
Mean_MCC — Mean Matthews Correlation Coefficient across classes
Id_accuracy — Overall/identification accuracy

Because it's shared across all four classifier scripts, every model 
(KNN, Naive Bayes, Random Forest, SVM) is evaluated with the exact same metric 
logic — including micro/macro/weighted F1 variants and MCC — keeping comparisons between them consistent and fair.

Update this section with your own results table once you have run all four classifiers, e.g.:

| Classifier | Accuracy | Precision | Recall | F1-score |
|-----------|----------|-----------|--------|----------|
| KNN | — | — | — | — |
| Naive Bayes | — | — | — | — |
| Random Forest | — | — | — | — |
| SVM | — | — | — | — |

## 📖 Citation

If you use the MIT-BIH databases in your work, please cite:

> Moody GB, Mark RG. The impact of the MIT-BIH Arrhythmia Database. IEEE Eng in Med and Biol 20(3):45-50 (May-June 2001).
>
> Goldberger AL, et al. PhysioBank, PhysioToolkit, and PhysioNet: Components of a New Research Resource for Complex Physiologic Signals. Circulation 101(23):e215-e220, 2000.

## 📝 License

Specify your preferred license here (e.g., MIT License).

## 🙋 Contact

For questions or contributions, please open an issue or submit a pull request.
