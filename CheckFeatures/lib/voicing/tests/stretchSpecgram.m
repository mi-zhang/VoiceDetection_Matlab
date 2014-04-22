function nspec = stretchSpecgram(spec, framesize)

nfft = framesize / 2;

[nrows, ncols] = size(spec);

nspec = zeros(nrows, nfft);

factor = (nfft - 1) / ncols;

points = [1:ncols] * factor;
npoints = [1:nfft];

for i=1:nrows
    nspec(i,:) = interp1(points, spec(i,:), npoints, 'linear');
end