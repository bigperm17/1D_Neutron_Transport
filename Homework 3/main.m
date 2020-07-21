clear
clc
close all

addpath('src')
addpath('cst')
parameters();
global datafile
datafile='dat/geometry.txt';
sig_a_empty=0;
global sigma_a
global phi_e
global len
global deltax
global plots
plots = {};
l=len;


for i=1:4
    if i==1
        phi_e = 500.;
        size = int32(len/deltax);
        sigma_a=sig_a_empty*ones(1,size);
    end
    
    if i==2
        diffusion_coefficient = [];
        phi_e=0;
        global macrosig
        deltax = 1;
        len = len+0.71/macrosig;
        size = int32(len/deltax);
        sigma_a=sig_a_empty*ones(1,size);
    end
    
    if i==3
        diffusion_coefficient = geometry();
        sigma_a = (1./(diffusion_coefficient.*3)).*0.5;
        diffusion_coefficient = macrosig./(3.*(sigma_a + macrosig).^2);
    end
    
    if i==4
        datafile='dat/geometry2.txt';
        diffusion_coefficient = geometry();
        size = int32(len/deltax);
        sigma_a=(0.0035*.113)*ones(1,size+1);
        diffusion_coefficient = macrosig./(3.*(sigma_a + macrosig).^2);
    end
    
    if i<3
        diffusion_coefficient = geometry();
    end
    
    flux = solver1(diffusion_coefficient);
    graphs(flux)
    
    if length(flux)<50
        flux=min(flux);
    else
        flux=flux(51,1);
    end
    
    fprintf('Flux:\n%0.4f\n\n',flux)
end

figure
for j=1:i
    set(gcf, 'Position', [600,200,800,600])
    subplot(2,2,j)
    plot(plots{j,1},plots{j,2})
    
    if j~=1
        hold on
        global phi0
        plot(l*ones(1,phi0),1:phi0)
        hold off
    end
    
end