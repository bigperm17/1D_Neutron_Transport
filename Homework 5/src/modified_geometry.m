function [d_coeff] = modified_geometry(data)

    [diffusion_coefficient, distance, sigma_abs, sigma_fission] = get_diff_coeff(data);
    d_coeff = [];
    global deltax;
    global len;
    global sigma_a
    global sigma_f
    sigma_a = [];
    sigma_f = [];
    points = linspace(0, len, int32(len/deltax)+1);
    for i = 1:length(points)
        ix = find(distance>points(i),1);
        d_coeff = [d_coeff, diffusion_coefficient(ix)];
        sigma_a = [sigma_a, sigma_abs(ix)];
        sigma_f = [sigma_f, sigma_fission(ix)];
    end
end

    % file is structured as follows
    % [Max distance, sigma_s, sigma_a, sigma_f, number denisty,...]
    % Where ... is repeating sigma_s, sigma_a, sigma_f, number denisty for every
    % new component in that section of the reactor

function [diffusion_coefficient, distance, sigma_abs, sigma_fission] = get_diff_coeff(data)
    distance = [];
    diffusion_coefficient = [];
    [row,column]=size(data);
    for i=1:row
        d=data(i,1);
        global macrosig
        sigma_abs=[];
        sigma_fission=[];
        macrosig_a=0.;
        macrosig_f=0.;
        macrosig=0.;
        for j=2:4:column
            macrosig=macrosig+data(i,j)*data(i,j+3)*10^-24;
            macrosig_a=macrosig_a+data(i,j+1)*data(i,j+3)*10^-24;
            macrosig_f=macrosig_f+data(i,j+2)*data(i,j+3)*10^-24;
        end

        distance = [distance, d];
        diffusion_coeff = macrosig / (3 * (macrosig_a+macrosig)^2);
        diffusion_coefficient = [diffusion_coefficient, diffusion_coeff];
        sigma_abs=[sigma_abs, macrosig_a];
        sigma_fission=[sigma_fission, macrosig_f];
    end
end