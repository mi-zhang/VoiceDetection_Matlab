function [] = computeAndSaveVoicingFeatureFileRSEMaxPNumP01(hmmfile, featurefile, vit, fb, pitch, lag)

if(nargin < 3)
    vit = true;
end
if(nargin < 4)
    fb = false;
end
if(nargin < 5)
    pitch = false;
end
if(nargin < 6)
    fixedLag = false;
else
    fixedLag = true;
end

[dir, name] = fileparts(featurefile);
pathfile = fullfile(dir, [name '.voicing.features'])
lagfile = fullfile(dir, [name '.voicing-gamma-lag-' num2str(lag) '.features'])
gammafile = fullfile(dir, [name '.voicing-gamma.features'])
pitchfile = fullfile(dir, [name '.pitch.features'])


% load hmm
h = load(hmmfile);

% read features
[header, data] = readFeatureFile(featurefile);

rseIdx = strmatch('relSpecEnt', header.columns);
maxPeakValIdx = strmatch('acorr01MaxPeakVal', header.columns);
numPeaksIdx = strmatch('acorr01NumPeaks', header.columns);

maxPeakLagIdx = strmatch('acorr01MaxPeakLag', header.columns);

features = [data{maxPeakValIdx} data{numPeaksIdx} data{rseIdx}];

if(vit)

    voicing = compute_voiced_path(features, h.hmm);

    header.comment = ['created from feature file ' featurefile];
    header.columns = {'voicing'};

    writeFeatureFile(pathfile, header, voicing');
end

if(fb)
    disp(['fwdback on ' name]);
    [alpha,beta,gamma,loglik] = compute_voiced_gamma(features, h.hmm);
    header.comment = ['created from feature file ' featurefile];
    header.columns = {'alphaUnvoiced', 'alphaVoiced', 'betaUnvoiced', 'betaVoiced', 'gammaUnvoiced','gammaVoiced'};

    writeFeatureFile(gammafile, header, [alpha' beta' gamma']);
end

if(pitch)
    f = [data{maxPeakValIdx} data{maxPeakLagIdx}];
    header.comment = ['created from feature file ' featurefile];
    header.columns = {'acorr01MaxPeakVal', 'acorr01MaxPeakLag'};

    writeFeatureFile(pitchfile, header, f);
    
end


if(fixedLag)
    disp(['fixed lag smoother on ' name]);
    [alpha,gamma] = compute_voiced_fixed_lag_gamma(features, h.hmm, lag);
    header.comment = ['created from feature file ' featurefile];
    header.columns = {'alphaUnvoiced', 'alphaVoiced', 'gammaUnvoiced','gammaVoiced'};

    writeFeatureFile(lagfile, header, [alpha' gamma']);
end

%save(pathfile, 'voicing');
