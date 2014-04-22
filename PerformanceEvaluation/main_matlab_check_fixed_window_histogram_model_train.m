

function hist_model = main_matlab_check_fixed_window_histogram_model_train (transition_matrix_array, audio_file)
    
    
    zero_to_zero_array = transition_matrix_array(:, 1);
    zero_to_one_array = transition_matrix_array(:, 2);
    one_to_zero_array = transition_matrix_array(:, 3);
    one_to_one_array = transition_matrix_array(:, 4);
    
    % plot the histograms
    figure;
    subplot(2,2,1)
    hist(zero_to_zero_array);
    xlabel('Zero to Zero');
    axis tight
    subplot(2,2,2)
    hist(zero_to_one_array);
    xlabel('Zero to One');
    axis tight
    subplot(2,2,3)
    hist(one_to_zero_array);
    xlabel('One to Zero');
    axis tight 
    subplot(2,2,4)
    hist(one_to_one_array);
    xlabel('One to One');
    axis tight
    % put a single title for all subplots
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1, [audio_file], 'HorizontalAlignment','center', 'VerticalAlignment','top');
   
    % save the histograms
    saveas(gcf, [audio_file '_transition_matrix_histograms'], 'jpg');    
    
    % train a multivariate heuristic histogram model  
    zero_to_zero_probability_less_than_5 = length(find(zero_to_zero_array <= 5)) / length(zero_to_zero_array);
    zero_to_zero_probability_larger_than_50 = length(find(zero_to_zero_array >= 50)) / length(zero_to_zero_array);
    zero_to_zero_probability_others = 1 - zero_to_zero_probability_less_than_5 - zero_to_zero_probability_less_than_5; 
    
    zero_to_one_probability_equal_to_0 = length(find(zero_to_one_array == 0)) / length(zero_to_one_array);
    zero_to_one_probability_equal_to_1 = length(find(zero_to_one_array == 1)) / length(zero_to_one_array);
    zero_to_one_probability_others = 1 - zero_to_one_probability_equal_to_0 - zero_to_one_probability_equal_to_1;

    one_to_zero_probability_equal_to_0 = length(find(one_to_zero_array == 0)) / length(one_to_zero_array);
    one_to_zero_probability_equal_to_1 = length(find(one_to_zero_array == 1)) / length(one_to_zero_array);
    one_to_zero_probability_others = 1 - one_to_zero_probability_equal_to_0 - one_to_zero_probability_equal_to_1;     
    
    one_to_one_probability_less_than_5 = length(find(one_to_one_array <= 5)) / length(one_to_one_array);
    one_to_one_probability_larger_than_50 = length(find(one_to_one_array >= 50)) / length(one_to_one_array);
    one_to_one_probability_others = 1 - one_to_one_probability_less_than_5 - one_to_one_probability_larger_than_50;
    
    hist_model = [zero_to_zero_probability_less_than_5, zero_to_zero_probability_larger_than_50, zero_to_zero_probability_others; ...        
        zero_to_one_probability_equal_to_0, zero_to_one_probability_equal_to_1, zero_to_one_probability_others; ...
        one_to_zero_probability_equal_to_0, one_to_zero_probability_equal_to_1, one_to_zero_probability_others; ...
        one_to_one_probability_less_than_5, one_to_one_probability_larger_than_50, one_to_one_probability_others];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    