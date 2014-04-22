

function  frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, audio_file, number_of_features)
                
    warning off
    
    % import library 
    addpath('./lib/voicing/')
    addpath('./lib/HMM/')
    
    load global_parameters.mat;
    
    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';    

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);

    % calculate frame-level audio features
    features = audio_feature_extraction(raw_audio_data, framesize, framestep, noise_level, num_of_framestep_for_RSE);
            
    % do frame-level inference      
    inference_result = zeros(size(features,1), 1);  
    for frame_index = 1:size(features,1)
        
        features_in_this_frame = features(frame_index, 1:number_of_features);
                
        % test the Gaussian model            
        speech_probability = mvnpdf(features_in_this_frame, speech_voiced_gaussian_model.multivariate_mean, speech_voiced_gaussian_model.multivariate_cov);         
        speech_unvoiced_probability = mvnpdf(features_in_this_frame, speech_unvoiced_gaussian_model.multivariate_mean, speech_unvoiced_gaussian_model.multivariate_cov); 
        walk_probability = mvnpdf(features_in_this_frame, walk_gaussian_model.multivariate_mean, walk_gaussian_model.multivariate_cov); 
        bus_probability = mvnpdf(features_in_this_frame, bus_gaussian_model.multivariate_mean, bus_gaussian_model.multivariate_cov); 
        cafe_probability = mvnpdf(features_in_this_frame, cafe_gaussian_model.multivariate_mean, cafe_gaussian_model.multivariate_cov);        
        music_probability = mvnpdf(features_in_this_frame, music_gaussian_model.multivariate_mean, music_gaussian_model.multivariate_cov); 
        
        % method 1: maximum likelihood classification
        probability_array = [speech_probability, speech_unvoiced_probability, walk_probability, bus_probability, cafe_probability, music_probability];
        [max_probability, class_type] = max(probability_array);
        
%         if features_in_this_frame(1) <= 0.1 || features_in_this_frame(2) <= 2
%             inference_result(frame_index) = 0;
%         else
            if class_type == 1
                inference_result(frame_index) = 1;
            elseif class_type == 2
                inference_result(frame_index) = 0;
            elseif class_type == 3 
                inference_result(frame_index) = 0;
            elseif class_type == 4
                inference_result(frame_index) = 0;  
            elseif class_type == 5
                inference_result(frame_index) = 0;
            elseif class_type == 6
                inference_result(frame_index) = 0;    
            else
                fprintf('Should not reach here! Sth wrong!\n');
            end
%         end

%         % method 2: maximum likelihood + HMM classification
%         probability_array = [speech_unvoiced_probability, ambient_probability, music_probability];
%         [max_unvoiced_probability, class_type] = max(probability_array);
%         
%         B = [max_unvoiced_probability; speech_probability];
%         % B(1,:) is the nonvoiced likelihood
%         % B(2,:) is the voiced likelihood
%         % do inference and output inference results (P)
%         [P, loglik] = viterbi_path(prior, transmat, B);
%         % output results
%         inference_result(frame_index) = P' - 1; % 0 - unvoiced; 1 - voiced          
        
    end
            
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

	fprintf('True Positive Rate: %.1f%%\n', TPR);
	fprintf('False Positive Rate: %.1f%%\n', FPR);
	fprintf('Accuracy: %.1f%%\n', ACC);
	fprintf('Precision: %.1f%%\n', Precision);
	fprintf('Recall: %.1f%%\n', Recall);
        
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
    plot(final_label_array*30,'k');
    hold off
    xlabel('True Labels');
    axis tight
    % put a single title for all subplots
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1, [audio_file ': Frame Feature Model'], 'HorizontalAlignment','center', 'VerticalAlignment','top');

    % save the plot
    saveas(gcf, [audio_file '_frame_feature_individual_single_gaussian_model'], 'jpg'); 
    
    
    
    
    
        
    
                                          