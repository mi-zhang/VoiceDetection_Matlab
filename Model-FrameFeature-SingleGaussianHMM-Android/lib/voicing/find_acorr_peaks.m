function [peaks, peakvals] = find_acorr_peaks(acorr_slice)
% function [peaks, peakvals] = find_acorr_peaks(acorr_slice)
%
% finds peaks in an acorr slice.  starts at beginning, 
% requires dip below zero before first peak and successive peaks
% strategy: find zero crossings, then find max in between zero
% crossings

% find zero crossings
negs = find(acorr_slice < 0);
negsplus = negs + 1;
negsminus = negs - 1;
% make sure we don't go over end
if (length(negsplus) == 0)
  peaks = 0; peakvals = [0];
  return
end
if ( negsplus(length(negsplus)) > length(acorr_slice) )
  negsplus = negsplus(1:length(negsplus)-1);
end
if ( negsminus(1) < 1)
  negsminus = negsminus(2:length(negsminus));
end

%        ____
%  |    /    \
% -+---0a----b0----
%  |  /        \
%
% a = zc_locs_plus(i)
% b = zc_locs_minus(i)
  

% pos bump starts at zc_locs_plus
zc_locs_plus = negsplus( find(acorr_slice(negsplus) > 0) );
num_zc_locs_plus = length(zc_locs_plus);
% neg bump starts at zc_locs_minus
zc_locs_minus = negsminus( find(acorr_slice(negsminus) > 0));
num_zc_locs_minus = length(zc_locs_minus);

if ( (length(zc_locs_plus) == 0) | (length(zc_locs_minus) == 0))
  peaks = 0;
  peakvals = 0;
  return;
end

% now step through them
if (zc_locs_minus(1) < zc_locs_plus(1))
  % usual case - we'll disregard the acorr falloff from 0 and start at
  % the first real peak
  
  % zc_locs_plus(pospos) and zc_locs_minus(negpos) will bracket the peak
  negpos = 2;
  pospos = 1;
else
  negpos = 1;
  pospos = 1;
end

% add the end bracket if necessary
if (zc_locs_plus(end) > zc_locs_minus(end))
  zc_locs_minus(end) = length(acorr_slice);
end

peaks = 0; peakvals = 0;
numpeaks = 0;
while ( (pospos <= num_zc_locs_plus) & (negpos <= num_zc_locs_minus));
  numpeaks = numpeaks + 1;

  if (zc_locs_plus(pospos) > zc_locs_minus(negpos)) % very rare - mean we had an actual 0
    negpos_cands = find(zc_locs_minus > zc_locs_plus(pospos));
    if (length(negpos_cands) < 1)
      break;
    else
      negpos = negpos_cands(1);
    end
  end
            
  
  [peakvals(numpeaks), peaks(numpeaks)] = max(acorr_slice(zc_locs_plus(pospos):zc_locs_minus(negpos)));

  peaks(numpeaks) = peaks(numpeaks) +zc_locs_plus(pospos)-1;
    
  negpos = negpos + 1;
  pospos = pospos + 1;
end

if (numpeaks == 0) 
  peaks = 0;
  peakvals = 0; % for compatibility reasons
end


% to see them, do
% plot(peaks, peakvals, 'r+');





