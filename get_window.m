function [start_x, end_x, start_y, end_y] = get_window(x, y,obs_range, map_size_x, map_size_y)
%GET_WINDOW Summary of this function goes here
%   Detailed explanation goes here
obs = obs_range - 1;
start_x = max(1,x - obs);
end_x = min(map_size_x,x + obs);
start_y = max(1,y - obs);
end_y = min(map_size_y,y + obs);
end

