

% author: Mi Zhang

function main_check_window_feature_histogram (feature_number)

% feature_number:
% 1 - Entropy of Log Energy
% 2 - Voice / Unvoice Ratio  

    % Class 1: Speech
    check_window_feature_histogram ('speech_indoor_meeting', feature_number);
    check_window_feature_histogram ('speech_indoor_hallway', feature_number);
    check_window_feature_histogram ('speech_indoor_restaurant', feature_number);
    
    % Class 2: Ambient Noise
    check_window_feature_histogram ('airconditioner', feature_number);
    check_window_feature_histogram ('bus', feature_number);
    check_window_feature_histogram ('toilet_fan', feature_number);
    check_window_feature_histogram ('vacuum', feature_number);
    
    % Class 3: TV
    check_window_feature_histogram ('tv', feature_number);
    
    % Class 4: Radio
    check_window_feature_histogram ('radio', feature_number);
    
    % Class 5: Music
    check_window_feature_histogram ('pop', feature_number);
    check_window_feature_histogram ('classical', feature_number);
    
    % Class 6: Mobile Phone Video and Music
    check_window_feature_histogram ('video_on_phone', feature_number);
    check_window_feature_histogram ('music_on_phone', feature_number);
    
    % Class 7: Walk
    check_window_feature_histogram ('walk', feature_number);
    
    % Class 8: Silent
    check_window_feature_histogram ('silent', feature_number);
    
    % Class 9: Shower
    check_window_feature_histogram ('shower', feature_number);
    
    
    
    
  
    
    