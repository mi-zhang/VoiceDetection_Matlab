
xaccel = getStream(warcfile,'X Acceleration'); 
yaccel = getStream(warcfile,'Y Acceleration');
zaccel = getStream(warcfile,'Z Acceleration');

temp1 = getStream(warcfile, 'Temperature');
temp2 = getStream(warcfile, 'Temperature (Sensiron)');

pressure = getStream(warcfile, 'Barometric Pressure');
humidity = getStream(warcfile, 'Humidity');

hfvis = getStream(warcfile, 'HF Visible Light');

vis = getStream(warcfile, 'Visible Light');

ir = getStream(warcfile, 'Infrared Light');

compass = getStream(warcfile, 'Compass');

[specgram,specEnts,relSpecEnts,acorr,energies,numPeaks,peakVals,peakValIdxs,acMax,acMaxIdxs,acMin,ceps] = getAudioStatsStream(warcfile);