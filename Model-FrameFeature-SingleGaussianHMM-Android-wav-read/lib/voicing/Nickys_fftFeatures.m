%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f = fftFeatures(s, c)
% 
% computes a number of features on a signal s, most of which are related to
% the FFT of the signal.
% Specifically it computes the following features:
% - FFT coefficients. Absolute, real values, grouped in logarithmic bands
% - 'c' cepstral coefficients
% - the spectral entropy
% - the energy as the sum of spectral coefficients
% - mean and variance of the signal (not related to the FFT)
%
% s can be a matrix of column-signals, fftFeatures is a colum-vector.
% spec contains the spectra of each column-signal in each column
% 
% Nicky Kern, 2.9.2004

function [ featureVec Returned_curr featureDescriptions ] = Nickys_fftFeatures(s, c, sensor, featureVec, Returned_curr, featureDescriptions, dataWindowLen)
featureTemplate = [];
%% preallocate feature-vector
fftFeatures = zeros(log2(size(s, 1)) + c + 3, size(s, 2));

spec = abs(fft(s .* repmat(hamming(length(s)), 1, size(s, 2))));

%% divide the spectrum in exponential bands
fftFeatures(1, :) = spec(1, :);
featureTemplate(end+1).feature = sprintf( 'FFTBands %2d %2ds', 1, dataWindowLen );
curr = 2;
start = 2; stop = 4;
while stop <= length(s)/2
    featureTemplate(end+1).feature = sprintf( 'FFTBands %2d %2ds', curr, dataWindowLen );
    fftFeatures(curr, :) = sum(spec(start:stop, :));
    curr = curr + 1;
    start = stop + 1;
    stop = stop * 2;
end;

%% Cepstral Coefficients
ceps = real(ifft(log(spec+1e-10)));
fftFeatures(curr:curr+c-1, :) = ceps(1:c, :);
for curFeatDesc=curr:curr+c-1 
    featureTemplate(end+1).feature = sprintf( 'Cepstral Coeff %2d %2ds', curFeatDesc-curr, dataWindowLen );
end
curr = curr+c;

%% Spectral Entropy
rspec = spec(1:length(s)/2, :);
rspec = rspec + 1e-8;
normlspecg = rspec./repmat(sum(rspec), size(rspec, 1), 1);
fftFeatures(curr, :) = -1*sum(normlspecg .* log(normlspecg));
featureTemplate(end+1).feature = sprintf( 'Spectral Entropy %2ds', dataWindowLen);
curr = curr+1;

%% Energy
fftFeatures(curr, :) = sum(spec(1:length(s)/2));
featureTemplate(end+1).feature = sprintf( 'Energy %2ds', dataWindowLen );
curr = curr + 1;

%% Mean & Variance of the signal
fftFeatures(curr, :) = mean(s);
featureTemplate(end+1).feature = sprintf( 'Mean %2ds', dataWindowLen);
curr = curr + 1;
fftFeatures(curr, :) = var(s);
featureTemplate(end+1).feature = sprintf( 'Variance %2ds', dataWindowLen);

% The there are size(s, 2) concatinated features:
if( strcmp( sensor, 'Accelerometer' ) )
    sensorDetail{1} = '   X';
    sensorDetail{2} = '   Y';
    sensorDetail{3} = '   Z';
    sensorDetail{4} = ' mag';
else
    sensorDetail{1} = '';
    sensorDetail{2} = '';
    sensorDetail{3} = '';
    sensorDetail{4} = '';
    sensorDetail{5} = '';
    sensorDetail{6} = '';
    sensorDetail{7} = '';
    sensorDetail{8} = '';    
end
   
for curFeatInt=1:size(s, 2)     
    curSensor = [sensor sensorDetail{curFeatInt}];
    for curTemplateInd=1:length(featureTemplate)
        featureDescriptions(end+1).feature = featureTemplate(curTemplateInd).feature;
        featureDescriptions(end  ).sensor  = curSensor ;
    end
end


%[fftFeatures featureDescriptions] = Nickys_fftFeatures(sensorData, dataCepstral, sensor, featureDescriptions);
tempFeat = reshape(fftFeatures, 1, []);
featureVec(Returned_curr:Returned_curr+size(tempFeat, 2)-1) = tempFeat;
Returned_curr = Returned_curr + size(tempFeat, 2); 
if( size(tempFeat,1) ~= 1 )     fprintf( '   Warning: reshaped features are not column vectors!\n' );   end
clear tempFeat fftFeatures


