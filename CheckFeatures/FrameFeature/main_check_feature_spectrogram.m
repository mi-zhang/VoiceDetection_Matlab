

function main_check_feature_spectrogram (feature_number)

% audio_type:
% class 1: speech (voiced)
% - 'speech_phonecall'
% - 'speech_indoor_meeting'
% - 'speech_indoor_restaurant'
% - 'speech_indoor_hallway'
% - 'speech_outdoor_standing'
% - 'speech_outdoor_walking'
% - 'speech_outdoor_bus'
% - 'speech_radio'
% - 'speech_voiced'
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
% 9 - MCR

    check_feature_spectrogram ('speech_t2', feature_number);
    check_feature_spectrogram ('speech_t3', feature_number);
    check_feature_spectrogram ('speech_t4', feature_number);
    check_feature_spectrogram ('speech_indoor_meeting_t1', feature_number);
    check_feature_spectrogram ('speech_indoor_hallway_t1', feature_number);
    check_feature_spectrogram ('speech_indoor_restaurant_t1', feature_number);      
    
    check_feature_spectrogram ('speech_phonecall_t1', feature_number);     
    check_feature_spectrogram ('radio_t1', feature_number); 
    
    check_feature_spectrogram ('speech_outdoor_standing_t1', feature_number);    
    check_feature_spectrogram ('speech_outdoor_walking_t1', feature_number);     
    
    check_feature_spectrogram ('silent_t1', feature_number);
    check_feature_spectrogram ('bus_t1', feature_number);
    check_feature_spectrogram ('walk_t1', feature_number);
    check_feature_spectrogram ('cafe_t1', feature_number);
        
    check_feature_spectrogram ('pop_t1', feature_number);
    check_feature_spectrogram ('tv_t1', feature_number);
    check_feature_spectrogram ('classical_t1', feature_number);
    check_feature_spectrogram ('classical_t2', feature_number);
    check_feature_spectrogram ('classical_t3', feature_number);

    
    
  
    
    