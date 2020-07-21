clear
clc
close all

addpath('src')
addpath('cst')
addpath('dat')

global len
global deltax
global macrosig
global sigma_f
global nu
global phi0
global phi_e

tic
for j=1:2
    parameters();
    l=len;
    balance=-100;
    enrichment=0.00711;
    enrichment_1=0;
    change=enrichment;
    factor=8;
    it = 1;
    
    if j == 1
        Power = 1;  %J/m^3
    else
        Power = 1000;   %J/m^3
    end
    while balance~=0
        %clc
        fprintf('Running iteration %0.0f\n',it)
        parameters();
        load(datafile)
        data(5)=data(5)/0.03*enrichment;
        data(6)=data(6)/0.97*(1-enrichment);
        
        e=100;
        len2=0;
        while e>.05
            diffusion_coefficient = modified_geometry(data);
            len = len+2*max(0.71./macrosig);
            diffusion_coefficient = modified_geometry(data);
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

        fiss = 0;
        absorb = 0;
        for i=2:length(flux)
            fiss=fiss+flux(i)*sigma_f(i); %200*10^-13 --> J/fission
            absorb=absorb+flux(i)*diffusion_coefficient(i);
        end
        J=-diffusion_coefficient(2)*(flux(1)-flux(2))/deltax;
        J=J*2;
        balance = fiss-absorb-J;
        
        if abs(change)<=10^-9
            balance = 0;
        else
            if balance<0
                enrichment = enrichment+change;
            else
                enrichment = enrichment-change;
            end
        end
        
        change=abs(enrichment-enrichment_1)/2;
        enrichment_1=enrichment;
        it = it + 1;
    end
    
    flux_fin(j) = enrichment;
end
toc
fprintf('Q1:\nEnrichment:\t%0.4f%% U-235\n\nQ2:\n',flux_fin(1)*100)

if flux_fin(1)==flux_fin(2)
    fprintf('No, the enrichment is not dependent on reactor power.\n')
else
    fprintf('Yes, the enrichment is dependent on reactor power.\n')
end






