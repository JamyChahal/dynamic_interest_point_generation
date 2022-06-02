function [I_result] = compute_local_sum(I, I_pi, obs_range)
%COMPUTE_LOCAL_MAX Summary of this function goes here
%   Detailed explanation goes here

[map_size_x, map_size_y] = size(I);

I_result = zeros(map_size_x, map_size_y); %Back up data
for i=1:map_size_x
    for j=1:map_size_y
        if I_pi(i,j) > 0
            [start_x, end_x, start_y, end_y] = get_window(i, j, obs_range, map_size_x, map_size_y);
            I_result(i, j) = sum(I(start_x:end_x, start_y:end_y), 'all');
        end
    end
end



end
