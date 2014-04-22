

function  fixed_window_feature_model_test (gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, audio_file, window_size)

                
    load global_parameters.mat;
    
    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';    

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);
    
    % do frame-level inference
    [inference_result final_label_array features] = do_inference(audio_file);
    
    % segment windows and generate window-level features
    window_step = window_size/2;                             
%     total_num_of_window = 1 + floor((size(features, 1) - window_size) / window_step);
    total_num_of_window = floor(length(inference_result)/window_size);
    classification_result = zeros(total_num_of_window*window_size, 1);  
    
    for window_index = 1:1:total_num_of_window

        features_in_this_window = features(1+(window_index-1)*window_step : (window_index-1)*window_step + window_size, :);                
        
        % 1. variance of ZCR
        zcr_var = var(features_in_this_window(:,8));
        
        % 2. percentage of low energy frames
        mean_RMS = mean(features_in_this_window(:,6));
        low_energy_frame_num = 0;
        for i = 1:length(features_in_this_window(:,6))
            if features_in_this_window(i,6) < mean_RMS / 2
                low_energy_frame_num = low_energy_frame_num + 1;
            end
        end
        percentage_low_energy_frame = low_energy_frame_num / length(features_in_this_window(:,6));
        
        % 3. variance of spectral flux
        sf_var = var(features_in_this_window(:,5));
        
        % 4. mean of max(peakvals)
        max_peakvals = mean(features_in_this_window(:,1));
        
        % 5. mean of length(peaks)
        peak_length = mean(features_in_this_window(:,2));
              
        window_level_feature_vector = [zcr_var, percentage_low_energy_frame, sf_var, max_peakvals, peak_length];
        
        % test the Gaussian model
        % class 1: Speech
        speech_probability = mvnpdf(window_level_feature_vector, gaussian_model_s.multivariate_mean, gaussian_model_s.multivariate_cov); 
        % class 2: Ambient
        % - 'silent'
        silent_probability = mvnpdf(window_level_feature_vector, gaussian_model_silent.multivariate_mean, gaussian_model_silent.multivariate_cov);         
        % - 'walk'
        walk_probability = mvnpdf(window_level_feature_vector, gaussian_model_w.multivariate_mean, gaussian_model_w.multivariate_cov); 
        % - 'bus'
        bus_probability = mvnpdf(window_level_feature_vector, gaussian_model_b.multivariate_mean, gaussian_model_b.multivariate_cov); 
        % class 3: Music
        % - 'classical'
        classical_probability = mvnpdf(window_level_feature_vector, gaussian_model_c.multivariate_mean, gaussian_model_c.multivariate_cov); 
        % - 'pop'
        pop_probability = mvnpdf(window_level_feature_vector, gaussian_model_p.multivariate_mean, gaussian_model_p.multivariate_cov); 

        % maximum likelihood classification
        probability_array = [speech_probability, silent_probability, bus_probability, walk_probability, classical_probability, pop_probability];
        [max_probability, class_type] = max(probability_array);
               
        if class_type == 1 % speech
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 1;
        elseif class_type == 2 % silent
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;
        elseif class_type == 3 % bus
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;
        elseif class_type == 4 % walk
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;
        elseif class_type == 5 % classical
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;
        elseif class_type == 6 % pop
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;
        else
            fprintf('Should not reach here! Sth wrong!\n');
        end

        
%         if speech_probability >= classical_probability && speech_probability >= pop_probability && speech_probability >= silent_probability
%             classification_result(1+(window_index-1)*window_size: window_index*window_size) = 1;
%         elseif classical_probability >= speech_probability && classical_probability >= pop_probability && classical_probability >= silent_probability
%             classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;
%         elseif pop_probability >= speech_probability && pop_probability >= classical_probability && pop_probability >= silent_probability
%             classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;  
%         elseif silent_probability >= speech_probability && silent_probability >= classical_probability && silent_probability >= pop_probability
%             classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;    
%         else
%             fprintf('Should not reach here! Sth wrong!\n');
%         end
%         
    end
    
    % calculate the evaluation metrics
    % NOTE: the last imcomplete window is ignored.
    final_label_array = final_label_array(1:total_num_of_window*window_size, :);
	[TPR, FPR, ACC, Precision, Recall, confusion_matrix] = compute_evaluation_metric(final_label_array, classification_result);

	fprintf('True Positive Rate: %.1f%%\n', TPR);
	fprintf('False Positive Rate: %.1f%%\n', FPR);
	fprintf('Accuracy: %.1f%%\n', ACC);
	fprintf('Precision: %.1f%%\n', Precision);
	fprintf('Recall: %.1f%%\n', Recall);
        
    % plot the inference results
    figure;
    subplot(211)
%     specgram(raw_audio_data, framesize, framestep);
%     hold on
%     plot(inference_result*30,'b');
%     hold off
%     xlabel('Inference Result - Frame Level');
%     axis tight
%     subplot(212)
    specgram(raw_audio_data, framesize, framestep);
    hold on
    plot(classification_result*30,'b');
    hold off
    xlabel('Inference Result - Window Level');
    axis tight
    subplot(212)
	specgram(raw_audio_data, framesize, framestep);
	hold on
	plot(final_label_array*30,'k');
    hold off
	xlabel('True Labels');
	axis tight
    % put a single title for all subplots
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1, [audio_file ': Fixed Window Window Feature Model'], 'HorizontalAlignment','center', 'VerticalAlignment','top');

    % save the plot
    saveas(gcf, [audio_file '_fixed_window_window_feature_model'], 'jpg'); 
    
    
    
    
    
        
    
                                          