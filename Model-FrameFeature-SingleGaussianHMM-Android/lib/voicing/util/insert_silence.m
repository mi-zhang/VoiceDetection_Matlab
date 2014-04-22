function [ssig] = insert_silence(sig, numregions, minlen, maxlen)

ssig = sig;

for i=1:numregions
    len = minlen + round(rand * maxlen);
    start = round(rand * size(sig,1));
    
    send = start+len;
    if(send > length(ssig))
        send = length(ssig);
    end
    ssig(start:send) = 0;
end
    