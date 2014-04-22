

function main_matlab_check_energy_ratio_true_positive_rate (audio_file)

    clc;

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);

    % load global parameters
    load global_parameters.mat;
%     % set up parameters
%     sampling_rate = 8192;
%     framesize = 256;
%     framestep = 128;
%     num_of_framestep_for_RSE = 300; % number of framesteps for calculating Relative Spectral Entropy (RSE)
%     noise_level = 0.02; % white noise level: 0.01 represents 1%.

    % get inference results and feature values
    results = infer(raw_audio_data, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    inference_result = results(:, 1) - 1; % 0 - unvoiced; 1 - voiced
    nonvoiced_liklihood = results(:, 2);
    voiced_liklihood = results(:, 3);
    features = results(:, 4:11);
    LF_HF_ratio = features(:, 7);   

    % load true labels
    label_name = strcat(label_path, audio_file, '_final_label_array.txt');
    final_label_array = csvread(label_name);
    % Fix the BUG: 
    % The number of framesteps of final_label_array is equal to the number of
    % framesteps of inference_result.
    % So I just remove the last framestep of final_label_array
    final_label_array = final_label_array(1:length(inference_result),:);

    % create a second-layer classifier based on the LF / HF energy ratio 
    LF_HF_ratio_threshold_array = [1 3 5 10 15 20 40 60 80 100];
    TPR_array = zeros(size(LF_HF_ratio_threshold_array));

    for j = 1:length(LF_HF_ratio_threshold_array)

        LF_HF_ratio_threshold = LF_HF_ratio_threshold_array(j);
        inference_result_2nd_layer = inference_result;
        % filter out true positive based on LF_HF_ratio_threshold
        for i = 1:length(inference_result_2nd_layer)
            if inference_result(i) == 1
                if LF_HF_ratio(i) <= LF_HF_ratio_threshold
                    inference_result_2nd_layer(i) = 0;
                end        
            end    
        end

        % calculate the evaluation metrics
        [TPR, FPR, ACC, Precision, Recall, confusion_matrix] = compute_evaluation_metric(final_label_array, inference_result_2nd_layer);    
        TPR_array(j) = TPR;

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
        text(0.5, 1, [audio_file, ': LF / HF Ratio: ', num2str(LF_HF_ratio_threshold)], 'HorizontalAlignment','center', 'VerticalAlignment','top');

        % save the plot
        saveas(gcf, [audio_file '_1KHz_energy_ratio_threshold_' num2str(LF_HF_ratio_threshold)], 'jpg');    

    end

    % plot the TPR curve
    figure;
    plot(LF_HF_ratio_threshold_array, TPR_array, 'rs-');
    title([audio_file, ': LF / HF Ratio Feature Setting: 1KHz'], 'FontSize', 18);
    xlabel('LF / HF Ratio');
    ylabel('True Positive Rate (%)');

    % save the TPR curve
    saveas(gcf, [audio_file '_1KHz_energy_ratio_TPR'], 'jpg');    


    




