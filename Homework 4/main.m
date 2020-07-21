clear
clc
close all

addpath('src')
addpath('cst')

parameters();
global len
global deltax
global macrosig
global sigma_f
global nu
global phi0
global phi_e
global Power  %J/m^3
l=len;
e=100;
len2=0;

while e>.05
    diffusion_coefficient = modified_geometry();
    len = len+2*max(0.71./macrosig);
    diffusion_coefficient = modified_geometry();
    e=abs((len2-len)/len);
    len2=len;
end

sigma_fission=zeros(length(sigma_f)-2);

for i=1:length(sigma_f)-2
    sigma_fission(i,i)=-sigma_f(i)*nu;
end

M_p2 = sigma_fission^(-1);
s = int32(len/deltax) - 1;
matrice_coefficients = buildmatrix(s, diffusion_coefficient);
M_p1 = matrice_coefficients;
M=M_p2*M_p1;

[V, D] = eig(M);
loc=max(max(abs(D)));

for i=1:s
    if abs(D(i,i))==loc
        r=i;
    end
end

flux=zeros(1,s+2);

for i=2:s+1
    flux(i)=V(i-1,r);
    flux(1)=phi0;
    flux(s+2)=phi_e;
end

P=0;
for i=1:length(flux)
    P=P+flux(i)*sigma_f(i)*nu*200*10^-13; %200*10^-13 --> J/fission
end

mult=Power/P;
flux=mult*flux;

figure
for i=1:length(flux)
    xval(i)=(-len/(2*deltax)+i-1)*deltax;
    yval(i)=flux(i);
    if abs(xval(i)-l/2)<=deltax/2
        flux_fin = yval(i);
        fprintf('Flux:\n%0.4e\n\n',flux_fin)
    end
end
plot(xval,yval)






