% Load ECG data from DAT file
data = load('101.dat');  
% Parameters
fs = 1000;  % Sample rate 
T = length(data) / fs;  % Total time duration
t = (0:length(data)-1) / fs;  % Time vector

% Define different noise levels 
noise_powers = [10, 100, 200];  % Noise powers to test

% Preallocate arrays for results
SNR_orig = zeros(size(noise_powers));
SNR_denoised = zeros(size(noise_powers));
MSE_denoised = zeros(size(noise_powers));
PSNR_denoised = zeros(size(noise_powers));

% Loop through different noise levels
for i = 1:length(noise_powers)
    % Generate white Gaussian noise with current power level
    noise_power = noise_powers(i);
    noise = sqrt(noise_power) * randn(size(data));
    
    % Noisy signal
    noisy_signal = data + noise;
    
    % Compute SNR of original signal
    signal_power = mean(data.^2);  % Signal power
    noise_power_orig = mean(noise.^2);  % Noise power
    SNR_orig(i) = 10 * log10(signal_power / noise_power_orig);  % SNR in dB
    
    % Wiener filter implementation
    filtered_signal = zeros(size(noisy_signal));
    
    % Estimate power spectral densities
    N = length(noisy_signal);
    P_signal = abs(fft(noisy_signal)).^2 / N;
    P_noise = abs(fft(noise)).^2 / N;
    
    % Wiener filter frequency response
    H = P_signal ./ (P_signal + P_noise);
    
    % Apply Wiener filter in frequency domain
    filtered_signal = ifft(fft(noisy_signal) .* H);
    
    % Compute SNR of denoised signal
    signal_power_denoised = mean(abs(filtered_signal).^2);  % Signal power after denoising
    noise_power_denoised = mean(abs(filtered_signal - data).^2);  % Noise power after denoising
    SNR_denoised(i) = 10 * log10(signal_power_denoised / noise_power_denoised);  % SNR in dB after denoising
    
    % Compute Mean Squared Error (MSE) and Peak Signal-to-Noise Ratio (PSNR)
    MSE_denoised(i) = mean((filtered_signal - data).^2);
    PSNR_denoised(i) = 10 * log10(max(abs(data))^2 / MSE_denoised(i));
    
    % Plotting results for each noise level
    figure;
    subplot(3,1,1);
    plot(t, data);
    title('Original ECG Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    subplot(3,1,2);
    plot(t, noisy_signal);
    title(['Noisy ECG Signal (SNR_{orig} = ' num2str(SNR_orig(i)) ' dB)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    subplot(3,1,3);
    plot(t, real(filtered_signal));
    title(['Denoised ECG Signal (SNR_{denoised} = ' num2str(SNR_denoised(i)) ' dB)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
end

% Print performance metrics for different noise levels
disp('Performance Metrics for Different Noise Levels:');
disp('----------------------------------------------');
disp(['Noise Power   |   SNR (Original)   |   SNR (Denoised)   |   MSE   |   PSNR']);
disp('----------------------------------------------');
for i = 1:length(noise_powers)
    disp([num2str(noise_powers(i)) '          ' num2str(SNR_orig(i)) ' dB              ' num2str(SNR_denoised(i)) ' dB             ' num2str(MSE_denoised(i)) '        ' num2str(PSNR_denoised(i)) ' dB']);
end
disp('----------------------------------------------');
