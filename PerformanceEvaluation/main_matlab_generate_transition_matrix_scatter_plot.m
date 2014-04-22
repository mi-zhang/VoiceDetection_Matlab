

function main_matlab_generate_transition_matrix_scatter_plot (audio_file_1, audio_file_2)

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
    file_name_1 = strcat(dataset_path, audio_file_1, '_transition_matrix_array.mat');
    temp = load(file_name_1);
    transition_matrix_array_1 = temp.transition_matrix_array;
    
    zero_to_zero_array_1 = [];
    zero_to_one_array_1 = [];
    one_to_zero_array_1 = [];
    one_to_one_array_1 = [];
    
    % 
    for i = 1:size(transition_matrix_array_1,1)
    
        if (transition_matrix_array_1(i,2) > 0) || (transition_matrix_array_1(i,3) > 0) || (transition_matrix_array_1(i,4) > 0)
        
            zero_to_zero_array_1 = [zero_to_zero_array_1; transition_matrix_array_1(i,1)];
            zero_to_one_array_1 = [zero_to_one_array_1; transition_matrix_array_1(i,2)];
            one_to_zero_array_1 = [one_to_zero_array_1; transition_matrix_array_1(i,3)];
            one_to_one_array_1 = [one_to_one_array_1; transition_matrix_array_1(i,4)];
        
        end
        
    end
    
    % load mat file 2
    file_name_2 = strcat(dataset_path, audio_file_2, '_transition_matrix_array.mat');
    temp = load(file_name_2);
    transition_matrix_array_2 = temp.transition_matrix_array;
    
    zero_to_zero_array_2 = [];
    zero_to_one_array_2 = [];
    one_to_zero_array_2 = [];
    one_to_one_array_2 = [];
    
    % 
    for j = 1:size(transition_matrix_array_2,1)
    
        if (transition_matrix_array_2(j,2) > 0) || (transition_matrix_array_2(j,3) > 0) || (transition_matrix_array_2(j,4) > 0)
        
            zero_to_zero_array_2 = [zero_to_zero_array_2; transition_matrix_array_2(j,1)];
            zero_to_one_array_2 = [zero_to_one_array_2; transition_matrix_array_2(j,2)];
            one_to_zero_array_2 = [one_to_zero_array_2; transition_matrix_array_2(j,3)];
            one_to_one_array_2 = [one_to_one_array_2; transition_matrix_array_2(j,4)];
        
        end
        
    end

    % visualization
    figure;
    scatter(zero_to_zero_array_1, zero_to_one_array_1);
    hold on;
    scatter(zero_to_zero_array_2, zero_to_one_array_2);
    xlabel('Zero to Zero');
    ylabel('Zero to One');
    legend('Speech', 'Non-speech')
    title([audio_file_1 ' vs. ' audio_file_2 ' Zero-to-Zero vs. Zero-to-One Scatter Plot']);
    axis tight
    % save the plot
    saveas(gcf, [audio_file_1 ' vs. ' audio_file_2 ' Zero-to-Zero vs. Zero-to-One Scatter Plot'], 'jpg');    
    
    figure;
    scatter(one_to_zero_array_1, one_to_one_array_1);
    hold on;
    scatter(one_to_zero_array_2, one_to_one_array_2);
    xlabel('One to Zero');
    ylabel('One to One');
    legend('Speech', 'Non-speech')
    title([audio_file_1 ' vs. ' audio_file_2 ' One-to-Zero vs. One-to-One Scatter Plot']);
    axis tight
    % save the plot
    saveas(gcf, [audio_file_1 ' vs. ' audio_file_2 ' One-to-Zero vs. One-to-One Scatter Plot'], 'jpg');    
    
        

   


    




