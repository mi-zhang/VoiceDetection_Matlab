

function transition_probability_matrix = main_matlab_check_fixed_window_markov_model_train (transition_matrix_array)
    

    % train a first-order markov model: transform the transition matrix to transition probability
    transition_probability_matrix = zeros(2,2);
    probability_zero_to_zero = sum(transition_matrix_array(:, 1))/(sum(transition_matrix_array(:, 1)) + sum(transition_matrix_array(:, 2)));
    probability_zero_to_one = sum(transition_matrix_array(:, 2))/(sum(transition_matrix_array(:, 1)) + sum(transition_matrix_array(:, 2)));
    probability_one_to_zero = sum(transition_matrix_array(:, 3))/(sum(transition_matrix_array(:, 3)) + sum(transition_matrix_array(:, 4)));
    probability_one_to_one = sum(transition_matrix_array(:, 4))/(sum(transition_matrix_array(:, 3)) + sum(transition_matrix_array(:, 4)));
    transition_probability_matrix = [probability_zero_to_zero, probability_zero_to_one; probability_one_to_zero, probability_one_to_one];
    
                                         