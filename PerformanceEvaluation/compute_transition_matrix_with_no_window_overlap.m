

function transition_matrix_array = compute_transition_matrix_with_no_window_overlap (window_size, window_overlap, inference_result_array)


    total_num_of_window = floor(length(inference_result_array)/window_size);
    transition_matrix_array = [];    

    for window_index = 1:1:total_num_of_window

        inference_result_in_this_window = inference_result_array(1+(window_index-1)*window_size : window_index*window_size);
        
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
        
        transition_matrix_array = [transition_matrix_array; zero_to_zero, zero_to_one, one_to_zero, one_to_one];
        
    end


    
    
    
    