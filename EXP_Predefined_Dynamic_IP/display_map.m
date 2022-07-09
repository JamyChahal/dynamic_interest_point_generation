function [Im_display] = display_map(Im_map, t)
%DISPLAY_MAP Summary of this function goes here
%   Detailed explanation goes here
[a, b] = size(Im_map);
Im_display = ones(a, b, 3);
Im_display(:, :, 1) = 1; 
Im_display(:, :, 2) = 0.5; 
Im_display(:, :, 3) = 0;
for i=1:a
    for j=1:b
        if Im_map(i, j) == 0
            Im_display(i, j, 1) = 0;
            Im_display(i, j, 2) = 0;
            Im_display(i, j, 3) = 0;
        else
            if t(i,j) == 0.5
                Im_display(i, j, 1) = 0;
                Im_display(i, j, 2) = 190/255;
                Im_display(i, j, 3) = 0;
            end
        end
            if t(i,j) == 1
    %                 Im_display(i, j, 1) = 1;
    %                 Im_display(i, j, 2) = 1;
    %                 Im_display(i, j, 3) = 45/255;
                  Im_display = insertMarker(Im_display, [j i], 'x', 'color', 'red');
            end

        
        
    end
end
end

