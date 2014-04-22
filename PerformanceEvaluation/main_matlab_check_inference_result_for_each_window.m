

function main_matlab_check_inference_result_for_each_window (audio_file)

	%clear;
	%clear all;
	clc;

	% set up dataset path
	dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
	label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';
	% 1. silence
	% audio_file = 'silent_t1';
	% 2. speech
	% audio_file = 'speech_t2';
	% 3. classical music
	% audio_file = 'classical_t2';
	% 4. tv 
	% audio_file = 'tv_t5';
	% 5. pop music
	% audio_file = 'pop_t6';
	% 6. ambient sound
	% audio_file = 'ambient_t6';
	% 7. radio
	%audio_file = 'radio_t1';
	% 8. body sound
	% audio_file = 'bodysound_t7';

	% load raw audio data
	file_name = strcat(dataset_path, audio_file, '.wav');
	raw_audio_data = wavread(file_name);

	% set up parameters
	sampling_rate = 8192;
	framesize = 256;
	framestep = 128;
	num_of_framestep_for_RSE = 300; % number of framesteps for calculating Relative Spectral Entropy (RSE)
	noise_level = 0.02; % white noise level: 0.01 represents 1%.
	% starting_framestep = 500; % relative spectrual entropy needs to wait for 500 framesteps to be ready to compute.
	starting_framestep = 0; 
	total_num_of_framestep = floor(length(raw_audio_data)/framestep) - starting_framestep;
	num_of_framestep_in_one_window = 200;
	total_num_of_window = floor(total_num_of_framestep/num_of_framestep_in_one_window);
	labels = [];
	final_label_array = zeros(total_num_of_framestep, 1);

	% Show inference results and true labels window by window
		
	% get inference results and feature values
	results = infer(raw_audio_data, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
	inference_result = results(:, 1) - 1; % 0 - unvoiced; 1 - voiced
	features = results(:, 2:4);

	% load true labels
	label_name = strcat(label_path, audio_file, '_final_label_array.txt');
	final_label_array = csvread(label_name);
	% Fix the BUG: 
	% The number of framesteps of final_label_array is equal to the number of
	% framesteps of inference_result.
	% So I just remove the last framestep of final_label_array
	final_label_array = final_label_array(1:length(inference_result),:);

	for window_index = 1:1:total_num_of_window
		
		start_index = (starting_framestep + (window_index-1)*num_of_framestep_in_one_window) * framestep + 1;
		end_index = (starting_framestep + window_index*num_of_framestep_in_one_window) * framestep;
		data_in_window = raw_audio_data(start_index : end_index);
		specgram(data_in_window, framesize, framestep);
		
		start_index_for_frame = (starting_framestep + (window_index-1)*num_of_framestep_in_one_window) + 1;
		end_index_for_frame = (starting_framestep + window_index*num_of_framestep_in_one_window);
			
		% visualization
		figure;
		subplot(211)
		specgram(data_in_window, framesize, framestep);
		hold on
		plot(inference_result(start_index_for_frame:end_index_for_frame)*30,'b');
		hold off
		xlabel('Inference Result');
		axis tight
		subplot(212)
		specgram(data_in_window, framesize, framestep);
		hold on
		plot(final_label_array(start_index_for_frame:end_index_for_frame)*30,'k');
		hold off
		xlabel('True Labels');
		axis tight
		% put a single title for all subplots
		ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
		text(0.5, 1, [audio_file, ': Noise Level = ', num2str(noise_level), ', Number of Framesteps = ', num2str(num_of_framestep_for_RSE)], 'HorizontalAlignment','center', 'VerticalAlignment','top');

		% save
		% saveas(gcf, [audio_file '_inference_result_window_' num2str(window_index)], 'jpg');   
		saveas(gcf, [audio_file '_inference_result_RSE_' num2str(num_of_framestep_for_RSE) '_noise_level_' num2str(noise_level*100) '%' '_window_' num2str(window_index)], 'jpg');    

	end


    




