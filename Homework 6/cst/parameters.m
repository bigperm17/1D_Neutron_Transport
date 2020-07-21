%Reactor size (cm)
lenReactor =  100;

%Step Size
global deltax;
deltax = 0.1;

% LHS Boundary
global phi0;
phi0 = 0.;

% RHS Boundary
global phi_e;
phi_e = 0;

% Neutrons per Fission
global nu
nu = 2.4355;

% File that has cross section data
global datafile
datafile='dat/calc_data.mat';

save('cst/Parameter.mat','lenReactor', 'deltax','phi0','phi_e','nu','datafile')

