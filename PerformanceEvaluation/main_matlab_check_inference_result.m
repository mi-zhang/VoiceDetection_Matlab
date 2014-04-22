

function main_matlab_check_inference_result (audio_file)

% 	clc;
				
	% set up dataset path
	dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
	label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';

	% load raw audio data
	file_name = strcat(dataset_path, audio_file, '.wav');
	raw_audio_data = wavread(file_name);

	% set up parameters
	sampling_rate = 8192;
	framesize = 256;
	framestep = 128;
	num_of_framestep_for_RSE = 300; % number of framesteps for calculating Relative Spectral Entropy (RSE)
	noise_level = 0.02; % white noise level: 0.01 represents 1%.

	% get inference results and feature values	    
    results = infer(raw_audio_data, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    inference_result = results(:, 1) - 1; % 0 - unvoiced; 1 - voiced     
    nonvoiced_liklihood = results(:, 2);
    voiced_liklihood = results(:, 3);
    features = results(:, 4:11);

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
		
	% visualization
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
	text(0.5, 1, [audio_file, ': Noise Level = ', num2str(noise_level), ', Number of Framesteps = ', num2str(num_of_framestep_for_RSE)], 'HorizontalAlignment','center', 'VerticalAlignment','top');

	% save
	saveas(gcf, [audio_file '_inference_result_RSE_' num2str(num_of_framestep_for_RSE) '_noise_level_' num2str(noise_level*100) '%'], 'jpg');    



