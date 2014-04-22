

function main_matlab_check_RSE_noise_level (audio_file)

    clc;

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);

    % set up parameters
    sampling_rate = 8192;
    framesize = 256;
    framestep = 128;
    
    noise_level_array = 0:0.01:0.1; % white noise level: 0.01 represents 1%.
    % num_of_framestep_for_RSE_array = 200:100:800; % number of framesteps for calculating Relative Spectral Entropy (RSE)    
    % num_of_framestep_for_RSE_array = 10:20:110; % number of framesteps for calculating Relative Spectral Entropy (RSE)    
    % num_of_framestep_for_RSE_array = 500; % number of framesteps for calculating Relative Spectral Entropy (RSE)    
    num_of_framestep_for_RSE_array = [3 5 10 30 50 70 100 200 300 500 700 800 1000];
    
    for j = 1:length(num_of_framestep_for_RSE_array)

        num_of_framestep_for_RSE = num_of_framestep_for_RSE_array(j); 

        TPR_array = zeros(size(noise_level_array));
        FPR_array = zeros(size(noise_level_array));

        for i = 1:length(noise_level_array)

            noise_level = noise_level_array(i);
            fprintf('Current Noise Level: %d%%\n', noise_level*100);

            % get inference results and feature values
            results = infer(raw_audio_data, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
            inference_result = results(:, 1) - 1; % 0 - unvoiced; 1 - voiced
            features = results(:, 2:4);

            % load true labels
            label_name = strcat(label_path, audio_file, '_final_label_array.txt');
            final_label_array = csvread(label_name);
            % Fix the BUG: 
            % The number of framesteps of final_label_array is equal to the number of
            % framesteps of inference_result.
            % So I just remove the last framestep of final_label_array
            final_label_array = final_label_array(1:length(inference_result),:);

            % calculate the evaluation metrics
            [TPR, FPR, ACC, Precision, Recall, confusion_matrix] = compute_evaluation_metric(final_label_array, inference_result);

        %     fprintf('True Positive Rate: %.1f%%\n', TPR*100);
        %     fprintf('False Positive Rate: %.1f%%\n', FPR*100);
        %     fprintf('Accuracy: %.1f%%\n', ACC*100);
        %     fprintf('Precision: %.1f%%\n', Precision*100);
        %     fprintf('Recall: %.1f%%\n', Recall*100);

            TPR_array(i) = TPR;
            FPR_array(i) = FPR;

        end

        % plot the TPR-FPR curve
        figure;
        plot(noise_level_array,TPR_array,'b*-', noise_level_array,FPR_array,'rs-');
        title([audio_file, ' ', ': Number of Framesteps = ', num2str(num_of_framestep_for_RSE)], 'FontSize', 15);
        xlabel('Noise Level');
        ylabel('Performance');
        legend('TPR','FPR');

        % save the TPR-FPR curve
        saveas(gcf, [audio_file '_RSE_' num2str(num_of_framestep_for_RSE)], 'jpg');

    end





