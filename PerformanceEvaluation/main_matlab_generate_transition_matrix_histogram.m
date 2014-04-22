

function main_matlab_generate_transition_matrix_histogram (audio_file)

    % clear;
    % clear all;
    clc;

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Results\TransitionMatrix\1KHz_LFHF_5_Likelihood_-1\';
    % 1. silence
    % audio_file = 'silent_t1';
    % 2. speech
    % audio_file = 'speech_t3';
    % % 3. classical music
    % audio_file = 'classical_t3';
    % 4. tv 
    % audio_file = 'tv_t5';
    % 5. pop music
    % audio_file = 'pop_t6';
    % 6. ambient sound
    % audio_file = 'ambient_t6';
    % 7. radio
    % audio_file = 'radio_t1';
    % 8. body sound
    % audio_file = 'bodysound_t7';

    % load mat file 1
    file_name_1 = strcat(dataset_path, audio_file, '_transition_matrix_array.mat');
    temp = load(file_name_1);
    transition_matrix_array_1 = temp.transition_matrix_array;
    
    zero_to_zero_array_1 = [];
    zero_to_one_array_1 = [];
    one_to_zero_array_1 = [];
    one_to_one_array_1 = [];
    
    % 
    for i = 1:size(transition_matrix_array_1,1)
    
        % filter out useless windows
        if (transition_matrix_array_1(i,2) > 0) || (transition_matrix_array_1(i,3) > 0) || (transition_matrix_array_1(i,4) > 0)
        
            zero_to_zero_array_1 = [zero_to_zero_array_1; transition_matrix_array_1(i,1)];
            zero_to_one_array_1 = [zero_to_one_array_1; transition_matrix_array_1(i,2)];
            one_to_zero_array_1 = [one_to_zero_array_1; transition_matrix_array_1(i,3)];
            one_to_one_array_1 = [one_to_one_array_1; transition_matrix_array_1(i,4)];        
            
        end
        
    end
    
    % plot the histograms
    figure;
    subplot(2,2,1)
    hist(zero_to_zero_array_1);
    xlabel('Zero to Zero');
    axis tight
    subplot(2,2,2)
    hist(zero_to_one_array_1);
    xlabel('Zero to One');
    axis tight
    subplot(2,2,3)
    hist(one_to_zero_array_1);
    xlabel('One to Zero');
    axis tight 
    subplot(2,2,4)
    hist(one_to_one_array_1);
    xlabel('One to One');
    axis tight
    % put a single title for all subplots
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1, [audio_file], 'HorizontalAlignment','center', 'VerticalAlignment','top');
   
    saveas(gcf, [audio_file '_transition_matrix_histograms'], 'jpg');    
    
    fprintf('I am here!\n');
    
    
        

   


    




