

function main_matlab_check_likelihood (audio_type)

% audio_type:
% - 'speech_indoor_meeting'
% - 'speech_phonecall'
% - 'speech_indoor_restaurant'
% - 'speech_indoor_cafe'
% - 'speech_indoor_hallway'
% - 'speech_outdoor_standing'
% - 'speech_outdoor_walking'
% - 'speech_outdoor_bus'
% - 'bus'
% - 'cafe'
% - 'walk'
% - 'silent'
% - 'pop'
% - 'tv'
% - 'classical'

    % clc;
    
    switch(audio_type)
        
        case 'speech_indoor_meeting'
            % get feature values
            [nonvoiced_likelihood_speech_indoor_meeting1 voiced_likelihood_speech_indoor_meeting1] = compute_likelihood_speech('speech_indoor_meeting_t1');
            [nonvoiced_likelihood_speech_indoor_meeting2 voiced_likelihood_speech_indoor_meeting2] = compute_likelihood_speech('speech_indoor_meeting_t2');
            [nonvoiced_likelihood_speech_indoor_meeting3 voiced_likelihood_speech_indoor_meeting3] = compute_likelihood_speech('speech_indoor_meeting_t3');
            [nonvoiced_likelihood_speech_indoor_meeting4 voiced_likelihood_speech_indoor_meeting4] = compute_likelihood_speech('speech_indoor_meeting_t4');
            [nonvoiced_likelihood_speech_indoor_meeting5 voiced_likelihood_speech_indoor_meeting5] = compute_likelihood_speech('speech_indoor_meeting_t5');
            [nonvoiced_likelihood_speech_indoor_meeting6 voiced_likelihood_speech_indoor_meeting6] = compute_likelihood_speech('speech_indoor_meeting_t6');
            [nonvoiced_likelihood_speech_indoor_meeting7 voiced_likelihood_speech_indoor_meeting7] = compute_likelihood_speech('speech_indoor_meeting_t7');    
            % compile the training data
            nonvoiced_likelihood_speech_indoor_meeting = [nonvoiced_likelihood_speech_indoor_meeting1; nonvoiced_likelihood_speech_indoor_meeting2; nonvoiced_likelihood_speech_indoor_meeting3; nonvoiced_likelihood_speech_indoor_meeting4; nonvoiced_likelihood_speech_indoor_meeting5; nonvoiced_likelihood_speech_indoor_meeting6; nonvoiced_likelihood_speech_indoor_meeting7];                        
            voiced_likelihood_speech_indoor_meeting = [voiced_likelihood_speech_indoor_meeting1; voiced_likelihood_speech_indoor_meeting2; voiced_likelihood_speech_indoor_meeting3; voiced_likelihood_speech_indoor_meeting4; voiced_likelihood_speech_indoor_meeting5; voiced_likelihood_speech_indoor_meeting6; voiced_likelihood_speech_indoor_meeting7];            
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
                case 6
                    hist(feature_speech_indoor_meeting, 50);    
                    xlabel('RMS');
                    axis tight
                    title(['Histogram of Feature 6 - Speech Indoor Meeting']);
                    saveas(gcf, ['histogram_feature_6_speech_indoor_meeting'], 'jpg');    
                case 7
                    hist(log10(feature_speech_indoor_meeting), 50);    
                    xlabel('Energy');
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
            
    end

    % get voiced likelihood
    voiced_likelihood_silent1 = compute_likelihood_nonspeech('silent_t1');
    
    voiced_likelihood_c1 = compute_likelihood_nonspeech('classical_t1');
    voiced_likelihood_c2 = compute_likelihood_nonspeech('classical_t2');
    voiced_likelihood_c3 = compute_likelihood_nonspeech('classical_t3');
    voiced_likelihood_c4 = compute_likelihood_nonspeech('classical_t4');       
    
    voiced_likelihood_p1 = compute_likelihood_nonspeech('pop_t1');
    voiced_likelihood_p2 = compute_likelihood_nonspeech('pop_t2');
    voiced_likelihood_p3 = compute_likelihood_nonspeech('pop_t3');
    voiced_likelihood_p4 = compute_likelihood_nonspeech('pop_t4');
    voiced_likelihood_p5 = compute_likelihood_nonspeech('pop_t5');
    voiced_likelihood_p6 = compute_likelihood_nonspeech('pop_t6'); 
    
    voiced_likelihood_s1 = compute_likelihood_speech('radio_t1');
    voiced_likelihood_s2 = compute_likelihood_speech('speech_t2');
    voiced_likelihood_s3 = compute_likelihood_speech('speech_t3');
    voiced_likelihood_s4 = compute_likelihood_speech('speech_t4');

    % compile the training data together
    voiced_likelihood_silent = voiced_likelihood_silent1;    
    voiced_likelihood_c = [voiced_likelihood_c1; voiced_likelihood_c2; voiced_likelihood_c3; voiced_likelihood_c4];
    voiced_likelihood_p = [voiced_likelihood_p1; voiced_likelihood_p2; voiced_likelihood_p3; voiced_likelihood_p4; voiced_likelihood_p5; voiced_likelihood_p6];
    voiced_likelihood_s = [voiced_likelihood_s1; voiced_likelihood_s2; voiced_likelihood_s3; voiced_likelihood_s4];
    
    % plot the histogram
    figure;
    hist(voiced_likelihood_silent, 50);
    axis tight
    title(['Histogram of Voiced Likelihood - Silent (log10)']);        
    % save the histogram
    saveas(gcf, ['histogram_voiced_likelihood_silent'], 'jpg');
    
    figure;
    hist(voiced_likelihood_c, 50);
    axis tight
    title(['Histogram of Voiced Likelihood - Classical (log10)']);        
    % save the histogram
    saveas(gcf, ['histogram_voiced_likelihood_classical'], 'jpg');
    
    figure;
    hist(voiced_likelihood_p, 50);
    axis tight
    title(['Histogram of Voiced Likelihood - Pop (log10)']);        
    % save the histogram
    saveas(gcf, ['histogram_voiced_likelihood_pop'], 'jpg');

    figure;
    hist(voiced_likelihood_s, 50);
    axis tight
    title(['Histogram of Voiced Likelihood - Speech (log10)']);        
    % save the histogram
    saveas(gcf, ['histogram_voiced_likelihood_speech'], 'jpg');
    
    
    
    
    
    
    
    
    
    
    

    


