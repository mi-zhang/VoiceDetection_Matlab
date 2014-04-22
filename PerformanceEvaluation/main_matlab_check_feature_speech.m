

function main_matlab_check_feature_speech (audio_file, feature_select)

    clc;

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);

   % load global parameters
    load global_parameters.mat;

    % get inference results and feature values
    results = infer(raw_audio_data, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    inference_result = results(:, 1) - 1; % 0 - unvoiced; 1 - voiced
    features = results(:, 4:11);

    % load true labels
    label_name = strcat(label_path, audio_file, '_final_label_array.txt');
    final_label_array = csvread(label_name);
    % Fix the BUG: 
    % The number of framesteps of final_label_array is equal to the number of
    % framesteps of inference_result.
    % So I just remove the last framestep of final_label_array
    final_label_array = final_label_array(1:length(inference_result),:);

    % DEBUG
%     final_label_array = final_label_array(1:200);
%     inference_result = inference_result(1:200);

    % calculate the evaluation metrics
    [TPR, FPR, ACC, Precision, Recall, confusion_matrix] = compute_evaluation_metric(final_label_array, inference_result);

    fprintf('True Positive Rate: %.1f%%\n', TPR);
    fprintf('False Positive Rate: %.1f%%\n', FPR);
    fprintf('Accuracy: %.1f%%\n', ACC);
    fprintf('Precision: %.1f%%\n', Precision);
    fprintf('Recall: %.1f%%\n', Recall);
    
    % visualization
    figure;
    subplot(311)
    specgram(raw_audio_data, framesize, framestep);
    switch(feature_select)
        case 1
            hold on
            plot(features(:,1)*60);
            hold off
            xlabel('Non-Initial Auto-correlation Peak');
            axis tight            
        case 2
            hold on
            plot(features(:,2));
            hold off
            xlabel('Number of Auto-correlation Peaks');
            axis tight        
        case 3
            hold on
            plot(features(:,3)*60);    
            hold off
            xlabel('Relative Spectral Entropy');
            axis tight        
        case 7
            hold on
            plot(features(:,7));    
            hold off
            xlabel('LF / HF');
            axis tight    
        case 8
            hold on
            plot(features(:,8)*120);    
            hold off
            xlabel('ZCR');
            axis tight      
        otherwise
            fprintf('Unexpected feature type.\n');
    end
    subplot(312)
    specgram(raw_audio_data, framesize, framestep);
    hold on
    plot(inference_result*30,'b');
    hold off
    xlabel('Inference Result');
    axis tight
    subplot(313)
    specgram(raw_audio_data, framesize, framestep);
    hold on
    plot(final_label_array*30,'k');
    hold off
    xlabel('True Labels');
    axis tight
    % put a single title for all subplots
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1, [audio_file, ': noise level equals to ', num2str(noise_level), ', number of framesteps equals to ', num2str(num_of_framestep_for_RSE)], 'HorizontalAlignment','center', 'VerticalAlignment','top');

    % save the curve
    saveas(gcf, [audio_file  '_feature_' num2str(feature_select)], 'jpg');
    
    % Speech
    feature_for_voiced_frames = [];
    for i = 1:length(final_label_array)
        if (final_label_array(i) == 1)        
            feature_for_voiced_frames = [feature_for_voiced_frames, features(i, feature_select)];                   
        end    
    end
    feature_for_voiced_frames = feature_for_voiced_frames';    
    
    % Non-Speech
%     feature_for_voiced_frames = features(:, feature_select);
    
    % plot the histogram
    figure;
    switch(feature_select)
        case 1
            hist(feature_for_voiced_frames*60);
            xlabel('Non-Initial Auto-correlation Peak');
            axis tight            
        case 2
            hist(feature_for_voiced_frames);
            xlabel('Number of Auto-correlation Peaks');
            axis tight        
        case 3
            hist(feature_for_voiced_frames*60);    
            xlabel('Relative Spectral Entropy');
            axis tight        
        case 7
            hist(feature_for_voiced_frames);    
            xlabel('LF / HF');
            axis tight
        case 8
            hist(feature_for_voiced_frames);    
            xlabel('ZCR');
            axis tight    
        otherwise
            fprintf('Unexpected feature type.\n');
    end
    title([audio_file ' Feature ' num2str(feature_select) ' Histogram']);
    
    % save the histogram
    saveas(gcf, [audio_file '_feature_' num2str(feature_select) '_histogram'], 'jpg');
    
    
    
    


