

function check_window_feature_histogram (audio_type, feature_number)
    
    % clc;    

    switch(audio_type)                
            
        % Class 1: Speech 
        case 'speech_indoor_meeting'
            % get feature values
            feature_speech_indoor_meeting1 = compute_window_feature('speech_indoor_meeting_t1', feature_number);
            feature_speech_indoor_meeting2 = compute_window_feature('speech_indoor_meeting_t2', feature_number);
            feature_speech_indoor_meeting3 = compute_window_feature('speech_indoor_meeting_t3', feature_number);
            feature_speech_indoor_meeting4 = compute_window_feature('speech_indoor_meeting_t4', feature_number);
            feature_speech_indoor_meeting5 = compute_window_feature('speech_indoor_meeting_t5', feature_number);
            feature_speech_indoor_meeting6 = compute_window_feature('speech_indoor_meeting_t6', feature_number);
            feature_speech_indoor_meeting7 = compute_window_feature('speech_indoor_meeting_t7', feature_number);
            % compile the training data
            feature_speech_indoor_meeting = [feature_speech_indoor_meeting1; feature_speech_indoor_meeting2; feature_speech_indoor_meeting3;
                feature_speech_indoor_meeting4; feature_speech_indoor_meeting5; feature_speech_indoor_meeting6;
                feature_speech_indoor_meeting7];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_indoor_meeting, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_window_feature_1_speech_indoor_meeting'], 'jpg');
                case 2
                    hist(feature_speech_indoor_meeting, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_window_feature_2_speech_indoor_meeting'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end                
        
        case 'speech_indoor_hallway'
            % get feature values
            feature_speech_indoor_hallway1 = compute_window_feature('speech_indoor_hallway_t1', feature_number);
            feature_speech_indoor_hallway3 = compute_window_feature('speech_indoor_hallway_t3', feature_number);
            % compile the training data
            feature_speech_indoor_hallway = [feature_speech_indoor_hallway1; feature_speech_indoor_hallway3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_indoor_hallway, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Speech Indoor Hallway']);
                    saveas(gcf, ['histogram_window_feature_1_speech_indoor_hallway'], 'jpg');
                case 2
                    hist(feature_speech_indoor_hallway, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Speech Indoor Hallway']);
                    saveas(gcf, ['histogram_window_feature_2_speech_indoor_hallway'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'speech_indoor_restaurant'
            % get feature values
            feature_speech_indoor_restaurant1 = compute_window_feature('speech_indoor_restaurant_t1', feature_number); 
            % compile the training data
            feature_speech_indoor_restaurant = [feature_speech_indoor_restaurant1];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_indoor_restaurant, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Speech Indoor Restaurant']);
                    saveas(gcf, ['histogram_window_feature_1_speech_indoor_restaurant'], 'jpg');
                case 2
                    hist(feature_speech_indoor_restaurant, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Speech Indoor Restaurant']);
                    saveas(gcf, ['histogram_window_feature_2_speech_indoor_restaurant'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        % Class 2: Ambient Noise        
        case 'airconditioner'
            % get feature values
            feature_airconditioner1 = compute_window_feature('airconditioner_t1', feature_number);
            feature_airconditioner2 = compute_window_feature('airconditioner_t2', feature_number);
            feature_airconditioner3 = compute_window_feature('airconditioner_t3', feature_number);
            % compile the training data
            feature_airconditioner = [feature_airconditioner1; feature_airconditioner2; feature_airconditioner3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_airconditioner, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Air Conditioner']);
                    saveas(gcf, ['histogram_window_feature_1_airconditioner'], 'jpg');
                case 2
                    hist(feature_airconditioner, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Air Conditioner']);
                    saveas(gcf, ['histogram_window_feature_2_airconditioner'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
    
        case 'bus'
            % get feature values
            feature_bus1 = compute_window_feature('bus_t1', feature_number);
            feature_bus2 = compute_window_feature('bus_t2', feature_number);
            feature_bus3 = compute_window_feature('bus_t3', feature_number);
            % compile the training data
            feature_bus = [feature_bus1; feature_bus2; feature_bus3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_bus, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Bus']);
                    saveas(gcf, ['histogram_window_feature_1_bus'], 'jpg');
                case 2
                    hist(feature_bus, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Bus']);
                    saveas(gcf, ['histogram_window_feature_2_bus'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end                    
            
        case 'toilet_fan'
            % get feature values
            feature_toilet_fan1 = compute_window_feature('toilet_fan_t1', feature_number);
            feature_toilet_fan2 = compute_window_feature('toilet_fan_t2', feature_number);
            feature_toilet_fan3 = compute_window_feature('toilet_fan_t3', feature_number);
            % compile the training data
            feature_toilet_fan = [feature_toilet_fan1; feature_toilet_fan2; feature_toilet_fan3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_toilet_fan, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Toilet Fan']);
                    saveas(gcf, ['histogram_window_feature_1_toilet_fan'], 'jpg');
                case 2
                    hist(feature_toilet_fan, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Toilet Fan']);
                    saveas(gcf, ['histogram_window_feature_2_toilet_fan'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'vacuum'
            % get feature values
            feature_vacuum1 = compute_window_feature('vacuum_t1', feature_number);
            feature_vacuum2 = compute_window_feature('vacuum_t2', feature_number);
            % compile the training data
            feature_vacuum = [feature_vacuum1; feature_vacuum2];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_vacuum, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Vacuum']);
                    saveas(gcf, ['histogram_window_feature_1_vacuum'], 'jpg');
                case 2
                    hist(feature_vacuum, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Vacuum']);
                    saveas(gcf, ['histogram_window_feature_2_vacuum'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
        
        % Class 3: TV
        case 'tv'
            % get feature values
            feature_tv1 = compute_window_feature('tv_t1', feature_number);
            feature_tv2 = compute_window_feature('tv_t2', feature_number);
            feature_tv3 = compute_window_feature('tv_t3', feature_number);
            % compile the training data
            feature_tv = [feature_tv1; feature_tv2; feature_tv3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_tv, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - TV']);
                    saveas(gcf, ['histogram_window_feature_1_tv'], 'jpg');
                case 2
                    hist(feature_tv, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - TV']);
                    saveas(gcf, ['histogram_window_feature_2_tv'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        % Class 4: Radio
        case 'radio'
            % get feature values
            feature_radio1 = compute_window_feature('radio_t1', feature_number);
            % compile the training data
            feature_radio = [feature_radio1];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_radio, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Radio']);
                    saveas(gcf, ['histogram_window_feature_1_radio'], 'jpg');
                case 2
                    hist(feature_radio, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Radio']);
                    saveas(gcf, ['histogram_window_feature_2_radio'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        % Class 5: Music
        case 'pop'
            % get feature values
            feature_pop1 = compute_window_feature('pop_t1', feature_number);
            feature_pop2 = compute_window_feature('pop_t2', feature_number);
            feature_pop3 = compute_window_feature('pop_t3', feature_number);
            % compile the training data
            feature_pop = [feature_pop1; feature_pop2; feature_pop3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_pop, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Pop']);
                    saveas(gcf, ['histogram_window_feature_1_pop'], 'jpg');
                case 2
                    hist(feature_pop, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Pop']);
                    saveas(gcf, ['histogram_window_feature_2_pop'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'classical'
            % get feature values
            feature_classical1 = compute_window_feature('classical_t1', feature_number);
            feature_classical2 = compute_window_feature('classical_t2', feature_number);
            feature_classical3 = compute_window_feature('classical_t3', feature_number);
            feature_classical4 = compute_window_feature('classical_t4', feature_number);
            % compile the training data
            feature_classical = [feature_classical1; feature_classical2; feature_classical3; feature_classical4];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_classical, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Classical']);
                    saveas(gcf, ['histogram_window_feature_1_classical'], 'jpg');
                case 2
                    hist(feature_classical, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Classical']);
                    saveas(gcf, ['histogram_window_feature_2_classical'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end    
            
        % Class 6: Mobile Phone Video and Music
        case 'video_on_phone'
            % get feature values
            feature_video_on_phone1 = compute_window_feature('video_on_phone_t1', feature_number);
            feature_video_on_phone2 = compute_window_feature('video_on_phone_t2', feature_number);
            feature_video_on_phone3 = compute_window_feature('video_on_phone_t3', feature_number);
            % compile the training data
            feature_video_on_phone = [feature_video_on_phone1; feature_video_on_phone2; feature_video_on_phone3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_video_on_phone, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Video on Phone']);
                    saveas(gcf, ['histogram_window_feature_1_video_on_phone'], 'jpg');
                case 2
                    hist(feature_video_on_phone, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Video on Phone']);
                    saveas(gcf, ['histogram_window_feature_2_video_on_phone'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'music_on_phone'
            % get feature values
            feature_music_on_phone1 = compute_window_feature('music_on_phone_t1', feature_number);
            feature_music_on_phone2 = compute_window_feature('music_on_phone_t2', feature_number);
            feature_music_on_phone3 = compute_window_feature('music_on_phone_t3', feature_number);
            % compile the training data
            feature_music_on_phone = [feature_music_on_phone1; feature_music_on_phone2; feature_music_on_phone3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_music_on_phone, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Music on Phone']);
                    saveas(gcf, ['histogram_window_feature_1_music_on_phone'], 'jpg');
                case 2
                    hist(feature_music_on_phone, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Music on Phone']);
                    saveas(gcf, ['histogram_window_feature_2_music_on_phone'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end    
        
        % Class 7: Walk              
        case 'walk'
            % get feature values
            feature_walk1 = compute_window_feature('walk_t1', feature_number);
            feature_walk2 = compute_window_feature('walk_t2', feature_number);
            feature_walk3 = compute_window_feature('walk_t3', feature_number);
            % compile the training data
            feature_walk = [feature_walk1; feature_walk2; feature_walk3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_walk, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Walk']);
                    saveas(gcf, ['histogram_window_feature_1_walk'], 'jpg');
                case 2
                    hist(feature_walk, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Walk']);
                    saveas(gcf, ['histogram_window_feature_2_walk'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        % Class 8: Silent              
        case 'silent'
            % get feature values
            feature_silent1 = compute_window_feature('silent_t1', feature_number);
            % compile the training data
            feature_silent = [feature_silent1];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_silent, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Silent']);
                    saveas(gcf, ['histogram_window_feature_1_silent'], 'jpg');
                case 2
                    hist(feature_silent, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Silent']);
                    saveas(gcf, ['histogram_window_feature_2_silent'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        % Class 9: Shower    
        case 'shower'
            % get feature values
            feature_shower1 = compute_window_feature('shower_t1', feature_number);
            feature_shower2 = compute_window_feature('shower_t2', feature_number);
            feature_shower3 = compute_window_feature('shower_t3', feature_number);
            % compile the training data
            feature_shower = [feature_shower1; feature_shower2; feature_shower3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_shower, 50);
                    xlabel('Entropy of Log Energy');
                    axis tight            
                    title(['Histogram of Entropy of Log Energy - Shower']);
                    saveas(gcf, ['histogram_window_feature_1_shower'], 'jpg');
                case 2
                    hist(feature_shower, 50);
                    xlabel('Voice / Unvoice Ratio');
                    axis tight 
                    title(['Histogram of Voice / Unvoice Ratio - Shower']);
                    saveas(gcf, ['histogram_window_feature_2_shower'], 'jpg');                
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
            
            
    end
      


    

 


    


