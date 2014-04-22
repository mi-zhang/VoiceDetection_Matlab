

function  main_matlab_check_fixed_window_histogram_model_test (hist_silent, hist_c, hist_s, hist_p, audio_file, inference_result, window_size)


    % load global parameters
    load global_parameters.mat;
%     % set up parameters
%     sampling_rate = 8192;
%     framesize = 256;
%     framestep = 128;
    
    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';    

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);
    
    % load true labels
	label_name = strcat(label_path, audio_file, '_final_label_array.txt');
	final_label_array = csvread(label_name);
	% Fix the BUG: 
	% The number of framesteps of final_label_array is equal to the number of
	% framesteps of inference_result.
	% So I just remove the last framestep of final_label_array
	final_label_array = final_label_array(1:length(inference_result),:);
    
    % test
    % TODO: consider the 50% window overlap
    % NOTE: the last imcomplete window is ignored.
    total_num_of_window = floor(length(inference_result)/window_size);
    classification_result = zeros(total_num_of_window*window_size, 1);    

    for window_index = 1:1:total_num_of_window

        inference_result_in_this_window = inference_result(1+(window_index-1)*window_size : window_index*window_size);
        
        silent_probability = 1;
        classical_probability = 1;
        pop_probability = 1;
        speech_probability = 1;
                
        % calculate transition matrix
        zero_to_zero = 0;
        zero_to_one = 0;
        one_to_zero = 0;
        one_to_one = 0;
        
        for index = 1 : length(inference_result_in_this_window)-1
            if (inference_result_in_this_window(index) == 0) && (inference_result_in_this_window(index+1) == 0)
                zero_to_zero = zero_to_zero + 1;
            elseif (inference_result_in_this_window(index) == 0) && (inference_result_in_this_window(index+1) == 1)
                zero_to_one = zero_to_one + 1;
            elseif (inference_result_in_this_window(index) == 1) && (inference_result_in_this_window(index+1) == 0)
                one_to_zero = one_to_zero + 1;
            elseif (inference_result_in_this_window(index) == 1) && (inference_result_in_this_window(index+1) == 1)
                one_to_one = one_to_one + 1;
            else
                fprintf('Should not reach here! Sth wrong!\n');
            end
        end                
        
        % fit the heuristic histogram model
        if zero_to_zero <= 5
            silent_probability = silent_probability * hist_silent(1, 1);
            classical_probability = classical_probability * hist_c(1, 1);
            pop_probability = pop_probability * hist_p(1, 1);
            speech_probability = speech_probability * hist_s(1, 1);
        elseif zero_to_zero >= 50
            silent_probability = silent_probability * hist_silent(1, 2);
            classical_probability = classical_probability * hist_c(1, 2);
            pop_probability = pop_probability * hist_p(1, 2);
            speech_probability = speech_probability * hist_s(1, 2);
        else
            silent_probability = silent_probability * hist_silent(1, 3);
            classical_probability = classical_probability * hist_c(1, 3);
            pop_probability = pop_probability * hist_p(1, 3);
            speech_probability = speech_probability * hist_s(1, 3);
        end
        
        if zero_to_one == 0
            silent_probability = silent_probability * hist_silent(2, 1);
            classical_probability = classical_probability * hist_c(2, 1);
            pop_probability = pop_probability * hist_p(2, 1);
            speech_probability = speech_probability * hist_s(2, 1);
        elseif zero_to_one == 1
            silent_probability = silent_probability * hist_silent(2, 2);
            classical_probability = classical_probability * hist_c(2, 2);
            pop_probability = pop_probability * hist_p(2, 2);
            speech_probability = speech_probability * hist_s(2, 2);
        else
            silent_probability = silent_probability * hist_silent(2, 3);
            classical_probability = classical_probability * hist_c(2, 3);
            pop_probability = pop_probability * hist_p(2, 3);
            speech_probability = speech_probability * hist_s(2, 3);
        end
        
        if one_to_zero == 0
            silent_probability = silent_probability * hist_silent(3, 1);
            classical_probability = classical_probability * hist_c(3, 1);
            pop_probability = pop_probability * hist_p(3, 1);
            speech_probability = speech_probability * hist_s(3, 1);
        elseif one_to_zero == 1
            silent_probability = silent_probability * hist_silent(3, 2);
            classical_probability = classical_probability * hist_c(3, 2);
            pop_probability = pop_probability * hist_p(3, 2);
            speech_probability = speech_probability * hist_s(3, 2);
        else
            silent_probability = silent_probability * hist_silent(3, 3);
            classical_probability = classical_probability * hist_c(3, 3);
            pop_probability = pop_probability * hist_p(3, 3);
            speech_probability = speech_probability * hist_s(3, 3);
        end
        
        if one_to_one <= 5
            silent_probability = silent_probability * hist_silent(4, 1);
            classical_probability = classical_probability * hist_c(4, 1);
            pop_probability = pop_probability * hist_p(4, 1);
            speech_probability = speech_probability * hist_s(4, 1);
        elseif one_to_one >= 50
            silent_probability = silent_probability * hist_silent(4, 2);
            classical_probability = classical_probability * hist_c(4, 2);
            pop_probability = pop_probability * hist_p(4, 2);
            speech_probability = speech_probability * hist_s(4, 2);
        else
            silent_probability = silent_probability * hist_silent(4, 3);
            classical_probability = classical_probability * hist_c(4, 3);
            pop_probability = pop_probability * hist_p(4, 3);
            speech_probability = speech_probability * hist_s(4, 3);
        end 
                        
        % maximum likelihood classification
        if speech_probability >= classical_probability && speech_probability >= pop_probability && speech_probability >= silent_probability
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 1;
        elseif classical_probability >= speech_probability && classical_probability >= pop_probability && classical_probability >= silent_probability
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;
        elseif pop_probability >= speech_probability && pop_probability >= classical_probability && pop_probability >= silent_probability
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;  
        elseif silent_probability >= speech_probability && silent_probability >= classical_probability && silent_probability >= pop_probability
            classification_result(1+(window_index-1)*window_size: window_index*window_size) = 0;    
        else
            fprintf('Should not reach here! Sth wrong!\n');
        end
        
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
    specgram(raw_audio_data, framesize, framestep);
    hold on
    plot(inference_result*30,'b');
    hold off
    xlabel('Inference Result');
    axis tight
    subplot(212)
    specgram(raw_audio_data, framesize, framestep);
    hold on
    plot(classification_result*30,'k');
    hold off
    xlabel('Inference Result 2nd Layer');
    axis tight
    % put a single title for all subplots
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1, [audio_file ': Fixed Window Histogram Model'], 'HorizontalAlignment','center', 'VerticalAlignment','top');

    % save the plot
    saveas(gcf, [audio_file '_fixed_window_histogram_model'], 'jpg');  
    
    
        
    
                                          