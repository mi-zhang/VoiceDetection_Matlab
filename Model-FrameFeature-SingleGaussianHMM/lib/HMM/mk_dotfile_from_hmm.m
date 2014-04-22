function mk_dotfile_from_hmm(A, B, startprob, endprob, filename)
% MK_DOTFILE_FROM_HMM Make a picture of the HMM using the dot file format
% function mk_dotfile_from_hmm(A, B, startprob, endprob, filename)
%
% For details on dot, see http://www.research.att.com/sw/tools/graphviz
% To print the file, type 'dot -Tps foo.dot -o foo.ps'   
%
% If A(i,j) > 0, we draw and arc from state i to state j.
%
% Start states are marked with +, end states with - e.g., "+5-"
% Set startprob/endprob = [] to prevent this.
%
% All discrete symbols with non-zero prob are shown.
% e.g., "+5 : 1 3 7" if state 5 emits 1,3, and 7.
% Set B = [] to prevent this.
%
% If filename is omitted, we use 'tmp.dot' and convert this to 'tmp.ps'
% and open ghostview automatically

if nargin < 2, B = []; end
if nargin < 3, startprob = []; end
if nargin < 4, endprob = []; end
if nargin < 5, filename = []; end

Q = length(A);

arclabel = cell(Q,Q);
G = zeros(Q,Q);
for i=1:Q
  for j=1:Q
    if approxeq(A(i,j), 0)
      arclabel{i,j} = '';
    else
      G(i,j) = 1;
      arclabel{i,j} = sprintf('%5.3f', A(i,j));
    end
  end
end


nodelabel = cell(1,Q);
for i=1:Q
  % annotate start/stop states
  if ~isempty(startprob) & ~approxeq(startprob(i), 0)
    start = '+';
  else
    start = '';
  end
  if ~isempty(endprob) & ~approxeq(hmm.endprob(i), 0)
    stop = '-';
  else
    stop = '';
  end
  label = sprintf('%s%d%s :', start, i, stop);

  if ~isempty(B)
    output_label = mk_output_label(B);
    label = strcat(label, output_label);
  end
  
  nodelabel{i} = label;
end


if isempty(filename)
  filename = 'tmp.dot';
  mkdot(G, filename, arclabel, nodelabel)  
  !dot -Tps tmp.dot -o tmp.ps
  !ghostview tmp.ps &
else
  mkdot(G, filename, arclabel, nodelabel)  
end


%%%%%%%%%

function label = mk_output_label(B)

[Q O] = size(B);
label = '';

if 0
  % print most probable symbols
  for i=1:Q
    m = max(B(i,:));
    ndx = find(abs(B(i,:) - repmat(m,1,O)) < 1e-2);
    %ndx = find(B(i,:)==m);
    %label = sprintf('%d,', ndx);
  end
end

if 0
  % print prob distrib over all symbols 
  for o=1:O
    if approxeq(B(i,o), 0)
      %
    else
      label = strcat(label, sprintf('%d(%3.2f),', o, B(i,o)));
    end
  end
end

if 1
  % print all non-zero symbols
  chars = ['a' 'b' 'c'];
  for o=1:O
    if approxeq(B(i,o), 0)
      %
    else
      label = strcat(label, sprintf('%s', chars(o)));
    end
  end
end
