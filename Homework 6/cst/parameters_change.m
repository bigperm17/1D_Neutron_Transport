function [] = parameters_change()

load('Parameter.mat')
global deltax;
deltax = deltax*2;
save('cst/Parameter.mat','lenReactor', 'deltax','phi0','phi_e','nu','datafile', 'len','lenJacket')


end

