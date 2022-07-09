function [I_IP] = local_max_IFC(I, obs_range, I_topography)
%IFC Return the IP location
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

%% Go through to fill the empty areas
[nb, I_already_assigned] = get_pi_free(I, I_IP, obs_range, I_to_assign_topo);
while nb > 0

    I_to_assign = I_already_assigned;
    
    while any(I_to_assign(:) == 1)
        [row, col] = find(I_to_assign == 1); 
        i = 1;
        random_point = [row(i), col(i)]; % Select the first point
        value = I(random_point(1), random_point(2));
        % The window to consider
        [start_x, end_x, start_y, end_y] = get_window(random_point(1), random_point(2), obs_range, map_size_x, map_size_y);
        % Find if it is a local maxima
        mmax = max(max(I(start_x:end_x, start_y:end_y) .* I_already_assigned(start_x:end_x, start_y:end_y)));
        if mmax == value
            I_IP(random_point(1), random_point(2)) = 1;
            %If IP found, all around equal to zero
            I_to_assign(start_x:end_x, start_y:end_y) = 0;
        else
            I_to_assign(random_point(1), random_point(2)) = 0;
        end
        
    end

    [nb, I_already_assigned] = get_pi_free(I, I_IP, obs_range, I_to_assign_topo);
end

end

