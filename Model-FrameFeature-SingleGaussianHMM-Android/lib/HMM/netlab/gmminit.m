function mix = gmminit(mix, x, options)
%GMMINIT Initialises Gaussian mixture model from data
%
%	Description
%	MIX = GMMINIT(MIX, X, OPTIONS) uses a dataset X to initialise the
%	parameters of a Gaussian mixture model defined by the data structure
%	MIX.  The k-means algorithm is used to determine the centres. The
%	priors are computed from the proportion of examples belonging to each
%	cluster. The covariance matrices are calculated as the sample
%	covariance of the points associated with (i.e. closest to) the
%	corresponding centres. For a mixture of PPCA model, the PPCA
%	decomposition is calculated for the points closest to a given centre.
%	This initialisation can be used as the starting point for training
%	the model using the EM algorithm.
%
%	See also
%	GMM
%

%	Copyright (c) Ian T Nabney (1996-9)

[ndata, xdim] = size(x);

% Check that inputs are consistent
errstring = consist(mix, 'gmm', x);
if ~isempty(errstring)
  error(errstring);
end

% Arbitrary width used if variance collapses to zero: make it 'large' so
% that centre is responsible for a reasonable number of points.
GMM_WIDTH = 1.0;

perm = randperm(ndata);
perm = perm(1:mix.ncentres);

% Assign first ncentres (permuted) data points as centres
mix.centres = x(perm, :);
options(5) = 0;	

% Use kmeans algorithm to set centres
[mix.centres, options, post] = kmeans(mix.centres, x, options);

% Set priors depending on number of points in each cluster
cluster_sizes = max(sum(post, 1), 1);  % Make sure that no prior is zero
mix.priors = cluster_sizes/sum(cluster_sizes); % Normalise priors

switch mix.covar_type
case 'spherical'
   if mix.ncentres > 1
      % Determine widths as distance to nearest centre 
      % (or a constant if this is zero)
      cdist = dist2(mix.centres, mix.centres);
      cdist = cdist + diag(ones(mix.ncentres, 1)*realmax);
      mix.covars = min(cdist);
      mix.covars = mix.covars + GMM_WIDTH*(mix.covars < eps);
   else
      % Just use variance of all data points averaged over all
      % dimensions
      mix.covars = mean(diag(cov(x)));
   end
  case 'diag'
    for i = 1:mix.ncentres
      % Pick out data points belonging to this centre
      c = x(find(post(:,i)),:);
      diffs = c - (ones(size(c, 1), 1) * mix.centres(i, :));
      mix.covars(i,:) = sum((diffs.*diffs), 1)/size(c, 1);
      % Replace small entries by GMM_WIDTH value
      mix.covars(i,:) = mix.covars(i,:) + GMM_WIDTH.*(mix.covars(i,:)<eps);
    end
  case 'full'
    for i = 1:mix.ncentres
      % Pick out data points belonging to this centre
      c = x(find(post(:,i)),:);
      diffs = c - (ones(size(c, 1), 1) * mix.centres(i, :));
      mix.covars(:,:,i) = (diffs'*diffs)/(size(c, 1));
      % Add GMM_WIDTH*Identity to rank-deficient covariance matrices
      if rank(mix.covars(:,:,i)) < mix.nin
	mix.covars(:,:,i) = mix.covars(:,:,i) + GMM_WIDTH.*eye(mix.nin);
      end
    end
  case 'ppca'
    for i = 1:mix.ncentres
      % Pick out data points belonging to this centre
      c = x(find(post(:,i)),:);
      diffs = c - (ones(size(c, 1), 1) * mix.centres(i, :));
      [mix.covars(i), mix.U(:,:,i), mix.lambda(i,:)] = ...
        ppca((diffs'*diffs)/size(c, 1), mix.ppca_dim);
    end
  otherwise
    error(['Unknown covariance type ', mix.covar_type]);
end

