function [M,s] = EigenSolveSetup(diffusion_coefficient)

global sigma_f
global nu
global len
global deltax

sigma_fission=zeros(length(sigma_f)-2);
for i=1:length(sigma_f)-2
    if sigma_f<10^-7
        sigma_fission(i,i)=Inf
    else
        sigma_fission(i,i)=-sigma_f(i)*nu;
    end
end

M_p2 = sigma_fission^(-1);
[r,c]=size(M_p2);
for i=1:r
    for j=1:c
        if abs(M_p2(i,j))>10^10
            M_p2(i,j)=0;
        end
    end
end

s = int32(len/deltax) - 1;
matrice_coefficients = buildmatrix(s, diffusion_coefficient);
M_p1 = matrice_coefficients;
M=M_p2*M_p1;