

function compare_feature_between_Mi_Rui ()

    audio_file = '1398719349_358239057380463';
    
    % set up dataset path
    dataset_path = '';    

    % Mi:
    % load feature data calculated by Mi     
    file_name = strcat(dataset_path, audio_file, '_android_features.txt');
    % audio frame, voicing features, observation probabilities, inference results
    data = csvread(file_name);   
    audio_raw_data = data(:, 1:256);
    observation_probabilities = data(:, 263:264);    
    inference_results_array = data(:, 265:284);
    feature_array = data(:, 257:262);
    % 
    % fVector[0] = numAcorrPeaks; 
	% fVector[1] = maxAcorrPeakVal;
	% fVector[2] = maxAcorrPeakLag;
	% fVector[3] = spectral_entropy;
	% fVector[4] = relSpecEntr;
	% fVector[5] = energy;    
    features = feature_array(:, [2,1,5]);
    
    % Rui:
    % load feature data calculated by Rui        
    % load feature data
    file_name2 = strcat(dataset_path, audio_file, '.FeatAndInference');
    data2 = csvread(file_name2);   
    timestamp = data2(:, 1);
    frame_ID = data2(:, 2);
    frame_ID = data2(:, 2);
    features2 = data2(:, [4,3,5]);
        
    % plot
    figure;
    plot(features(201:500, 1), '--b')
    hold on
    plot(features2(201:500, 1), ':r')
    hold off
    legend('Mi','Rui')
    title('f1 (maxAcorrPeakVal)')
    axis tight
    
    % save the plot
    saveas(gcf, ['feature_comparison_Mi_Rui_f1'], 'jpg');
    
    figure;
    plot(features(201:500, 2), '--b')
    hold on
    plot(features2(201:500, 2), ':r')
    hold off
    legend('Mi','Rui')
    title('f2 (numAcorrPeaks)')
    axis tight
    
    % save the plot
    saveas(gcf, ['feature_comparison_Mi_Rui_f2'], 'jpg');
    
    figure;
    plot(features(201:500, 3), '--b')
    hold on
    plot(features2(201:500, 3), ':r')
    hold off
    legend('Mi','Rui')
    title('f3 (RSE)')
    axis tight
    
    % save the plot
    saveas(gcf, ['feature_comparison_Mi_Rui_f3'], 'jpg');
    
    disp('I am done');
    
    
    
    
    
    
    
    
    
    
    
    
    