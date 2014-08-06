

function check_feature_histogram (audio_type, feature_number)

% audio_type:
% class 1: speech (voiced)
% - 'speech_voiced'
% - 'speech_indoor_meeting'
% - 'speech_phonecall'
% - 'speech_indoor_restaurant'
% - 'speech_indoor_hallway'
% - 'speech_outdoor_standing'
% - 'speech_outdoor_walking'
% - 'speech_outdoor_bus'
% - 'speech_radio'
% class 2: speech (unvoiced)
% - speech_unvoiced
% class 3: Ambient
% - 'silent'
% - 'bus'
% - 'walk'
% - 'cafe'
% - 'restaurant'
% - 'party'
% class 4: Music
% - 'classical'
% - 'pop'
% class 5: TV
% - 'tv'

% feature_number:
% 1 - Non-Initial Auto-correlation Peak
% 2 - Number of Auto-correlation Peaks
% 3 - Relative Spectral Entropy
% 4 - Low-High Energy Ratio
% 5 - Spectral Entropy
% 6 - Normalized Energy
% 7 - Total Energy
% 8 - ZCR
    
    % clc;    

    switch(audio_type)
        
        case 'speech_unvoiced'
            % get feature values
            feature_speech_unvoiced1 = compute_feature_speech_unvoiced('speech_indoor_meeting_t1', feature_number);
            feature_speech_unvoiced2 = compute_feature_speech_unvoiced('speech_indoor_meeting_t2', feature_number);
            feature_speech_unvoiced3 = compute_feature_speech_unvoiced('speech_indoor_meeting_t3', feature_number);
            feature_speech_unvoiced4 = compute_feature_speech_unvoiced('speech_indoor_meeting_t4', feature_number);
            feature_speech_unvoiced5 = compute_feature_speech_unvoiced('speech_indoor_meeting_t5', feature_number);
            feature_speech_unvoiced6 = compute_feature_speech_unvoiced('speech_indoor_meeting_t6', feature_number);
            feature_speech_unvoiced7 = compute_feature_speech_unvoiced('speech_indoor_meeting_t7', feature_number);
            feature_speech_unvoiced8 = compute_feature_speech_unvoiced('speech_t2', feature_number);
            feature_speech_unvoiced9 = compute_feature_speech_unvoiced('speech_t3', feature_number);
            feature_speech_unvoiced10 = compute_feature_speech_unvoiced('speech_t4', feature_number);            
            % compile the training data
            feature_speech_unvoiced = [feature_speech_unvoiced1; feature_speech_unvoiced2; feature_speech_unvoiced3; feature_speech_unvoiced4; feature_speech_unvoiced5; feature_speech_unvoiced6; feature_speech_unvoiced7; feature_speech_unvoiced8; feature_speech_unvoiced9; feature_speech_unvoiced10];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_unvoiced, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Speech Unvoiced']);
                    saveas(gcf, ['histogram_feature_1_speech_unvoiced'], 'jpg');
                case 2
                    hist(feature_speech_unvoiced, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Speech Unvoiced']);
                    saveas(gcf, ['histogram_feature_2_speech_unvoiced'], 'jpg');
                case 3
                    hist(feature_speech_unvoiced, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Speech Unvoiced']);
                    saveas(gcf, ['histogram_feature_3_speech_unvoiced'], 'jpg');
                case 4
                    hist(feature_speech_unvoiced, 50);    
                    xlabel('Low High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Speech Unvoiced']);
                    saveas(gcf, ['histogram_feature_4_speech_unvoiced'], 'jpg');    
                case 5
                    hist(feature_speech_unvoiced, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Speech Unvoiced']);
                    saveas(gcf, ['histogram_feature_5_speech_unvoiced'], 'jpg');    
                case 6
                    hist(feature_speech_unvoiced, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Unvoiced']);
                    saveas(gcf, ['histogram_feature_6_speech_unvoiced'], 'jpg');    
                case 7
                    hist(log10(feature_speech_unvoiced), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Speech Unvoiced (log10)']);
                    saveas(gcf, ['histogram_feature_7_speech_unvoiced'], 'jpg');
                case 8
                    hist(feature_speech_unvoiced, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Speech Unvoiced']);
                    saveas(gcf, ['histogram_feature_8_speech_unvoiced'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
        
        case 'speech_voiced'
            % get feature values
            feature_speech_voiced1 = compute_feature_speech('speech_indoor_meeting_t1', feature_number);
            feature_speech_voiced2 = compute_feature_speech('speech_indoor_meeting_t2', feature_number);
            feature_speech_voiced3 = compute_feature_speech('speech_indoor_meeting_t3', feature_number);
            feature_speech_voiced4 = compute_feature_speech('speech_indoor_meeting_t4', feature_number);
            feature_speech_voiced5 = compute_feature_speech('speech_indoor_meeting_t5', feature_number);
            feature_speech_voiced6 = compute_feature_speech('speech_indoor_meeting_t6', feature_number);
            feature_speech_voiced7 = compute_feature_speech('speech_indoor_meeting_t7', feature_number);
            feature_speech_voiced8 = compute_feature_speech('speech_t2', feature_number);
            feature_speech_voiced9 = compute_feature_speech('speech_t3', feature_number);
            feature_speech_voiced10 = compute_feature_speech('speech_t4', feature_number);            
            % compile the training data
            feature_speech_voiced = [feature_speech_voiced1; feature_speech_voiced2; feature_speech_voiced3; feature_speech_voiced4; feature_speech_voiced5; feature_speech_voiced6; feature_speech_voiced7; feature_speech_voiced8; feature_speech_voiced9; feature_speech_voiced10];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_voiced, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Speech Voiced']);
                    saveas(gcf, ['histogram_feature_1_speech_voiced'], 'jpg');
                case 2
                    hist(feature_speech_voiced, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Speech Voiced']);
                    saveas(gcf, ['histogram_feature_2_speech_voiced'], 'jpg');
                case 3
                    hist(feature_speech_voiced, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Speech Voiced']);
                    saveas(gcf, ['histogram_feature_3_speech_voiced'], 'jpg');
                case 4
                    hist(feature_speech_voiced, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Speech Voiced']);
                    saveas(gcf, ['histogram_feature_4_speech_voiced'], 'jpg');
                case 5
                    hist(feature_speech_voiced, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Speech Voiced']);
                    saveas(gcf, ['histogram_feature_5_speech_voiced'], 'jpg');    
                case 6
                    hist(feature_speech_voiced, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Voiced']);
                    saveas(gcf, ['histogram_feature_6_speech_voiced'], 'jpg');    
                case 7
                    hist(log10(feature_speech_voiced), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Speech Voiced (log10)']);
                    saveas(gcf, ['histogram_feature_7_speech_voiced'], 'jpg');
                case 8
                    hist(feature_speech_voiced, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Speech Voiced']);
                    saveas(gcf, ['histogram_feature_8_speech_voiced'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'speech_outdoor_walking'
            % get feature values
            feature_speech_outdoor_walking1 = compute_feature_speech('speech_outdoor_walking_t1', feature_number);
            feature_speech_outdoor_walking3 = compute_feature_speech('speech_outdoor_walking_t3', feature_number);
            % compile the training data
            feature_speech_outdoor_walking = [feature_speech_outdoor_walking1; feature_speech_outdoor_walking3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_outdoor_walking, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Speech Outdoor Walking']);
                    saveas(gcf, ['histogram_feature_1_speech_outdoor_walking'], 'jpg');
                case 2
                    hist(feature_speech_outdoor_walking, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Speech Outdoor Walking']);
                    saveas(gcf, ['histogram_feature_2_speech_outdoor_walking'], 'jpg');
                case 3
                    hist(feature_speech_outdoor_walking, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Speech Outdoor Walking']);
                    saveas(gcf, ['histogram_feature_3_speech_outdoor_walking'], 'jpg');
                case 4
                    hist(feature_speech_outdoor_walking, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4- Speech Outdoor Walking']);
                    saveas(gcf, ['histogram_feature_4_speech_outdoor_walking'], 'jpg');
                case 5
                    hist(feature_speech_outdoor_walking, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Speech Outdoor Walking']);
                    saveas(gcf, ['histogram_feature_5_speech_outdoor_walking'], 'jpg');    
                case 6
                    hist(feature_speech_outdoor_walking, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Outdoor Walking']);
                    saveas(gcf, ['histogram_feature_6_speech_outdoor_walking'], 'jpg');    
                case 7
                    hist(log10(feature_speech_outdoor_walking), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Speech Outdoor Walking (log10)']);
                    saveas(gcf, ['histogram_feature_7_speech_outdoor_walking'], 'jpg');
                case 8
                    hist(feature_speech_outdoor_walking, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Speech Outdoor Walking']);
                    saveas(gcf, ['histogram_feature_8_speech_outdoor_walking'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'speech_outdoor_standing'
            % get feature values
            feature_speech_outdoor_standing1 = compute_feature_speech('speech_outdoor_standing_t1', feature_number);
            feature_speech_outdoor_standing3 = compute_feature_speech('speech_outdoor_standing_t3', feature_number);
            % compile the training data
            feature_speech_outdoor_standing = [feature_speech_outdoor_standing1; feature_speech_outdoor_standing3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_outdoor_standing, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Speech Outdoor Standing']);
                    saveas(gcf, ['histogram_feature_1_speech_outdoor_standing'], 'jpg');
                case 2
                    hist(feature_speech_outdoor_standing, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Speech Outdoor Standing']);
                    saveas(gcf, ['histogram_feature_2_speech_outdoor_standing'], 'jpg');
                case 3
                    hist(feature_speech_outdoor_standing, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Speech Outdoor Standing']);
                    saveas(gcf, ['histogram_feature_3_speech_outdoor_standing'], 'jpg');
                case 4
                    hist(feature_speech_outdoor_standing, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Speech Outdoor Standing']);
                    saveas(gcf, ['histogram_feature_4_speech_outdoor_standing'], 'jpg');
                case 5
                    hist(feature_speech_outdoor_standing, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Speech Outdoor Standing']);
                    saveas(gcf, ['histogram_feature_5_speech_outdoor_standing'], 'jpg');    
                case 6
                    hist(feature_speech_outdoor_standing, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Outdoor Standing']);
                    saveas(gcf, ['histogram_feature_6_speech_outdoor_standing'], 'jpg');    
                case 7
                    hist(log10(feature_speech_outdoor_standing), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Speech Outdoor Standing (log10)']);
                    saveas(gcf, ['histogram_feature_7_speech_outdoor_standing'], 'jpg');
                case 8
                    hist(feature_speech_outdoor_standing, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Speech Outdoor Standing']);
                    saveas(gcf, ['histogram_feature_8_speech_outdoor_standing'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'speech_indoor_restaurant'
            % get feature values
            feature_speech_indoor_restaurant1 = compute_feature_speech('speech_indoor_restaurant_t1', feature_number);
            % compile the training data
            feature_speech_indoor_restaurant = [feature_speech_indoor_restaurant1];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_indoor_restaurant, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Speech Indoor Restaurant']);
                    saveas(gcf, ['histogram_feature_1_speech_indoor_restaurant'], 'jpg');
                case 2
                    hist(feature_speech_indoor_restaurant, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Speech Indoor Restaurant']);
                    saveas(gcf, ['histogram_feature_2_speech_indoor_restaurant'], 'jpg');
                case 3
                    hist(feature_speech_indoor_restaurant, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Speech Indoor Restaurant']);
                    saveas(gcf, ['histogram_feature_3_speech_indoor_restaurant'], 'jpg');
                case 4
                    hist(feature_speech_indoor_restaurant, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Speech Indoor Restaurant']);
                    saveas(gcf, ['histogram_feature_4_speech_indoor_restaurant'], 'jpg');
                case 5
                    hist(feature_speech_indoor_restaurant, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Speech Indoor Restaurant']);
                    saveas(gcf, ['histogram_feature_5_speech_indoor_restaurant'], 'jpg');    
                case 6
                    hist(feature_speech_indoor_restaurant, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Indoor Restaurant']);
                    saveas(gcf, ['histogram_feature_6_speech_indoor_restaurant'], 'jpg');    
                case 7
                    hist(log10(feature_speech_indoor_restaurant), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Speech Indoor Restaurant (log10)']);
                    saveas(gcf, ['histogram_feature_7_speech_indoor_restaurant'], 'jpg');
                case 8
                    hist(feature_speech_indoor_restaurant, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Speech Indoor Restaurant']);
                    saveas(gcf, ['histogram_feature_8_speech_indoor_restaurant'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'speech_indoor_hallway'
            % get feature values
            feature_speech_indoor_hallway1 = compute_feature_speech('speech_indoor_hallway_t1', feature_number);
            feature_speech_indoor_hallway3 = compute_feature_speech('speech_indoor_hallway_t3', feature_number);
            % compile the training data
            feature_speech_indoor_hallway = [feature_speech_indoor_hallway1; feature_speech_indoor_hallway3];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_indoor_hallway, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Speech Indoor Hallway']);
                    saveas(gcf, ['histogram_feature_1_speech_indoor_hallway'], 'jpg');
                case 2
                    hist(feature_speech_indoor_hallway, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Speech Indoor Hallway']);
                    saveas(gcf, ['histogram_feature_2_speech_indoor_hallway'], 'jpg');
                case 3
                    hist(feature_speech_indoor_hallway, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Speech Indoor Hallway']);
                    saveas(gcf, ['histogram_feature_3_speech_indoor_hallway'], 'jpg');
                case 4
                    hist(feature_speech_indoor_hallway, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Speech Indoor Hallway']);
                    saveas(gcf, ['histogram_feature_4_speech_indoor_hallway'], 'jpg');
                case 5
                    hist(feature_speech_indoor_hallway, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Speech Indoor Hallway']);
                    saveas(gcf, ['histogram_feature_5_speech_indoor_hallway'], 'jpg');    
                case 6
                    hist(feature_speech_indoor_hallway, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Indoor Hallway']);
                    saveas(gcf, ['histogram_feature_6_speech_indoor_hallway'], 'jpg');    
                case 7
                    hist(log10(feature_speech_indoor_hallway), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Speech Indoor Hallway (log10)']);
                    saveas(gcf, ['histogram_feature_7_speech_indoor_hallway'], 'jpg');
                case 8
                    hist(feature_speech_indoor_hallway, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Speech Indoor Hallway']);
                    saveas(gcf, ['histogram_feature_8_speech_indoor_hallway'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'speech_indoor_meeting'
            % get feature values
            feature_speech_indoor_meeting1 = compute_feature_speech('speech_indoor_meeting_t1', feature_number);
            feature_speech_indoor_meeting2 = compute_feature_speech('speech_indoor_meeting_t2', feature_number);
            feature_speech_indoor_meeting3 = compute_feature_speech('speech_indoor_meeting_t3', feature_number);
            feature_speech_indoor_meeting4 = compute_feature_speech('speech_indoor_meeting_t4', feature_number);
            feature_speech_indoor_meeting5 = compute_feature_speech('speech_indoor_meeting_t5', feature_number);
            feature_speech_indoor_meeting6 = compute_feature_speech('speech_indoor_meeting_t6', feature_number);
            feature_speech_indoor_meeting7 = compute_feature_speech('speech_indoor_meeting_t7', feature_number);
            % compile the training data
            feature_speech_indoor_meeting = [feature_speech_indoor_meeting1; feature_speech_indoor_meeting2; feature_speech_indoor_meeting3; feature_speech_indoor_meeting4; feature_speech_indoor_meeting5; feature_speech_indoor_meeting6; feature_speech_indoor_meeting7];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_indoor_meeting, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_feature_1_speech_indoor_meeting'], 'jpg');
                case 2
                    hist(feature_speech_indoor_meeting, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_feature_2_speech_indoor_meeting'], 'jpg');
                case 3
                    hist(feature_speech_indoor_meeting, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_feature_3_speech_indoor_meeting'], 'jpg');
                case 4
                    hist(feature_speech_indoor_meeting, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_feature_4_speech_indoor_meeting'], 'jpg');
                case 5
                    hist(feature_speech_indoor_meeting, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_feature_5_speech_indoor_meeting'], 'jpg');    
                case 6
                    hist(feature_speech_indoor_meeting, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_feature_6_speech_indoor_meeting'], 'jpg');    
                case 7
                    hist(log10(feature_speech_indoor_meeting), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Speech Indoor Meeting (log10)']);
                    saveas(gcf, ['histogram_feature_7_speech_indoor_meeting'], 'jpg');
                case 8
                    hist(feature_speech_indoor_meeting, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_feature_8_speech_indoor_meeting'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
        
        case 'speech_phonecall'
            % get feature values
            feature_speech_phonecall1 = compute_feature_speech('speech_phonecall_t1', feature_number);
            feature_speech_phonecall2 = compute_feature_speech('speech_phonecall_t2', feature_number);
            % compile the training data
            feature_speech_phonecall = [feature_speech_phonecall1; feature_speech_phonecall2];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_speech_phonecall, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Speech Phonecall']);
                    saveas(gcf, ['histogram_feature_1_speech_phonecall'], 'jpg');
                case 2
                    hist(feature_speech_phonecall, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Speech Phonecall']);
                    saveas(gcf, ['histogram_feature_2_speech_phonecall'], 'jpg');
                case 3
                    hist(feature_speech_phonecall, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Speech Phonecall']);
                    saveas(gcf, ['histogram_feature_3_speech_phonecall'], 'jpg');
                case 4
                    hist(feature_speech_phonecall, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Speech Phonecall']);
                    saveas(gcf, ['histogram_feature_4_speech_phonecall'], 'jpg');
                case 5
                    hist(feature_speech_phonecall, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Speech Phonecall']);
                    saveas(gcf, ['histogram_feature_5_speech_phonecall'], 'jpg');    
                case 6
                    hist(feature_speech_phonecall, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Phonecall']);
                    saveas(gcf, ['histogram_feature_6_speech_phonecall'], 'jpg');    
                case 7
                    hist(log10(feature_speech_phonecall), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Speech Phonecall (log10)']);
                    saveas(gcf, ['histogram_feature_7_speech_phonecall'], 'jpg');
                case 8
                    hist(feature_speech_phonecall, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Speech Phonecall']);
                    saveas(gcf, ['histogram_feature_8_speech_phonecall'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
        
        case 'speech_radio'
            % get feature values
            feature_radio1 = compute_feature_speech('radio_t1', feature_number);
            % compile the training data
            feature_radio = [feature_radio1];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_radio, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Speech Radio']);
                    saveas(gcf, ['histogram_feature_1_speech_radio'], 'jpg');
                case 2
                    hist(feature_radio, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Speech Radio']);
                    saveas(gcf, ['histogram_feature_2_speech_radio'], 'jpg');
                case 3
                    hist(feature_radio, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Speech Radio']);
                    saveas(gcf, ['histogram_feature_3_speech_radio'], 'jpg');
                case 4
                    hist(feature_radio, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Speech Radio']);
                    saveas(gcf, ['histogram_feature_4_speech_radio'], 'jpg');
                case 5
                    hist(feature_radio, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Speech Radio']);
                    saveas(gcf, ['histogram_feature_5_speech_radio'], 'jpg');    
                case 6
                    hist(feature_radio, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Radio']);
                    saveas(gcf, ['histogram_feature_6_speech_radio'], 'jpg');    
                case 7
                    hist(log10(feature_radio), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Speech Radio (log10)']);
                    saveas(gcf, ['histogram_feature_7_speech_radio'], 'jpg');
                case 8
                    hist(feature_radio, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Speech Radio']);
                    saveas(gcf, ['histogram_feature_8_speech_radio'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'tv'
            % get feature values
            feature_t1 = compute_feature_nonspeech('tv_t1', feature_number);
            feature_t2 = compute_feature_nonspeech('tv_t2', feature_number);
            feature_t3 = compute_feature_nonspeech('tv_t3', feature_number);
            feature_t4 = compute_feature_nonspeech('tv_t4', feature_number);
            feature_t5 = compute_feature_nonspeech('tv_t5', feature_number);
            feature_t6 = compute_feature_nonspeech('tv_t6', feature_number);
            % compile the training data
            feature_t = [feature_t1; feature_t2; feature_t3; feature_t4; feature_t5; feature_t6];    
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_t, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - tv']);
                    saveas(gcf, ['histogram_feature_1_tv'], 'jpg');
                case 2
                    hist(feature_t, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - tv']);
                    saveas(gcf, ['histogram_feature_2_tv'], 'jpg');
                case 3
                    hist(feature_t, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - tv']);
                    saveas(gcf, ['histogram_feature_3_tv'], 'jpg');
                case 4
                    hist(feature_t, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - tv']);
                    saveas(gcf, ['histogram_feature_4_tv'], 'jpg');
                case 5
                    hist(feature_t, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - tv']);
                    saveas(gcf, ['histogram_feature_5_tv'], 'jpg');    
                case 6
                    hist(feature_t, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - tv']);
                    saveas(gcf, ['histogram_feature_6_tv'], 'jpg');    
                case 7
                    hist(log10(feature_t), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - tv (log10)']);
                    saveas(gcf, ['histogram_feature_7_tv'], 'jpg');
                case 8
                    hist(feature_t, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - tv']);
                    saveas(gcf, ['histogram_feature_8_tv'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'pop'
            % get feature values
            feature_p1 = compute_feature_nonspeech('pop_t1', feature_number);
            feature_p2 = compute_feature_nonspeech('pop_t2', feature_number);
            feature_p3 = compute_feature_nonspeech('pop_t3', feature_number);
            feature_p4 = compute_feature_nonspeech('pop_t4', feature_number);
            feature_p5 = compute_feature_nonspeech('pop_t5', feature_number);
            feature_p6 = compute_feature_nonspeech('pop_t6', feature_number);
            % compile the training data
            feature_p = [feature_p1; feature_p2; feature_p3; feature_p4; feature_p5; feature_p6];    
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_p, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - pop']);
                    saveas(gcf, ['histogram_feature_1_pop'], 'jpg');
                case 2
                    hist(feature_p, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - pop']);
                    saveas(gcf, ['histogram_feature_2_pop'], 'jpg');
                case 3
                    hist(feature_p, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - pop']);
                    saveas(gcf, ['histogram_feature_3_pop'], 'jpg');
                case 4
                    hist(feature_p, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - pop']);
                    saveas(gcf, ['histogram_feature_4_pop'], 'jpg');
                case 5
                    hist(feature_p, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - pop']);
                    saveas(gcf, ['histogram_feature_5_pop'], 'jpg');    
                case 6
                    hist(feature_p, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - pop']);
                    saveas(gcf, ['histogram_feature_6_pop'], 'jpg');    
                case 7
                    hist(log10(feature_p), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - pop (log10)']);
                    saveas(gcf, ['histogram_feature_7_pop'], 'jpg');
                case 8
                    hist(feature_p, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - pop']);
                    saveas(gcf, ['histogram_feature_8_pop'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'classical'
            % get feature values
            feature_c1 = compute_feature_nonspeech('classical_t1', feature_number);
            feature_c2 = compute_feature_nonspeech('classical_t2', feature_number);
            feature_c3 = compute_feature_nonspeech('classical_t3', feature_number);
            feature_c4 = compute_feature_nonspeech('classical_t4', feature_number);
            % compile the training data
            feature_c = [feature_c1; feature_c2; feature_c3; feature_c4];    
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_c, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - classical']);
                    saveas(gcf, ['histogram_feature_1_classical'], 'jpg');
                case 2
                    hist(feature_c, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - classical']);
                    saveas(gcf, ['histogram_feature_2_classical'], 'jpg');
                case 3
                    hist(feature_c, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - classical']);
                    saveas(gcf, ['histogram_feature_3_classical'], 'jpg');
                case 4
                    hist(feature_c, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - classical']);
                    saveas(gcf, ['histogram_feature_4_classical'], 'jpg');
                case 5
                    hist(feature_c, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - classical']);
                    saveas(gcf, ['histogram_feature_5_classical'], 'jpg');    
                case 6
                    hist(feature_c, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - classical']);
                    saveas(gcf, ['histogram_feature_6_classical'], 'jpg');    
                case 7
                    hist(log10(feature_c), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - classical (log10)']);
                    saveas(gcf, ['histogram_feature_7_classical'], 'jpg');
                case 8
                    hist(feature_c, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - classical']);
                    saveas(gcf, ['histogram_feature_8_classical'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'silent'
            % get feature values
            feature_silent1 = compute_feature_nonspeech('silent_t1', feature_number);
            % compile the training data
            feature_silent = feature_silent1;
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_silent, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Silent']);
                    saveas(gcf, ['histogram_feature_1_silent'], 'jpg');
                case 2
                    hist(feature_silent, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Silent']);
                    saveas(gcf, ['histogram_feature_2_silent'], 'jpg');
                case 3
                    hist(feature_silent, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Silent']);
                    saveas(gcf, ['histogram_feature_3_silent'], 'jpg');
                case 4
                    hist(feature_silent, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Silent']);
                    saveas(gcf, ['histogram_feature_4_silent'], 'jpg');
                case 5
                    hist(feature_silent, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Silent']);
                    saveas(gcf, ['histogram_feature_5_silent'], 'jpg');    
                case 6
                    hist(feature_silent, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Silent']);
                    saveas(gcf, ['histogram_feature_6_silent'], 'jpg');    
                case 7
                    hist(log10(feature_silent), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Silent (log10)']);
                    saveas(gcf, ['histogram_feature_7_silent'], 'jpg');
                case 8
                    hist(feature_silent, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Silent']);
                    saveas(gcf, ['histogram_feature_8_silent'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end                    
            
        case 'cafe'
            % get feature values
            feature_cafe1 = compute_feature_nonspeech('cafe_t1', feature_number);
            feature_cafe2 = compute_feature_nonspeech('cafe_t2', feature_number);
            feature_cafe3 = compute_feature_nonspeech('cafe_t3', feature_number);
            feature_cafe4 = compute_feature_nonspeech('cafe_t4', feature_number);
            feature_cafe5 = compute_feature_nonspeech('cafe_t5', feature_number);
            % compile the training data
            feature_cafe = [feature_cafe1; feature_cafe2; feature_cafe3; feature_cafe4; feature_cafe5];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_cafe, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - cafe']);
                    saveas(gcf, ['histogram_feature_1_cafe'], 'jpg');
                case 2
                    hist(feature_cafe, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - cafe']);
                    saveas(gcf, ['histogram_feature_2_cafe'], 'jpg');
                case 3
                    hist(feature_cafe, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - cafe']);
                    saveas(gcf, ['histogram_feature_3_cafe'], 'jpg');
                case 4
                    hist(feature_cafe, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - cafe']);
                    saveas(gcf, ['histogram_feature_4_cafe'], 'jpg');
                case 5
                    hist(feature_cafe, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - cafe']);
                    saveas(gcf, ['histogram_feature_5_cafe'], 'jpg');    
                case 6
                    hist(feature_cafe, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - cafe']);
                    saveas(gcf, ['histogram_feature_6_cafe'], 'jpg');    
                case 7
                    hist(log10(feature_cafe), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - cafe (log10)']);
                    saveas(gcf, ['histogram_feature_7_cafe'], 'jpg');
                case 8
                    hist(feature_cafe, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - cafe']);
                    saveas(gcf, ['histogram_feature_8_cafe'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'bus'
            % get feature values
            feature_b1 = compute_feature_nonspeech('bus_t1', feature_number);
            feature_b2 = compute_feature_nonspeech('bus_t2', feature_number);
            feature_b3 = compute_feature_nonspeech('bus_t3', feature_number);
            feature_b4 = compute_feature_nonspeech('bus_t4', feature_number);
            feature_b5 = compute_feature_nonspeech('bus_t5', feature_number);
            % compile the training data
            feature_b = [feature_b1; feature_b2; feature_b3; feature_b4; feature_b5];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_b, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - bus']);
                    saveas(gcf, ['histogram_feature_1_bus'], 'jpg');
                case 2
                    hist(feature_b, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - bus']);
                    saveas(gcf, ['histogram_feature_2_bus'], 'jpg');
                case 3
                    hist(feature_b, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - bus']);
                    saveas(gcf, ['histogram_feature_3_bus'], 'jpg');
                case 4
                    hist(feature_b, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - bus']);
                    saveas(gcf, ['histogram_feature_4_bus'], 'jpg');
                case 5
                    hist(feature_b, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - bus']);
                    saveas(gcf, ['histogram_feature_5_bus'], 'jpg');    
                case 6
                    hist(feature_b, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - bus']);
                    saveas(gcf, ['histogram_feature_6_bus'], 'jpg');    
                case 7
                    hist(log10(feature_b), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - bus (log10)']);
                    saveas(gcf, ['histogram_feature_7_bus'], 'jpg');
                case 8
                    hist(feature_b, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - bus']);
                    saveas(gcf, ['histogram_feature_8_bus'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
            
        case 'walk'
            % get feature values
            feature_w1 = compute_feature_nonspeech('walk_t1', feature_number);
            feature_w2 = compute_feature_nonspeech('walk_t2', feature_number);
            feature_w3 = compute_feature_nonspeech('walk_t3', feature_number);
            feature_w4 = compute_feature_nonspeech('walk_t4', feature_number);
            feature_w5 = compute_feature_nonspeech('walk_t5', feature_number);
            % compile the training data
            feature_w = [feature_w1; feature_w2; feature_w3; feature_w4; feature_w5];            
            % plot
            figure;
            switch(feature_number)
                case 1
                    hist(feature_w, 50);
                    xlabel('Non-Initial Auto-correlation Peak');
                    axis tight            
                    title(['Histogram of Feature 1 - Walk']);
                    saveas(gcf, ['histogram_feature_1_walk'], 'jpg');
                case 2
                    hist(feature_w, 50);
                    xlabel('Number of Auto-correlation Peaks');
                    axis tight 
                    title(['Histogram of Feature 2 - Walk']);
                    saveas(gcf, ['histogram_feature_2_walk'], 'jpg');
                case 3
                    hist(feature_w, 50);    
                    xlabel('Relative Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 3 - Walk']);
                    saveas(gcf, ['histogram_feature_3_walk'], 'jpg');
                case 4
                    hist(feature_w, 50);    
                    xlabel('Low-High Energy Ratio');
                    axis tight
                    title(['Histogram of Feature 4 - Walk']);
                    saveas(gcf, ['histogram_feature_4_walk'], 'jpg');
                case 5
                    hist(feature_w, 50);    
                    xlabel('Spectral Entropy');
                    axis tight
                    title(['Histogram of Feature 5 - Walk']);
                    saveas(gcf, ['histogram_feature_5_walk'], 'jpg');    
                case 6
                    hist(feature_w, 50);    
                    xlabel('Normalized Energy');
                    axis tight
                    title(['Histogram of Feature 6 - Walk']);
                    saveas(gcf, ['histogram_feature_6_walk'], 'jpg');    
                case 7
                    hist(log10(feature_w), 50);    
                    xlabel('Total Energy');
                    axis tight
                    title(['Histogram of Feature 7 - Walk (log10)']);
                    saveas(gcf, ['histogram_feature_7_walk'], 'jpg');
                case 8
                    hist(feature_w, 50);    
                    xlabel('ZCR');
                    axis tight   
                    title(['Histogram of Feature 8 - Walk']);
                    saveas(gcf, ['histogram_feature_8_walk'], 'jpg');
                otherwise
                    fprintf('Unexpected feature type.\n');
            end
    
    end
      


    



%     feature_s1 = compute_feature_speech('radio_t1', feature_number);
%     feature_s2 = compute_feature_speech('speech_t2', feature_number);
%     feature_s3 = compute_feature_speech('speech_t3', feature_number);
%     feature_s4 = compute_feature_speech('speech_t4', feature_number); 
    
%     feature_s_unvoiced2 = compute_feature_speech_unvoiced('speech_t2', feature_number);
%     feature_s_unvoiced3 = compute_feature_speech_unvoiced('speech_t3', feature_number);
%     feature_s_unvoiced4 = compute_feature_speech_unvoiced('speech_t4', feature_number);

%     feature_ss1 = compute_feature_speech('speech_indoor_meeting_t1', feature_number);
%     feature_ss2 = compute_feature_speech('speech_indoor_meeting_t2', feature_number);
%     feature_ss3 = compute_feature_speech('speech_indoor_meeting_t3', feature_number);
%     feature_ss4 = compute_feature_speech('speech_indoor_meeting_t4', feature_number);
%     feature_ss5 = compute_feature_speech('speech_indoor_meeting_t5', feature_number);
%     feature_ss6 = compute_feature_speech('speech_indoor_meeting_t6', feature_number);
%     feature_ss7 = compute_feature_speech('speech_indoor_meeting_t7', feature_number);
                 
%     feature_ss_unvoiced1 = compute_feature_speech_unvoiced('speech_indoor_meeting_t1', feature_number);
%     feature_ss_unvoiced2 = compute_feature_speech_unvoiced('speech_indoor_meeting_t2', feature_number);
%     feature_ss_unvoiced3 = compute_feature_speech_unvoiced('speech_indoor_meeting_t3', feature_number);
%     feature_ss_unvoiced4 = compute_feature_speech_unvoiced('speech_indoor_meeting_t4', feature_number);
%     feature_ss_unvoiced5 = compute_feature_speech_unvoiced('speech_indoor_meeting_t5', feature_number);
%     feature_ss_unvoiced6 = compute_feature_speech_unvoiced('speech_indoor_meeting_t6', feature_number);
%     feature_ss_unvoiced7 = compute_feature_speech_unvoiced('speech_indoor_meeting_t7', feature_number);

    % compile the training data
%     feature_silent = feature_silent1;    
%     feature_c = [feature_c1; feature_c2; feature_c3; feature_c4];
%     feature_p = [feature_p1; feature_p2; feature_p3; feature_p4; feature_p5; feature_p6];
%     feature_s = [feature_s1; feature_s2; feature_s3; feature_s4];
%     feature_ss = [feature_ss1; feature_ss2; feature_ss3; feature_ss4; feature_ss5; feature_ss6; feature_ss7];
%     feature_ss_unvoiced = [feature_ss_unvoiced1; feature_ss_unvoiced2; feature_ss_unvoiced3; feature_ss_unvoiced4; feature_ss_unvoiced5; feature_ss_unvoiced6; feature_ss_unvoiced7];
    
    % calculate the parameters of the Gaussian model    
%     mean_value_ss = mean(feature_ss);
%     std_value_ss = std(feature_ss);
%     fprintf('feature mean for speech (voiced): %d\n', mean_value_ss);
%     fprintf('feature std for speech (voiced): %d\n', std_value_ss);
%     mean_value_ss_unvoiced = mean(feature_ss_unvoiced);
%     std_value_ss_unvoiced = std(feature_ss_unvoiced);
%     fprintf('feature mean for speech (unvoiced): %d\n', mean_value_ss_unvoiced);
%     fprintf('feature std for speech (unvoiced): %d\n', std_value_ss_unvoiced);         
    
    % plot the histogram
%     figure;
%     switch(feature_number)
%         case 1
%             hist(feature_ss, 50);
%             xlabel('Non-Initial Auto-correlation Peak');
%             axis tight            
%             title(['Histogram of Feature 1 - Speech (Voiced)']);
%             saveas(gcf, ['histogram_feature_1_speech_voiced'], 'jpg');
%         case 2
%             hist(feature_ss, 50);
%             xlabel('Number of Auto-correlation Peaks');
%             axis tight 
%             title(['Histogram of Feature 2 - Speech (Voiced)']);
%             saveas(gcf, ['histogram_feature_2_speech_voiced'], 'jpg');
%         case 3
%             hist(feature_ss, 50);    
%             xlabel('Relative Spectral Entropy');
%             axis tight
%             title(['Histogram of Feature 3 - Speech (Voiced)']);
%             saveas(gcf, ['histogram_feature_3_speech_voiced'], 'jpg');
%         case 7
%             hist(log10(feature_ss), 50);    
%             xlabel('LF / HF');
%             axis tight
%             title(['Histogram of Feature 7 - Speech (Voiced) (log10)']);
%             saveas(gcf, ['histogram_feature_7_speech_voiced'], 'jpg');
%         case 8
%             hist(feature_ss, 50);    
%             xlabel('ZCR');
%             axis tight   
%             title(['Histogram of Feature 8 - Speech (Voiced)']);
%             saveas(gcf, ['histogram_feature_8_speech_voiced'], 'jpg');
%         otherwise
%             fprintf('Unexpected feature type.\n');
%     end
%     
%     figure;
%     switch(feature_number)
%         case 1
%             hist(feature_ss_unvoiced, 50);
%             xlabel('Non-Initial Auto-correlation Peak');
%             axis tight            
%             title(['Histogram of Feature 1 - Speech (Unvoiced)']);
%             saveas(gcf, ['histogram_feature_1_speech_unvoiced'], 'jpg');
%         case 2
%             hist(feature_ss_unvoiced, 50);
%             xlabel('Number of Auto-correlation Peaks');
%             axis tight 
%             title(['Histogram of Feature 2 - Speech (Unvoiced)']);
%             saveas(gcf, ['histogram_feature_2_speech_unvoiced'], 'jpg');
%         case 3
%             hist(feature_ss_unvoiced, 50);    
%             xlabel('Relative Spectral Entropy');
%             axis tight
%             title(['Histogram of Feature 3 - Speech (Unvoiced)']);
%             saveas(gcf, ['histogram_feature_3_speech_unvoiced'], 'jpg');
%         case 7
%             hist(log10(feature_ss_unvoiced), 50);    
%             xlabel('LF / HF');
%             axis tight
%             title(['Histogram of Feature 7 - Speech (Unvoiced) (log10)']);
%             saveas(gcf, ['histogram_feature_7_speech_unvoiced'], 'jpg');
%         case 8
%             hist(feature_ss_unvoiced, 50);    
%             xlabel('ZCR');
%             axis tight   
%             title(['Histogram of Feature 8 - Speech (Unvoiced)']);
%             saveas(gcf, ['histogram_feature_8_speech_unvoiced'], 'jpg');
%         otherwise
%             fprintf('Unexpected feature type.\n');
%     end
%     
%     fprintf('I am here.\n');    


    


