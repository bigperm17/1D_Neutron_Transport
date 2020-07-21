function [] = parameters_HW6(j)
    
    load('Parameter.mat')
    
    %size of one side of the jacket (Assumes its symmetric)
    if j == 1
        lenJacket = 0;
    else
        lenJacket = 50;
    end
    
    %Size of system to solve
    global len;
    len = lenReactor+2*lenJacket;
    
    save('cst/Parameter.mat','lenReactor', 'deltax','phi0','phi_e','nu','datafile', 'len','lenJacket')

    
end
