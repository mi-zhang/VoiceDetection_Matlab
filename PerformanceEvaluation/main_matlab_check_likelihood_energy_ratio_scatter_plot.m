

function main_matlab_check_likelihood_energy_ratio_scatter_plot (audio_file_1, audio_file_2)

    clc;

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';

    % load raw audio data
    file_name_1 = strcat(dataset_path, audio_file_1, '.wav');
    raw_audio_data_1 = wavread(file_name_1);

    file_name_2 = strcat(dataset_path, audio_file_2, '.wav');
    raw_audio_data_2 = wavread(file_name_2);

    % load global parameters
    load global_parameters.mat;
%     % set up parameters
%     sampling_rate = 8192;
%     framesize = 256;
%     framestep = 128;
%     num_of_framestep_for_RSE = 300; % number of framesteps for calculating Relative Spectral Entropy (RSE)
%     noise_level = 0.02; % white noise level: 0.01 represents 1%.

    % get inference results and feature values
    results_1 = infer(raw_audio_data_1, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    inference_result_1 = results_1(:, 1) - 1; % 0 - unvoiced; 1 - voiced
    nonvoiced_liklihood_1 = results_1(:, 2);
    voiced_liklihood_1 = results_1(:, 3);
    features_1 = results_1(:, 4:11);
    LF_HF_ratio_1 = features_1(:, 7);

    results_2 = infer(raw_audio_data_2, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    inference_result_2 = results_2(:, 1) - 1; % 0 - unvoiced; 1 - voiced
    nonvoiced_liklihood_2 = results_2(:, 2);
    voiced_liklihood_2 = results_2(:, 3);
    features_2 = results_2(:, 4:11);
    LF_HF_ratio_2 = features_2(:, 7);

    % load true labels
    label_name_1 = strcat(label_path, audio_file_1, '_final_label_array.txt');
    final_label_array_1 = csvread(label_name_1);
    % Fix the BUG: 
    % The number of framesteps of final_label_array is equal to the number of
    % framesteps of inference_result.
    % So I just remove the last framestep of final_label_array
    final_label_array_1 = final_label_array_1(1:length(inference_result_1),:);

    label_name_2 = strcat(label_path, audio_file_2, '_final_label_array.txt');
    final_label_array_2 = csvread(label_name_2);
    % Fix the BUG: 
    % The number of framesteps of final_label_array is equal to the number of
    % framesteps of inference_result.
    % So I just remove the last framestep of final_label_array
    final_label_array_2 = final_label_array_2(1:length(inference_result_2),:);

    % Speech
    liklihood_for_voiced_frames_1 = [];
    LF_HF_ratio_for_voiced_frames_1 = [];
    for i = 1:length(final_label_array_1)
        if (final_label_array_1(i) == 1)        
            liklihood_for_voiced_frames_1 = [liklihood_for_voiced_frames_1, voiced_liklihood_1(i)];
            LF_HF_ratio_for_voiced_frames_1 = [LF_HF_ratio_for_voiced_frames_1, LF_HF_ratio_1(i)];       
        end    
    end
    liklihood_for_voiced_frames_1 = liklihood_for_voiced_frames_1';
    LF_HF_ratio_for_voiced_frames_1 = LF_HF_ratio_for_voiced_frames_1';

    % Speech
%     liklihood_for_voiced_frames_2 = [];
%     LF_HF_ratio_for_voiced_frames_2 = [];
%     for i = 1:length(final_label_array_2)
%         if (final_label_array_2(i) == 1)        
%             liklihood_for_voiced_frames_2 = [liklihood_for_voiced_frames_2, voiced_liklihood_2(i)];
%             LF_HF_ratio_for_voiced_frames_2 = [LF_HF_ratio_for_voiced_frames_2, LF_HF_ratio_2(i)];       
%         end    
%     end
%     liklihood_for_voiced_frames_2 = liklihood_for_voiced_frames_2';
%     LF_HF_ratio_for_voiced_frames_2 = LF_HF_ratio_for_voiced_frames_2';
    
    % Non-speech
    liklihood_for_voiced_frames_2 = voiced_liklihood_2;
    LF_HF_ratio_for_voiced_frames_2 = LF_HF_ratio_2;

    % plot the scatter plot
    figure;
    scatter(log10(liklihood_for_voiced_frames_1), LF_HF_ratio_for_voiced_frames_1);
    hold on;
    scatter(log10(liklihood_for_voiced_frames_2), LF_HF_ratio_for_voiced_frames_2);
    xlabel('Voiced Likelihood (log10)');
    ylabel('LF / HF');
    % Speech
%     legend('Speech 1', 'Speech 2')
    % Non-speech
    legend('Speech', 'Non-speech')    
    title([audio_file_1 ' vs. ' audio_file_2 ' Energy Ratio vs. Voiced Likelihood Scatter Plot']);
    axis tight

    % save the scatter plot
    saveas(gcf, [audio_file_1 '_'  audio_file_2 '_energy_ratio_likelihood_scatter_plot'], 'jpg');    


    




