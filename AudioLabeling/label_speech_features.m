

function regions = label_speech_features(varargin)

% function y = label_speech_features()
%
% with options: label_speech_features('regions', regions, 'signal',
% soundsignal, 'framesize', framesize, 'framestep', framestep,
% 'segheight', segheight, 'samplingrate', samplingrate);
%
% commands
% a/e: start/end a region
% p: play most recent region
% s: select/deselect a boundary
% d: delete a region
% q: quit and save the regions
% z/x: zoom in/out
% r/t: nudge boundary to left/right
    

%     samplingrate = 16000;
%     samplingrate = 8000;
    samplingrate = 8192;
    
    specxbounds = get(gca, 'XLim');
    specybounds = get(gca, 'YLim');

    currfigure = 1;
    in_region = 0;
    maxnumlines = 1000;
    segheight = 256;
    regions = zeros(0,2);
    numregions = 0;
    regions_entered = 0;

    if nargin >= 0
        args = varargin;
        nargs = length(args);
        if ~isstr(args{1})
            error('label_speech_features: invalid arguments')
        end
        for i=1:2:nargs
            switch args{i},
                case 'regions', regions_entered = 1; regions = args{i+1};
                case 'samplingrate', samplingrate = args{i+1};
                case 'framesize', framesize = args{i+1};
                case 'framestep', framestep = args{i+1};
                case 'segheight', segheight = args{i+1};
                case 'signal', sig = args{i+1};
                otherwise,
                    error(['invalid argument name ' args{i}]);
            end
        end
    end

    % initialize variables
    mainline = line([0 0], [0 1]);
    set(mainline, 'EraseMode', 'xor');
    set(mainline, 'Marker', '+');
    pointlist = [0 0];
    numpoints = 1;
    selectionmode = 0;
    selectedpoint = 1;
    selectionhandle = line([0 0], [0 1]);
    set(selectionhandle, 'EraseMode', 'xor');

    starttemplate = [0 0; 0 segheight];
    stoptemplate = [0 0; 0 segheight];
    vhandles = zeros(maxnumlines,1);
    vlocs = zeros(maxnumlines,1);
    vtypes = zeros(maxnumlines,1); % 1 for start, 0 for stop
    numvlocs = 0;

    for i = 1:maxnumlines
        vhandles(i) = line([0 0], [0 0]);
        set(vhandles(i), 'EraseMode', 'xor');
    end

    % initialization - draw regions in input
    if (regions_entered)
        numregions = size(regions,1);
        vlocs(1:numregions) = regions(:,1);

        for i = 1:numregions
            set(vhandles(3*(i-1)+1), {'XData' 'YData'},...
                {regions(i,1) + starttemplate(:,1) starttemplate(:,2)});
            set(vhandles(3*(i-1)+2), {'XData' 'YData'},...
                {regions(i,2) + stoptemplate(:,1) stoptemplate(:,2)});
            set(vhandles(3*(i-1)+3), {'XData' 'YData'},...
                {[regions(i,1) regions(i,2)]' [segheight segheight]'});
        end
    end

    % mark voiced/unvoiced regions  => attempt tracking in sceps
    while(1)
        [xpos,ypos,button] = ginput(1);

        switch(button)
            
            case {'1'}
                currfigure=1;
                figure(1);
            
            case {'2'}
                currfigure=2;
                figure(2);

            case {'a'} % create a starthandle
                if (~in_region)
                    in_region = 1;
                    % make starthandle
                    numregions = numregions+1;
                    linenum = (numregions-1)*3+1;
                    set(vhandles(linenum),{'XData' 'YData'},...
                        {xpos + starttemplate(:,1) starttemplate(:,2)});
                    regions(numregions,1) = floor(xpos);
                else
                    fprintf(1,'already in a region...\n');
                end

            case {'p'}
                % play most recent region
                if (~in_region)
