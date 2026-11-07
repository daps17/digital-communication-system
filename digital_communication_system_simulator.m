
% DIGITAL COMMUNICATION SYSTEM SIMULATOR
%
% Description:
% Simulates a digital communication system using
% Binary Phase Shift Keying (BPSK) modulation.
%
% The simulation:
% 1. Generates random binary data.
% 2. Modulates the data using BPSK.
% 3. Adds Gaussian noise to the transmitted signal.
% 4. Recovers the binary data through demodulation.
% 5. Calculates the Bit Error Rate (BER).
% 6. Tests system performance at different noise levels.
%
% Author: Oladepo Olabiyi
% Language: MATLAB

%% 1. Generate Binary Data

clc;
clear;
close all;
rng(1);
% Number of bits to generate
numBits = 10000;

% Generate random binary data
bits = randi([0 1], 1, numBits);

% Display the generated bits
disp('First 20 Original Bits:');
disp(bits(1:20));
signal = 2 * bits - 1;
%% 2. BPSK Modulation

% Display the modulated signal
disp('First 20 Modulated Values:');
disp(signal(1:20));
figure;

stem(1:numBits, signal, 'filled');

xlabel('Bit Position');
ylabel('Signal Amplitude');
title('BPSK Modulated Signal');

ylim([-1.5 1.5]);
grid on;
%% 3. Add Gaussian Noise

% Set noise strength
noiseLevel = 0.5;

% Generate random noise
noise = noiseLevel * randn(1, numBits);

% Add noise to the original signal
receivedSignal = signal + noise;

% Display received signal
disp('First 20 Received Values:');
disp(receivedSignal(1:20));
figure;

plot(1:numBits, signal, 'bo-', 'LineWidth', 1.5);
hold on;

plot(1:numBits, receivedSignal, 'rx--', 'LineWidth', 1.5);

xlabel('Bit Position');
ylabel('Signal Amplitude');
title('Original Signal vs Noisy Signal');

legend('Original Signal', 'Received Signal');

grid on;

%% 4. Demodulation

% Detect whether each received value represents 0 or 1
recoveredBits = receivedSignal >= 0;

% Display the recovered binary message
disp('First 20 Recovered Bits:');
disp(recoveredBits(1:20));
% Compare original and recovered messages

disp('First 20 Original Bits:');
disp(bits(1:20));

disp('Recovered Bits:');
disp(recoveredBits);
%% 5. Calculate Bit Error Rate

% Compare original and recovered bits
errors = bits ~= recoveredBits;

% Count the number of incorrect bits
numErrors = sum(errors);

% Calculate Bit Error Rate
BER = numErrors / numBits;

% Display results
disp('Number of Bit Errors:');
disp(numErrors);

disp('Bit Error Rate:');
disp(BER);

disp('Bit Error Rate Percentage:');
disp(BER * 100);
%% 6. Test Different Noise Levels

% Define the noise levels to test
noiseLevels = 0:0.2:2;

% Create space to store the BER results
BER_values = zeros(size(noiseLevels));
% Repeat the experiment for every noise level
for i = 1:length(noiseLevels)

    % Select the current noise level
    noiseLevel = noiseLevels(i);

    % Generate and add noise
    noise = noiseLevel * randn(1, numBits);
    receivedSignal = signal + noise;

    % Recover the transmitted bits
    recoveredBits = receivedSignal >= 0;

    % Calculate the BER
    errors = bits ~= recoveredBits;
    BER_values(i) = sum(errors) / numBits;

end
% Display BER results
disp('Noise Level     Bit Error Rate');

for i = 1:length(noiseLevels)
    fprintf('%.1f             %.4f\n', noiseLevels(i), BER_values(i));
end
%% 7. Plot and Display Results
% Plot BER against noise level
figure;

plot(noiseLevels, BER_values, 'bo-', 'LineWidth', 1.5);

xlabel('Noise Level');
ylabel('Bit Error Rate');
title('Bit Error Rate vs Noise Level');

ylim([0 0.5]);
xticks(noiseLevels);

grid on;
%% 8. Simulation Summary

fprintf('\n===== SIMULATION SUMMARY =====\n');

fprintf('Total Bits Transmitted: %d\n', numBits);

fprintf('Noise Levels Tested: %d\n', length(noiseLevels));

fprintf('Lowest BER: %.4f\n', min(BER_values));

fprintf('Highest BER: %.4f\n', max(BER_values));

fprintf('Average BER: %.4f\n', mean(BER_values));
exportgraphics(figure(1), 'figures/bpsk_modulated_signal.png', 'Resolution', 300);

exportgraphics(figure(2), 'figures/original_vs_noisy_signal.png', 'Resolution', 300);

exportgraphics(figure(3), 'figures/ber_vs_noise_level.png', 'Resolution', 300);