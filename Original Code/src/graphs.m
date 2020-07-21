function [] = graphs(flux)
%GRAPHS Summary of this function goes here
%   Detailed explanation goes here
    global deltax;
    global len;
    points = linspace(0, len, int32(len/deltax)+1);
    plot(points, flux);
end

