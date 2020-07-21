
% Data Edit
%[distance good out to, sigma-s(b), sigma-a(b), sigma-f(b), numb density(at/cm^3), xN]
addpath('cst')
global len
len_temp=len;
load('Parameter.mat')
len = len_temp;
% Here, parameters go U-235, U-238, Oxygen, Hydrogen
data=[len/2-lenReactor/2,0,0,10^-10,1,0,0,0,1,3.98,0.00019,0,3.34*10^22,32.16,0.332,0,6.67*10^22;
      len/2+lenReactor/2,681,91,637,7.34171*10^20,2.7,11.98,2.02*10^-05,2.34*10^22,3.98,0.00019,0,1.67*10^22,32.16,0.332,0,3.34*10^22;
      len*2,0,0,0,1,0,0,10^-10,1,3.98,0.00019,0,3.34*10^22,32.16,0.332,0,6.67*10^22];
save('dat/calc_data.mat','data')