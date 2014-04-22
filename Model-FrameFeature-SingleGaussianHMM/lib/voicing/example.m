%% THIS SCRIPT DESCRIBES HOW TO TAKE A TRACE COLLECTED FROM THE
%% MULTI-SENSOR BOARD AND EXTRACT THE DATA FROM THE VARIOUS SENSOR STREAM AS WELL AS THE TIMESTAMP.
%% 
%% COMPLETEDATA.MAT AND THE AUDIOFILENAME.WAV CONTAINS ALL THE DATA FOR
%% FURTHER ANALYSIS
%%
%% AUTHORS: JONATHAN LESTER (jlester@intel-research.net)
%%          TANZEEM CHOUDHURY (tanzeem.choudhury@intel.com)


% Example of converting the sensor board data
convert_from_TRC_to_ascii('C:\tanzeem\students\lin\talking\markovia','SensorTrace__Date_07_15_2005__Time_09_42_48__0000.trc')
disp('Press anykey to continue ...')
pause

% This function will output the following files
%
% s_accleration.txt = column corresponds to [(num CPU ticks since reboot)
%       (seconds since MSB started) (frame number) (accl x) (accl y) (accl
%       z)];
% s_ambient_Infrared_Light.txt = column corresponds to [(num CPU ticks since reboot)
%       (seconds since MSB started) (frame number) (sensor reading)];
% s_ambient_Visible_Light.txt = column corresponds to [(num CPU ticks since reboot)
%       (seconds since MSB started) (frame number) (sensor reading)];
% s_barometric_Pressure.txt = column corresponds to [(num CPU ticks since reboot)
%       (seconds since MSB started) (frame number) (sensor reading)];
% s_barometric_Temperature.txt = column corresponds to [(num CPU ticks since reboot)
%       (seconds since MSB started) (frame number) (sensor reading)];
% s_compass.txt = column corresponds to [(num CPU ticks since reboot)
%       (seconds since MSB started) (frame number) (sensor reading)];
% s_hi_Freq_Visible_Light.txt = column corresponds to [(num CPU ticks since reboot)
%       (seconds since MSB started) (frame number) (sensor reading)];
% s_RH_Relative_Humidity.txt = column corresponds to [(num CPU ticks since reboot)
%       (seconds since MSB started) (frame number) (sensor reading)];
% s_RH_Temperature.txt = column corresponds to [(num CPU ticks since reboot)
%       (seconds since MSB started) (frame number) (sensor reading)];
% s_sensor_audio_complete.wav = audio data
% s_sensor_Board_Serial_Number.txt = sensor board ID
% s_time_stamps.txt  = num CPU ticks since reboot
%

% This function converts the ascii senson traces into a single dataOut.mat
% This function deletes all the ASCII files. dataOut contains all the
% sensor stream except for the audio data which is stored in the .wav file
[dataOut] = calibData( 'C:\tanzeem\students\lin\talking\markovia','SensorTrace__Date_07_15_2005__Time_09_42_48__0000.trc' );

% The following step is optional. Use only if you are going to use the
% journalviewer tool for visualization
% You will need the DLLs contained in the 'Journal Conversion' directory
% The output journalviewer compatible data files are stored in the Journal
% directory
CreateJournalFiles( 'C:\tanzeem\students\lin\talking\markovia');

% This step will convert the dataOut.mat file to
% completeData.mat. The following function accounts for the missing data if
% there are any. Similar to dataOut.mat, completeData.mat contains all the
% sensor stream except for the audio data which is stored in the .wav file
computeFinalDataStruct('\\slfiles01\shareddata\liaolin\data\typing')

% For all further analysis you should only need the completeData.mat and
% the .wav files
% completeData = 
% 
%                 path: 'C:\projects\HOW TO MSB'
%          ActualStart: 1.1098e+009
%             audio_SR: 15360
%            audioTime: [0 128.9781]
%       noAudioSamples: 1981132
%             accel_SR: 548
%            accelTime: [9.1352e+005 9.1365e+005]
%                accel: [70681x3 double]
%      visFreqLight_SR: 549
%     visFreqLightTime: [9.1352e+005 9.1365e+005]
%         visFreqLight: [70810x1 double]
%           compass_SR: 30
%          compassTime: [9.1352e+005 9.1365e+005]
%              compass: [3869x1 double]
%          VisLight_SR: 5
%         VisLightTime: [9.1352e+005 9.1365e+005]
%             VisLight: [645x1 double]
%           IRLight_SR: 5
%          IRLightTime: [9.1352e+005 9.1365e+005]
%              IRLight: [645x1 double]
%      AmbientLight_SR: 5
%     AmbientLightTime: [9.1352e+005 9.1365e+005]
%         AmbientLight: [645x1 double]
%           BarPres_SR: 14
%          BarPresTime: [9.1352e+005 9.1365e+005]
%              BarPres: [1805x1 double]
%           BarTemp_SR: 14
%          BarTempTime: [9.1352e+005 9.1365e+005]
%              BarTemp: [1805x1 double]
%          ShtHumid_SR: 2
%         ShtHumidTime: [9.1352e+005 9.1365e+005]
%             ShtHumid: [258x1 double]
%           ShtTemp_SR: 2
%          ShtTempTime: [9.1352e+005 9.1365e+005]
%              ShtTemp: [258x1 double]

% This step will compute the features from the completeData.mat file completeData.mat. 
outputMatrix = extract_ContinuousFeatureVector( 'C:\projects\HOW TO MSB', 1 )
% outputMatrix - row is time and column is feature
%                size(outputMatrix,2) = total number of features
%                size(outputMatrix,1) = number of data points (one feature data
%                point for every 0.25 of raw sensor data)

% Finally running the classifiers
% This will load the models trained using the IJCAI dataset from a shoulder
% mounted MSB
[logHistory, margins, ds_results, HMM_results] = run_hybrid_classifier(outputMatrix)
% OUTPUT:
% logHistory = log likelihood of the HMMs
% margins = margins of the decision stump
% ds_results = output of the static decision stump classifier
% HMM_results = HMM output takes 15 secs of data (60 feature samples) and output a result every 5 secs
%               i.e. uses a 5 second sliding window (20 feature samples)
%
% INTPUT:
% outputMatrix = feature matrix computed from the previous step
