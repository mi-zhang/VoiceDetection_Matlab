function acorr = bruteAutocorr(sig, zp)

sig = sig - mean(sig);
acorr = zeros(size(sig));

v = var(sig,1)*length(sig);

%v=0;
%for i=1:length(sig)
%    v = v + (sig(i)-mx)^2;
%end


for k=1:length(sig)
    
    % shift signal and zero pad
    if(zp) 
        nsig = [sig(k:end) zeros(1,k-1)];
    else
        nsig = circshift(sig', k-1)';
    end
    
    acorr(k) = sum(sig .* nsig) / v;
    
end
        
    