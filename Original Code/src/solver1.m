function [flux] = solver1(diffusion_coefficient)
    global len;
    global deltax;
    size = int32(len/deltax) - 1;
    global phi0;
    global phi_e;
    matrice_coeff = buildmatrix(size, diffusion_coefficient);
    rhs = zeros(size, 1);
    rhs(1) = -(diffusion_coefficient(1) + diffusion_coefficient(2)) * phi0;
    rhs(size) = -(diffusion_coefficient(size-1) + diffusion_coefficient(size)) * phi_e;
    flux = linsolve(matrice_coeff, rhs);
    flux = [phi0; flux; phi_e];
end

function [matrice_coefficients] = buildmatrix(size, diffusion_coefficient)
    matrice_coefficients = [];
    for i = 1:size
       line = zeros(1, size);
       if i == 1
           line(i) = -(diffusion_coefficient(i) + 2*diffusion_coefficient(i+1) + diffusion_coefficient(i+2));
           line(i+1) = diffusion_coefficient(i+1) + diffusion_coefficient(i+2);
       elseif i == size
           line(i-1) = diffusion_coefficient(i-1) + diffusion_coefficient(i);
           line(i) = -(diffusion_coefficient(i-1) + 2*diffusion_coefficient(i) + diffusion_coefficient(i+1));
       else
           line(i-1) = diffusion_coefficient(i) + diffusion_coefficient(i+1);
           line(i) = -(diffusion_coefficient(i) + 2*diffusion_coefficient(i+1) + diffusion_coefficient(i+2));
           line(i+1) = diffusion_coefficient(i+1) + diffusion_coefficient(i+2);
       end
       matrice_coefficients = [matrice_coefficients; line];
    end
end

