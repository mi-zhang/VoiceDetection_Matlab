

function  main_matlab_check_fixed_window_markov_model_test (transition_probability_matrix_classical, transition_probability_matrix_pop, transition_probability_matrix_speech, transition_probability_matrix_silent, audio_file, inference_result, window_size)


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
        
        for index = 1 : length(inference_result_in_this_window)-1                        
            if (inference_result_in_this_window(index) == 0) && (inference_result_in_this_window(index+1) == 0)
                silent_probability = silent_probability * transition_probability_matrix_silent(1,1);
                classical_probability = classical_probability * transition_probability_matrix_classical(1,1);
                pop_probability = pop_probability * transition_probability_matrix_pop(1,1);
                speech_probability = speech_probability * transition_probability_matrix_speech(1,1);
            elseif (inference_result_in_this_window(index) == 0) && (inference_result_in_this_window(index+1) == 1)
                silent_probability = silent_probability * transition_probability_matrix_silent(1,2);
                classical_probability = classical_probability * transition_probability_matrix_classical(1,2);
                pop_probability = pop_probability * transition_probability_matrix_pop(1,2);
                speech_probability = speech_probability * transition_probability_matrix_speech(1,2);
            elseif (inference_result_in_this_window(index) == 1) && (inference_result_in_this_window(index+1) == 0)
                silent_probability = silent_probability * transition_probability_matrix_silent(2,1);
                classical_probability = classical_probability * transition_probability_matrix_classical(2,1);
                pop_probability = pop_probability * transition_probability_matrix_pop(2,1);
                speech_probability = speech_probability * transition_probability_matrix_speech(2,1);
            elseif (inference_result_in_this_window(index) == 1) && (inference_result_in_this_window(index+1) == 1)
                silent_probability = silent_probability * transition_probability_matrix_silent(2,2);
                classical_probability = classical_probability * transition_probability_matrix_classical(2,2);
                pop_probability = pop_probability * transition_probability_matrix_pop(2,2);
                speech_probability = speech_probability * transition_probability_matrix_speech(2,2);
            else
                fprintf('Should not reach here! Sth wrong!\n');
            end
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
    text(0.5, 1, [audio_file ': Fixed Window Markov Model'], 'HorizontalAlignment','center', 'VerticalAlignment','top');

    % save the plot
    saveas(gcf, [audio_file '_fixed_window_markov_model'], 'jpg');  
    
    
        
    
                                          