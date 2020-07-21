function [d_coeff] = geometry()

    [diffusion_coefficient, distance] = get_diff_coeff();
    d_coeff = [];
    global deltax;
    global len;
    points = linspace(0, len, int32(len/deltax)+1);
    for i = 1:length(points)
        ix = find(distance>points(i),1);
        d_coeff = [d_coeff, diffusion_coefficient(ix)];
    end
end

function [diffusion_coefficient, distance] = get_diff_coeff()
    filetext = fileread('dat/geometry.txt');
    filetext = strsplit(filetext,'\n');
    distance = [];
    diffusion_coefficient = [];
    for idx = 1:numel(filetext)
       line_1 = filetext(idx);
       if line_1{1}(1) == '#'
          continue 
       end
       line_2 = strsplit(line_1{1}, ';');
       d = str2double(line_2{1});
       composition = strsplit(line_2{2}, ',');
       numcomp = length(composition);
       macrosig = 0.;
       for c = 1:numcomp
           material = strsplit(composition{c}, ':');
           macrosig = macrosig + str2double(material{1}) * str2double(material{2}) * 1e-24;
       end
       distance = [distance, d];
       diffusion_coeff = 1 / (3 * macrosig);
       diffusion_coefficient = [diffusion_coefficient, diffusion_coeff];
    end
end