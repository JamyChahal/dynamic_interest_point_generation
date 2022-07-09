function [nb, I_to_assign, I_available] = get_pi_free(I, I_pi, obs_range, I_to_assign_topo, is_on_obstacle)
%get_pi_free Summary of this function goes here
%   Detailed explanation goes here

[map_size_x, map_size_y] = size(I);
if ~exist("I_to_assign_topo", "var")
    I_to_assign_topo = ones(map_size_x, map_size_y);
end
if ~exist("is_on_obstacle", "var")
    is_on_obstacle = false;
end

I_to_assign = ones(map_size_x, map_size_y); %Init
for i=1:map_size_x
    for j=1:map_size_y
        if I_pi(i,j) > 0
            [start_x, end_x, start_y, end_y] = get_window(i, j, obs_range, map_size_x, map_size_y);
            I_to_assign(start_x:end_x, start_y:end_y) = 0;
        end
        if I_to_assign_topo(i,j) == 0
            I_to_assign(i,j) = 0;
        end
    end
end

nb = sum(sum(I_to_assign));

I_available = ones(map_size_x, map_size_y); %Init
for i=1:map_size_x
    for j=1:map_size_y
        if I_pi(i,j) > 0
            [start_x, end_x, start_y, end_y] = get_window(i, j, obs_range, map_size_x, map_size_y);
            I_available(start_x:end_x, start_y:end_y) = 0;
        end
        if I_to_assign_topo(i,j) == 0 && ~is_on_obstacle
            I_available(i,j) = 0;
        end
    end
end

end
