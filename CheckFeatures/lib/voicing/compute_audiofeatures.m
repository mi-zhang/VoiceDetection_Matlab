dir_name = '\\shortcuts\g\experiments\';
jrldir_name = 'h:\projects\Thesis\journal_files';
cd(dir_name);
date_vector_str=['030114'];
%ignore_sub=[];
num_days=size(date_vector_str,1);
nsamples= 482816;
time_elapsed = nsamples/8000;
feature_vecname=['Audio_f1';
    'Audio_f2';
    'Audio_f3';
    'Audio_f4';
    'Audio_f5'];
framesize = 256;
framestep = 128;


for d=1:num_days
    disp(['Processing tags from ',date_vector_str(d,:)]);
    date_dir = [dir_name date_vector_str(d,:)];
    cd(date_dir);
    file_names = dir;
    num_subjects = size(file_names,1);
    for i = 1:num_subjects
        if((file_names(i).name ~= '.' | file_names(i).name ~= '..') & file_names(i).isdir == 1 & isempty(findstr(file_names(i).name,ignore_sub))==1)
            dname = [file_names(i).name];   
            disp(['Processing ID ',dname]);
            fname = [date_dir,'\',dname,'\MyAudio.dat'];
            data_dir = [date_dir,'\',dname];
            Fileinfo = dir(fname);
            Fsize = Fileinfo.bytes;
            bytes_per_block = (2*nsamples);
            num_blocks = floor(Fsize/bytes_per_block);
            disp(['Total number of audio chunks: ',num2str(num_blocks)]);
            if(num_blocks>0)
                fid = fopen(fname,'r');
                jfile = [date_vector_str(d,:),'_',num2str(str2num(dname)),'.jrl'];
                jname = write_newjrl(jfile,jrldir_name,data_dir);
                atimes = GetTimes(0,1e300,jname,'MyAudio');
                start_time = atimes(1);
                features = [];
                feature_times = [];
                voicing_states =[];
                
                for j =1:num_blocks
                    xtest=fread(fid,(bytes_per_block/2),'bit16');
                    xseg = xtest;
                    xtest = (xtest./32513);
                    afeatures=voicing_features(xtest,framesize,framestep);
                    nfeatures = length(afeatures);
                    f_timesteps = 128/8000;
                    features = [features; afeatures];
                    time_ind = (round((j-1)*(482816/161)) + 1);
                    feature_times = [feature_times ((([0:nfeatures-1]).*f_timesteps)+atimes(time_ind))];
                    B = mk_ghmm_obs_lik(afeatures(:,1:3)', speech_mu,speech_cov) ;
                    [vit_path, loglik] = viterbi_path(prior1, transmat, B);
                    voicing_states = [voicing_states; vit_path'];
                end
                
                WriteScalar(jname,'voicing_states',feature_times',voicing_states);
                for k=1:5
                    WriteScalar(jname,feature_vecname(k,:),feature_times',features(:,k));
                end
            end
                
        end
    end
    cd(dir_name);
end
    
