function [I_result] = compute_local_single(I, I_pi)
%COMPUTE_LOCAL_MAX Compute single idleness
%   Detailed explanation goes here

[map_size_x, map_size_y] = size(I);

I_result = zeros(map_size_x, map_size_y); %Back up data
for i=1:map_size_x
    for j=1:map_size_y
        if I_pi(i,j) > 0
            I_result(i, j) = I(i, j);
        end
    end
end



end