%                     startpt = round(regions(numregions,1)*framestep);
%                     endpt = round(regions(numregions,2)*framestep);
                    % [MZ]    
                    startpt = floor(regions(numregions,1)*framestep);
                    endpt = ceil(regions(numregions,2)*framestep);
                    soundsc(sig(startpt:endpt),samplingrate);
                end

            case {'l'}

                if numregions ~= 0
                    % play most recent region
                    flag_in_region = -1;
                    full_sig = [];

                    if (~in_region)
                        %startpt = round(regions(numregions,1)*framestep);
                        %endpt = round(regions(numregions,2)*framestep);
                        %soundsc(sig(startpt:endpt),samplingrate);
                        flag_in_region = 0;
                    end

                    for ii = 1:(numregions + flag_in_region)
                        startpt = round(regions(ii,1)*framestep);
                        endpt = round(regions(ii,2)*framestep);
                        %soundsc(sig(startpt:endpt),samplingrate);
                        full_sig = [full_sig ; sig(startpt:endpt)];
                    end

                    soundsc(full_sig,samplingrate);
                end

            case {'b'}
                disp('b is pressed');
            
            case {'e'} % create a vhandle
                if (in_region)
                    % make endhandle

                    % end must be > start
                    if (xpos < regions(numregions,1))
                        fprintf(1,'segment end must be after beginning\n');
                        continue;
                    end

                    linenum = (numregions-1)*3+2;
                    set(vhandles(linenum),{'XData' 'YData'},...
                        {xpos + stoptemplate(:,1) stoptemplate(:,2)});
                    regions(numregions,2) = ceil(xpos);

                    % make connector between start and end
                    linenum = (numregions-1)*3+3;
                    set(vhandles(linenum),{'XData' 'YData'},...
                        {[regions(numregions,1) regions(numregions,2)]' ...
                        [segheight segheight]'});

                    % done with region
                    in_region = 0;
                else
                    fprintf(1,'not in a region...\n');
                end

            case {'t'} % nudge vhandle to right
                if (selectionmode == 1)
                    regionnum = selectedpoint(1);
                    linenum = (regionnum-1)*3+selectedpoint(2);
                    xvals = get(vhandles(linenum), 'XData');
                    yvals = get(vhandles(linenum), 'YData');
                    regions(regionnum,selectedpoint(2)) = regions(regionnum,selectedpoint(2))+1;
                    set(vhandles(linenum),{'XData' 'YData'},{xvals+1 yvals});
                    % reset connector
                    linenum = (regionnum-1)*3+3;
                    set(vhandles(linenum),{'XData' 'YData'},...
                        {[regions(regionnum,1) regions(regionnum,2)]' ...
                        [segheight segheight]'});
                end
                
            case {'r'} % nudge vhandle to left
                if (selectionmode == 1)
                    regionnum = selectedpoint(1);
                    linenum = (regionnum-1)*3+selectedpoint(2);
                    xvals = get(vhandles(linenum), 'XData');
                    yvals = get(vhandles(linenum), 'YData');
                    regions(regionnum,selectedpoint(2)) = regions(regionnum,selectedpoint(2))-1;
                    set(vhandles(linenum),{'XData' 'YData'},{xvals-1 yvals});
                    % reset connector
                    linenum = (regionnum-1)*3+3;
                    set(vhandles(linenum),{'XData' 'YData'},...
                        {[regions(regionnum,1) regions(regionnum,2)]' ...
                        [segheight segheight]'});
                end
                
            case {'d'} % delete a region
                if (selectionmode == 1)

                    regionnum = selectedpoint(1);

                    % set its linestyle back to solid
                    set(vhandles( (regionnum-1)*3+selectedpoint(2)),'LineStyle','-');
                    selectionmode = 0;

                    % fill in the gap for the removed data
                    for i = regionnum:numregions-1
                        % fprintf(1, 'i: %d numvlocs: %d\n',i,numvlocs);
                        regions(i,:) = regions(i+1,:);
                        for k = 1:3
                            linenum = (i-1)*3+k;
                            xvals = get(vhandles(linenum+3), 'XData');
                            yvals = get(vhandles(linenum+3), 'YData');
                            set(vhandles(linenum),{'XData' 'YData'},{xvals yvals});
                        end
                    end

                    % "delete" the last point
                    for k = 1:3
                        linenum = (numregions-1)*3+k;
                        set(vhandles(linenum),{'XData' 'YData'},{[0 0] [0 0]});
                    end

                    numregions = numregions-1;
                end
                
            case {'m','f'} % move/forward a point
                if (selectionmode == 1)
                    vlocs(selectedpoint) = xpos;
                    if (vtypes(selectedpoint) == 1)
                        set(vhandles(selectedpoint),{'XData' 'YData'},...
                            {xpos + starttemplate(:,1) starttemplate(:,2)});
                    else
                        set(vhandles(selectedpoint),{'XData' 'YData'},...
                            {xpos + stoptemplate(:,1) stoptemplate(:,2)});
                    end

                end
                
            case {'s'} % select a point
                if (selectionmode == 0)
                    selectionmode = 1;

                    % look for both start and end points
                    [minstartdist,minstartpos] = min(abs(regions(:,1)-xpos));
                    [minenddist,minendpos] = min(abs(regions(:,2)-xpos));

                    if (minstartdist < minenddist)
                        selectedpoint = [minstartpos 1];
                    else
                        selectedpoint = [minstartpos 2];
                    end

                    selectionpos = regions(selectedpoint(1),selectedpoint(2));

                    % draw highlight
                    set(vhandles( (selectedpoint(1)-1)*3+selectedpoint(2)), 'LineStyle', ':');
                else
                    selectionmode = 0;
                    set(vhandles( (selectedpoint(1)-1)*3+selectedpoint(2)), 'LineStyle', '-');
                end
                
            case {'z'} % zoom in
                xbounds = get(gca, 'XLim');
                ybounds = get(gca, 'YLim');
                centerpt = [mean(xbounds) mean(ybounds)];
                viewwidth = xbounds(2)-xbounds(1);
                viewheight = ybounds(2)-ybounds(1);
                horizviewfrac = [xpos-xbounds(1) xbounds(2)-xpos];
                newxbounds = [(xpos-horizviewfrac(1)*.5)  (xpos+horizviewfrac(2)*.5)];
                newybounds = [0 (ybounds(2)*.5)];
                set(gca,'XLim', newxbounds);
                set(gca,'YLim', newybounds);
                
            case {'x'} % zoom out
                set(gca,'XLim', specxbounds);
                set(gca,'YLim', specybounds);
                
            case {'c'} % colorzoom: set current color to max
                if (currfigure == 2)
                    imagesc(sceps(:,1:(framesize/2))', [min(min(sceps)) sceps(floor(xpos),floor(ypos))]); colormap(jet); axis xy;
                end
                
            case {'v'}
                if (currfigure == 2)
                    imagesc(sceps(:,1:(framesize/2))'); colormap(jet); axis xy;
                end
                
            case 1
                disp(' mouse is clicked');
                
            case {'q'}
                regions = regions(1:numregions,:);

                full_sig = [];
              
                if numregions ~= 0
                    % play most recent region
                    flag_in_region = -1;


                    if (~in_region)
                        %startpt = round(regions(numregions,1)*framestep);
                        %endpt = round(regions(numregions,2)*framestep);
                        %soundsc(sig(startpt:endpt),samplingrate);
                        flag_in_region = 0;
                    end

                    for ii = 1:(numregions + flag_in_region)
%                         startpt = round(regions(ii,1)*framestep);
%                         endpt = round(regions(ii,2)*framestep);
                        % [MZ]
                        startpt = regions(ii,1);
                        endpt = regions(ii,2);
                        %soundsc(sig(startpt:endpt),samplingrate);
                        full_sig = [full_sig; sig(startpt:endpt)];
                        
                        % [MZ]
                        fprintf('startpt = %d\n', startpt);
                        fprintf('endpt = %d\n', endpt);                                       
                        
                    end
                    
                    %soundsc(full_sig,samplingrate);

                end
                
                full_sig = int16(full_sig);
%                 wavwrite(full_sig,samplingrate,16,'audio.wav');
                disp('exiting');
                break;
                
        end

    end
    
    

