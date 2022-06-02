function [I_result] = compute_local_sum_weight(I, I_pi, obs_range)
%COMPUTE_LOCAL_MAX Summary of this function goes here
%   Detailed explanation goes here

[map_size_x, map_size_y] = size(I);

I_nbr_pi = zeros(map_size_x, map_size_y); %Get the number of PI observed by each cell 
for i=1:map_size_x
    for j=1:map_size_y
        [start_x, end_x, start_y, end_y] = get_window(i, j, obs_range, map_size_x, map_size_y);
        s = sum(I_pi(start_x:end_x, start_y:end_y), 'all');
        if s > 0
            I_nbr_pi(i,j) = 1/sum(I_pi(start_x:end_x, start_y:end_y), 'all'); %Weight of each cell
        else
            I_nbr_pi(i,j) = 0;
        end
    end
end

I_result = zeros(map_size_x, map_size_y); %Back up data
for i=1:map_size_x
    for j=1:map_size_y
        if I_pi(i,j) > 0
            [start_x, end_x, start_y, end_y] = get_window(i, j, obs_range, map_size_x, map_size_y);
            I_result(i, j) = sum(I(start_x:end_x, start_y:end_y).*I_nbr_pi(start_x:end_x, start_y:end_y), 'all');
        end
    end
end
%DEBUG
% I
% I_nbr_pi
% I_result
% disp("End")


end
