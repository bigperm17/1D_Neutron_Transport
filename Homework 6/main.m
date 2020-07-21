clear all
clc
close all
warning('off','all')

addpath('cst')
addpath('dat')
addpath('src')

for j=1:2
    tic
    time_limit = 100; %time, in seconds, you want program to run
    %time_limit = input('How long do you want this program to run (sec)?   ');
    parameters()
    enrichment=0.000711;
    enrichment_1=0;
    change=0.00711;
    it = 1;
    Power = 1; %J/m^3
    parameters_HW6(j)
    
    while abs(change)>10^-9

        clc
        fprintf('Running iteration %0.0f\nEnrichment: %0.3f%%\n',it,enrichment*100)
        if toc>time_limit/50*it
            parameters_change();
        else
            load('Parameter.mat');
        end
        tic
        
        diffusion_coefficient = modified_geometry(enrichment);

        [M,s] = EigenSolveSetup(diffusion_coefficient);
        
        flux=flux_fix(M,s,Power);
        
        [change, enrichment] = NeutronBalance(flux,change,enrichment,enrichment_1,diffusion_coefficient);
        enrichment_1=enrichment;
        it = it + 1;
    end
    
    flux_fin(j) = enrichment;
end
parameters()

analytical_ans = BookEqn(datafile)

Answers(flux_fin,analytical_ans)

fprintf('I know that the enrichment should decrease when the reactor has a reflector, I just\n')
fprintf('don''t know what''s wrong with the code.\n')

warning('on','all')



