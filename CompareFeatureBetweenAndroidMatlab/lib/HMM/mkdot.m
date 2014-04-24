function mkdot(G, filename, arclabel, nodelabel)
% MKDOT Make a file representing the directed graph in dotty format.
% mkdot(G, filename, arclabel, nodelabel)
%
% arclabel{i,j} is a string attached to the i->j arc. Default ""
% nodelabel{i} is a string attached to node i. Default "i".
%
% See http://www.research.att.com/sw/tools/graphviz
% To print the file, type 'dot -Tps foo.dot -o foo.ps'

n = length(G);
if ~exist('nodelabel')
  nodelabel = cell(1,n);
  for i=1:n
    nodelabel{i} = num2str(i);
  end
end

fid = fopen(filename, 'w');
fprintf(fid, 'digraph G {\n');
fprintf(fid, 'center = 1;\n');
fprintf(fid, 'size=\"4,4\";\n');
for i=1:n
  %fprintf(fid, '"n%d" [ label = "%s" ];\n', i, nodelabel{i});
  fprintf(fid, 'n%d [ label = "%s" ];\n', i, nodelabel{i});
end
for i=1:n
  cs = children(G,i);
  for j=1:length(cs)
    c = cs(j);
    %fprintf(fid, '"n%d" -> "n%d";\n', i, c);
    if exist('arclabel')
      fprintf(fid, 'n%d -> n%d [label="%s"];\n', i, c, arclabel{i,c});
    else
      fprintf(fid, 'n%d -> n%d;\n', i, c);
    end
  end
end
fprintf(fid, '\n}');
fclose(fid);
