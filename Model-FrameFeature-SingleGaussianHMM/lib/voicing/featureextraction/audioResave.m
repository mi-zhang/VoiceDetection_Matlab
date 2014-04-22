function [ y ] = audioResave( infile, outfile )

err = lasterr('');

try
    d = load(infile);
    wavwrite(d.data.sig, 8192, 16, outfile);
    y=0;
catch
    lasterr
    y = 1;
end

