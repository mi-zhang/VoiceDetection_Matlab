function audio = GetAudioSeq(journalfile,audiofile,t0,N)


J=Journal(journalfile);
I = matlabjournal('Journal_OpenAudioSequence',ptr(J),audiofile);
X=matlabfm('new_ShortVector');
matlabjournal('AudioSequence_SequentialSeekByTime',I,t0);

for i=1:N
    matlabjournal('AudioSequence_SequentialRead',I,X);
    %x=matfm('ShortVector2mxArray',X);
    audio(:,i)=matfm('ShortVector2mxArray',X);
end
%disp('Read audio frames')
audio=double(audio(:));
matlabjournal('delete_AudioSequence',I);
matlabfm('delete_ShortVector',X);
delete(J)