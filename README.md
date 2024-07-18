# ECG Signal Denoising using Wiener Filter

This MATLAB script performs the denoising of an ECG signal by adding white Gaussian noise at different power levels and applying a Wiener filter. The script evaluates the performance of the Wiener filter by calculating various metrics including Signal-to-Noise Ratio (SNR), Mean Squared Error (MSE), and Peak Signal-to-Noise Ratio (PSNR).

## Table of Contents

- [Introduction](#introduction)
- [Dependencies](#dependencies)
- [Usage](#usage)
- [Performance Metrics](#performance-metrics)
- [Results](#results)

## Introduction

The purpose of this script is to demonstrate the effectiveness of the Wiener filter in denoising an ECG signal. The script:
1. Loads ECG data from a DAT file.
2. Adds white Gaussian noise to the signal at various power levels.
3. Applies the Wiener filter to denoise the signal.
4. Computes performance metrics to evaluate the denoising process.

## Dependencies

- MATLAB R2020a or later.

## Usage

1. Clone the repository to your local machine.
    ```bash
    git clone https://github.com/yourusername/ecg-denoising-wiener-filter.git
    cd ecg-denoising-wiener-filter
    ```
2. Place your ECG data file `101.dat` in the same directory as the script.
3. Open MATLAB and run the script `Open_dat.m`.

    ```matlab
    Open_dat
    ```

## Performance Metrics

The script calculates the following performance metrics for different noise levels:
- **Signal-to-Noise Ratio (SNR)**: Measures the power ratio between the signal and the noise.
- **Mean Squared Error (MSE)**: Measures the average of the squares of the errors between the original and denoised signals.
- **Peak Signal-to-Noise Ratio (PSNR)**: Measures the ratio between the maximum possible power of the signal and the power of the noise that affects the fidelity of its representation.

## Results

The script outputs performance metrics and plots the original, noisy, and denoised ECG signals for each noise level tested.

