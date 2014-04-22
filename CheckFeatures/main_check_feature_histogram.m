

function main_check_feature_histogram (feature_number)

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

%     framesize = 256;
%     framestep = 128;
%     noise_level = 0.03;
%     num_of_framestep_for_RSE = 300;
%     sampling_rate = 8192;
%     save('global_parameters.mat', 'framesize', 'framestep', 'noise_level', 'num_of_framestep_for_RSE', 'sampling_rate');

    check_feature_histogram ('speech_unvoiced', feature_number);
    check_feature_histogram ('speech_voiced', feature_number);
    check_feature_histogram ('speech_indoor_meeting', feature_number);
    check_feature_histogram ('speech_indoor_restaurant', feature_number);
    check_feature_histogram ('speech_indoor_hallway', feature_number);
    check_feature_histogram ('speech_outdoor_walking', feature_number);
    check_feature_histogram ('speech_outdoor_standing', feature_number);
    check_feature_histogram ('speech_radio', feature_number);      
    check_feature_histogram ('speech_phonecall', feature_number);    
    check_feature_histogram ('silent', feature_number);    
    check_feature_histogram ('bus', feature_number);
    check_feature_histogram ('walk', feature_number);
    check_feature_histogram ('cafe', feature_number);    
    check_feature_histogram ('classical', feature_number);
    check_feature_histogram ('pop', feature_number);    
    check_feature_histogram ('tv', feature_number);
    
    
    
  
    
    