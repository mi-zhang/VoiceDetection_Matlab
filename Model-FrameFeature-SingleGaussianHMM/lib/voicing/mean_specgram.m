function mean_spec = mean_specgram(specg,adding_matrix)

Mgram=specg'*adding_matrix;
Mgram=Mgram';
mean_spec=Mgram./500;