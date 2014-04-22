

function  frame_feature_HMM_model_test (audio_file, number_of_features) 

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
    
    % load trained voice detection HMM model parameters
    load voicing_parameters.mat
        
    % calculate the likelihood (B)
    B = mk_ghmm_obs_lik(features(:, 1:number_of_features)', speech_mu, speech_cov);
    % B(1,:) is the nonvoiced likelihood
    % B(2,:) is the voiced likelihood

    % do inference and output inference results (P)
    [P, loglik] = viterbi_path(prior, transmat, B);

    % output results
    inference_result = P' - 1; % 0 - unvoiced; 1 - voiced  

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
    
    % save the results
    fName = 'performance_single_gaussian_HMM.txt';         
    fid = fopen(fName, 'a');            
    if fid ~= -1
        fprintf(fid,'%s\r\n', audio_file);  
%         fprintf(fid,'%s\r\n', 'TPR, FPR, Accuracy, Precision, Recall');
        fclose(fid);                     
    end
    dlmwrite(fName, [TPR, FPR, ACC, Precision, Recall], '-append',...  
         'delimiter', ',',...
         'newline', 'pc');
     
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
    text(0.5, 1, [audio_file ': Frame Feature HMM Model'], 'HorizontalAlignment','center', 'VerticalAlignment','top');

    % save the plot
    saveas(gcf, [audio_file '_frame_feature_HMM_model'], 'jpg');
    
                
    
    
    
    
        
    
                                          