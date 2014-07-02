function [m] = generateVoicingCPT(v_given_s)

hmmTransmat = [0.98831555533300   0.01168444466700;
               0.01229634344002   0.98770365655998];
           

s_cpt = [(1 - v_given_s) v_given_s];


m = '';
for s=1:2
    for v=1:2
        on = mean([hmmTransmat(v,2), s_cpt(s)]);
        off = (1 - on);
        m = [m sprintf('%25.15e %25.15e %%%g,%g\n', off, on, s-1, v-1)];
    end
end
