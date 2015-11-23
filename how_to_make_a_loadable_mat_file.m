%When you run this code your matlab path have to be the same where the
%'workspace 20151118.mat' is
load('workspace 20151118.mat');
y = plsmodel20151118_norm_meanc.content;
save('Ditty_1000_2', 'y')