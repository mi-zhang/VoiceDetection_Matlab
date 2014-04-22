

function main_matlab_check_fixed_window_histogram_model (window_length)
    
    % NOTE: 
    % window_length: 64 is equal to 1 second
    
    % clc;

    % get inference results
    [inference_result_silent1 final_label_array_silent1] = do_inference('silent_t1');
    
    [inference_result_c1 final_label_array_c1] = do_inference('classical_t1');
    [inference_result_c2 final_label_array_c2] = do_inference('classical_t2');
    [inference_result_c3 final_label_array_c3] = do_inference('classical_t3');
    [inference_result_c4 final_label_array_c4] = do_inference('classical_t4');
    
    [inference_result_s1 final_label_array_s1] = do_inference('radio_t1');
    [inference_result_s2 final_label_array_s2] = do_inference('speech_t2');
    [inference_result_s3 final_label_array_s3] = do_inference('speech_t3');
    [inference_result_s4 final_label_array_s4] = do_inference('speech_t4');
    
    [inference_result_p1 final_label_array_p1] = do_inference('pop_t1');
    [inference_result_p2 final_label_array_p2] = do_inference('pop_t2');
    [inference_result_p3 final_label_array_p3] = do_inference('pop_t3');
    [inference_result_p4 final_label_array_p4] = do_inference('pop_t4');
    [inference_result_p5 final_label_array_p5] = do_inference('pop_t5');
    [inference_result_p6 final_label_array_p6] = do_inference('pop_t6');    

    % segment windows and generate transition matrix for each window.
    num_of_framestep_for_each_window = window_length; 
    window_step = num_of_framestep_for_each_window/2;
    
    transition_matrix_array_silent1 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_silent1);
        
    transition_matrix_array_c1 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_c1);
    transition_matrix_array_c2 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_c2);
    transition_matrix_array_c3 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_c3);
    transition_matrix_array_c4 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_c4);
    
    % NOTE: for speech, we need compute_transition_matrix_with_constraint
    transition_matrix_array_s1 = compute_transition_matrix_with_constraint(num_of_framestep_for_each_window, window_step, inference_result_s1);
    transition_matrix_array_s2 = compute_transition_matrix_with_constraint(num_of_framestep_for_each_window, window_step, inference_result_s2);
    transition_matrix_array_s3 = compute_transition_matrix_with_constraint(num_of_framestep_for_each_window, window_step, inference_result_s3);
    transition_matrix_array_s4 = compute_transition_matrix_with_constraint(num_of_framestep_for_each_window, window_step, inference_result_s4);
    
    transition_matrix_array_p1 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_p1);
    transition_matrix_array_p2 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_p2);
    transition_matrix_array_p3 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_p3);
    transition_matrix_array_p4 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_p4);
    transition_matrix_array_p5 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_p5);
    transition_matrix_array_p6 = compute_transition_matrix(num_of_framestep_for_each_window, window_step, inference_result_p6);
        
    % compile the training data together
    transition_matrix_array_silent = transition_matrix_array_silent1;    
    transition_matrix_array_c = [transition_matrix_array_c1; transition_matrix_array_c2; transition_matrix_array_c3; transition_matrix_array_c4];
    transition_matrix_array_s = [transition_matrix_array_s1; transition_matrix_array_s2; transition_matrix_array_s3; transition_matrix_array_s4];
    transition_matrix_array_p = [transition_matrix_array_p1; transition_matrix_array_p2; transition_matrix_array_p3; transition_matrix_array_p4; transition_matrix_array_p5; transition_matrix_array_p6];
    
    % train the heuristic histogram model
    hist_silent = main_matlab_check_fixed_window_histogram_model_train(transition_matrix_array_silent, 'silent');
    hist_c = main_matlab_check_fixed_window_histogram_model_train(transition_matrix_array_c, 'classical');
    hist_s = main_matlab_check_fixed_window_histogram_model_train(transition_matrix_array_s, 'speech');
    hist_p = main_matlab_check_fixed_window_histogram_model_train(transition_matrix_array_p, 'pop');
    
    % test (this is sanity check!)
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'silent_t1', inference_result_silent1, num_of_framestep_for_each_window);
        
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'classical_t1', inference_result_c1, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'classical_t2', inference_result_c2, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'classical_t3', inference_result_c3, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'classical_t4', inference_result_c4, num_of_framestep_for_each_window);
    
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'radio_t1', inference_result_s1, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'speech_t2', inference_result_s2, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'speech_t3', inference_result_s3, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'speech_t4', inference_result_s4, num_of_framestep_for_each_window);
   
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'pop_t1', inference_result_p1, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'pop_t2', inference_result_p2, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'pop_t3', inference_result_p3, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'pop_t4', inference_result_p4, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'pop_t5', inference_result_p5, num_of_framestep_for_each_window);
    main_matlab_check_fixed_window_histogram_model_test(hist_silent, hist_c, hist_s, hist_p, 'pop_t6', inference_result_p6, num_of_framestep_for_each_window); 
    
    
    
    
    
    
    
    
    
    
    

    
    
    

    




