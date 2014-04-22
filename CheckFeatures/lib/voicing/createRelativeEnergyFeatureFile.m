function [features] = createRelativeEnergyFeatureFile(featureFiles, filename, normalize)

if(nargin < 3)
    normalize = false;
end

for i=1:length(featureFiles)
    [h,d] = readFeatureFile(featureFiles{i});
    energyIdx = strmatch('energy', h.columns, '-exact');
    energies(:,i) = d{energyIdx};
    
    if(normalize)
        %energies(:,i) = energies(:,i) ./ max(energies(:,i));
        energies(:,i) = energies(:,i) ./ std(energies(:,i));
    end
    
end

columns = {}; 

for j=1:size(energies,2)
    for k=j+1:size(energies,2)
        columns{end+1} = ['rel' num2str(j-1) 'to' num2str(k-1)];
    end
end
columns{end+1} = 'maxSpeaker';
header = createFeatureFileHeader(15360, 512, 256, columns, '');
header.num_frames = size(energies,1);


features = zeros(size(energies,1), length(columns));

col = 1;
for j=1:size(energies,2)
    for k=j+1:size(energies,2)        
        features(:,col) = energies(:,j) ./ energies(:,k);
        col = col + 1;
    end
end

[v,idx] = max(energies');
features(:,col) = idx - 1;

writeFeatureFile(filename, header, features);