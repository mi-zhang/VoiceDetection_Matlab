


function T = estimate_T_table(state_vals, num_states)
% function trans = estimate_T_table(state_vals, num_states)
% estimates T table for Markov model
%
% num_states is an int that specifies the number of states in the
% chain
% state_vals is a vector of the state values, *beginning with 1, not 0*
%
% and T = is the trans. table for the chain, where
%     T(k,l) is the trans prob from state k to state l


% 1e-5 term is to normalize for cases of zero counts
	T = zeros(num_states,num_states) + 1e-5;

	for k = 1:num_states
	  % we want all the times when the state val is k and then 
	  
	  
	  % indices of times when state =l
	  k_times = find(state_vals == k);
	  % indices of times for chain i when at t-1, j=l
	  post_k_times = k_times+1; 
	  
	  if (length(post_k_times) > 0)
		  if (post_k_times(end) > length(state_vals))
			  post_k_times = post_k_times(1:length(post_k_times)-1);
		  end
		  
		  for l = 1:num_states
			  T(k,l) = T(k,l) + length(find(state_vals(post_k_times) == l));
		  end
	  else
		  disp(k)
		  T(k,:) = ones(1,size(T,2));
	  end
	  
	  % normalize each col
	  T(k,:) = T(k,:)/sum(T(k,:));
    end

    
