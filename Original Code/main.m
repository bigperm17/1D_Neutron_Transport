addpath('src')
addpath('cst')
parameters();
diffusion_coefficient = geometry();
flux = solver1(diffusion_coefficient);
graphs(flux)

