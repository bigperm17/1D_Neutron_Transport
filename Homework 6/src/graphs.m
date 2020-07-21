function []=graphs(flux)
    
    close all
    global len
    global deltax
    
    figure
    for i=1:length(flux)
        xval(i)=(-len/(2*deltax)+i-1)*deltax;
        yval(i)=flux(i);
    end
    plot(xval,yval)
    pause(0.001)
    
end