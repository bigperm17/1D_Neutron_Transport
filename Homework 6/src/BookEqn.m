function [analytical_ans] = BookEqn(datafile)  
    %Code calculates necissary enrichment based on equation 8-65 in Lamarsh;
    
%     clear
%     clc
%     close all
%     datafile = 'dat/calc_data.mat';
    
    global nu
    load(datafile)
    exit = 0;
    enrich = 0;
    i = 1;
    
    eta =  [2.0651, 2.0632, 2.0595, 2.0504, 2.0423, 2.0366, 2.0328];
    ga35 = [0.9780, 0.9610, 0.9457, 0.9294, 0.9229, 0.9182, 0.9118];
    gf35 = [0.9759, 0.9581, 0.9411, 0.9208, 0.9108, 0.9036, 0.8956];
    ga38 = [1.0017, 1.0031, 1.0049, 1.0085, 1.0122, 1.0159, 1.0198];

    while exit == 0;
        enrich = 10^-9+enrich;
        Nd35 = enrich*data(2,5)/0.03;
        Nd38 = (1-enrich)*data(2,9)/0.97;
        sigma_f35 = data(2,4)*Nd35;
        sigma35 = data(2,3)*Nd35;
        sigma38 = data(2,7)*Nd38;
        sigmaH2O = data(2,11)*data(2,13)+data(2,15)*data(2,17);
        eta_act = eta(i);
        eta_calc = nu*sigma_f35*gf35(i)/(sigma35*ga35(i)+sigma38*ga38(i)+sigmaH2O);
        if eta_act <= eta_calc || enrich >= 1
            exit = 1;
        end
    end

    analytical_ans = enrich;
    
    
    
    
    
 end