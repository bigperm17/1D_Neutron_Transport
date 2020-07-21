function [matrice_coefficients] = buildmatrix(s, diffusion_coefficient)
    matrice_coefficients = [];
    for i = 1:s
       line = zeros(1, s);
       global sigma_a
       global deltax
       if i == 1
           line(i) = (diffusion_coefficient(i) + 2*diffusion_coefficient(i+1) + diffusion_coefficient(i+2)) + sigma_a(i+1)*deltax^2;
           line(i+1) = diffusion_coefficient(i+1) + diffusion_coefficient(i+2);
       elseif i == s
           line(i-1) = diffusion_coefficient(i-1) + diffusion_coefficient(i);
           line(i) = (diffusion_coefficient(i-1) + 2*diffusion_coefficient(i) + diffusion_coefficient(i+1)) + sigma_a(i+1)*deltax^2;
       else
           line(i-1) = diffusion_coefficient(i) + diffusion_coefficient(i+1);
           line(i) = (diffusion_coefficient(i) + 2*diffusion_coefficient(i+1) + diffusion_coefficient(i+2)) + sigma_a(i+1)*deltax^2;
           line(i+1) = diffusion_coefficient(i+1) + diffusion_coefficient(i+2);
       end
       matrice_coefficients = [matrice_coefficients; line];
    end
end
