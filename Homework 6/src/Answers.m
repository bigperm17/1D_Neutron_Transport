function []=Answers(flux_fin, analytical_ans)
    clc
    fprintf('Q1:\nEnrichment:\t%0.4f%% U-235\n\nQ2:\n',flux_fin(2)*100)
    
    if abs(1-flux_fin(1)/flux_fin(2))<=10^-7
        fprintf('No, the enrichment is the same with and without a reflector.\n\n')
    else
        fprintf('Yes, the enrichment is different with and without a refoector.\n\n')
    end
    
    fprintf('Q3:\nBare Reactor Analytical Flux:\t%0.4f%% U-235\n',analytical_ans*100)
    
end