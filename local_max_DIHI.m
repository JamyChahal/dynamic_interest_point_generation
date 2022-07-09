function [I_IP] = local_max_DIHI(I, obs_range, I_topography, is_on_obstacle)
%COMPUTE_LOCAL_MAX Summary of this function goes here
%   Detailed explanation goes here

[map_size_x, map_size_y] = size(I);

I_IP = zeros(map_size_x, map_size_y); %Back up data
if exist("I_topography", "var")
    I_to_assign_topo = I_topography > 1; %If the cells is OK in this topo
    I_to_assign = I_to_assign_topo;
else
    I_to_assign_topo = ones(map_size_x, map_size_y); 
    I_to_assign = ones(map_size_x, map_size_y);
end

if ~exist("is_on_obstacle", "var")
    is_on_obstacle = false;
end

%% Go through to fill the empty areas
[nb, I_to_assign, I_available] = get_pi_free(I, I_IP, obs_range, I_to_assign_topo, is_on_obstacle);
while nb > 0
    II = I.*I_available;
    
    while any(I_to_assign(:) == 1)
        %TO DEBUG
        %s = sum(sum(I_to_assign > 0))
        [row, col] = find(II == max(max(II))); 
        for i=1:length(row)
            max_point = [row(i), col(i)]; % Select the first max point
            if I_available(max_point(1), max_point(2)) > 0
                % The window to consider
                [start_x, end_x, start_y, end_y] = get_window(max_point(1), max_point(2), obs_range, map_size_x, map_size_y);
                I_IP(max_point(1), max_point(2)) = 1;
                %If IP found, all around equal to zero
                I_to_assign(start_x:end_x, start_y:end_y) = 0;
                I_available(start_x:end_x, start_y:end_y) = 0;
                II(start_x:end_x, start_y:end_y) = -1;
            end
        end
    end


    [nb, I_to_assign, I_available] = get_pi_free(I, I_IP, obs_range, I_to_assign_topo, is_on_obstacle);
end

end

