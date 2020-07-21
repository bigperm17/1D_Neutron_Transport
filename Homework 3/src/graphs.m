function [] = graphs(flux)
%GRAPHS Summary of this function goes here
%   Detailed explanation goes here
    global deltax;
    global len;
    global plots;
    points = linspace(0, len, int32(len/deltax)+1);
    [r,c]=size(plots);
    plots{r+1,1}=points;
    plots{r+1,2}=rot90(flux);
    
end

