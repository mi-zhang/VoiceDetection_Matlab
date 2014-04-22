

function main_matlab_generate_transition_matrix (audio_file)

    % clear;
    % clear all;
    clc;

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';
    % 1. silence
    % audio_file = 'silent_t1';
    % 2. speech
    % audio_file = 'speech_t3';
    % % 3. classical music
    % audio_file = 'classical_t3';
    % 4. tv 
    % audio_file = 'tv_t5';
    % 5. pop music
    % audio_file = 'pop_t6';
    % 6. ambient sound
    % audio_file = 'ambient_t6';
    % 7. radio
    % audio_file = 'radio_t1';
    % 8. body sound
    % audio_file = 'bodysound_t7';

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);

    % set up parameters
    sampling_rate = 8192;
    framesize = 256; % 31.25ms
    framestep = 128; % 15.625ms
    num_of_framestep_for_RSE = 300; % number of framesteps for calculating Relative Spectral Entropy (RSE)
    noise_level = 0.02; % white noise level: 0.01 represents 1%.
    LF_HF_ratio_threshold = 5;
    voiced_liklihood_threshold = -1;
    
    % get inference results and feature values
    results = infer(raw_audio_data, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    inference_result = results(:, 1) - 1; % 0 - unvoiced; 1 - voiced
    LF_HF_ratio = results(:, 8);
    nonvoiced_liklihood = results(:, 9);
    voiced_liklihood = results(:, 10);
    
    % load true labels
    label_name = strcat(label_path, audio_file, '_final_label_array.txt');
    final_label_array = csvread(label_name);
    % Fix the BUG: 
    % The number of framesteps of final_label_array is equal to the number of
    % framesteps of inference_result.
    % So I just remove the last framestep of final_label_array
    final_label_array = final_label_array(1:length(inference_result),:);

    % create a second-layer classifier based on the LF / HF energy ratio and the voiced likelihood    
    inference_result_2nd_layer = inference_result;
    for i = 1:length(inference_result_2nd_layer)
        if inference_result(i) == 1
            if LF_HF_ratio(i) <= LF_HF_ratio_threshold || log10(voiced_liklihood(i)) <= voiced_liklihood_threshold
                inference_result_2nd_layer(i) = 0;
            end        
        end    
    end

    % plot the inference results
    figure;
    subplot(211)
    specgram(raw_audio_data, framesize, framestep);
    hold on
    plot(inference_result*30,'b');
    hold off
    xlabel('Inference Result');
    axis tight
    subplot(212)
    specgram(raw_audio_data, framesize, framestep);
    hold on
    plot(inference_result_2nd_layer*30,'k');
    hold off
    xlabel('Inference Result 2nd Layer');
    axis tight
    % put a single title for all subplots
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1, [audio_file, ': LF / HF Ratio: ', num2str(LF_HF_ratio_threshold), ' Voiced Likelihood: ', num2str(voiced_liklihood_threshold)], 'HorizontalAlignment','center', 'VerticalAlignment','top');

    % save the plot
    saveas(gcf, [audio_file '_1KHz_energy_ratio_threshold_' num2str(LF_HF_ratio_threshold) '_likelihood_' num2str(voiced_liklihood_threshold)], 'jpg');    
    
    % calculate the transition matrix on top of the frame-level 2nd layer
    % inference result  
    num_of_framestep_for_each_window = 20; % 15.625ms * 20 = 312.5ms
    window_step = 10;
    transition_matrix_array = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_2nd_layer);
    
    % save the results
    save([audio_file '_transition_matrix_array'], 'transition_matrix_array');
    fileID = fopen([audio_file '_transition_matrix_array.txt'],'w');
    fprintf(fileID, '%d %d %d %d\n', transition_matrix_array');
    
    fprintf('I am done!\n');

   


    




