clear all
clc


obs_range_list = [3, 5, 10];
map_size_list = [30, 50, 100];
nb_obs_range = numel(obs_range_list);
nb_map = numel(map_size_list);

result = ["map_size", "obs_range", "av_nofilter", "av_filter", "av_nofilter_surface", "av_filter_surface"];

%parfor(ob=1:nb_obs_range, 6)
for ob=1:nb_obs_range
    for map=1:nb_map
        map_size = map_size_list(map);
        obs_range=obs_range_list(ob);
        disp("Looping.. obs_range=")
        disp(obs_range)
        disp('map_size =')
        disp(map_size)

        v_isolated_surface_list = [];
        v_filter_surface_list = [];
        v_isolated_alone_list = [];
        v_filter_alone_list = [];

        parfor loop=1:1000,6;
            I = randi([0 100], map_size, map_size);
            
            %% Generate isolated 
            disp("Apply isolated IP")
            t_isolated = local_max_DIHI(I, obs_range)
            v_isolated_surface = matrix2ip(compute_local_sum(I, t_isolated, obs_range))
            v_isolated_surface_list = [v_isolated_surface_list; v_isolated_surface];
            v_isolated_alone = matrix2ip(compute_local_single(I, t_isolated));
            v_isolated_alone_list = [v_isolated_alone_list; v_isolated_alone];
    
            %% Generate surface
            disp("Apply surface IP")
            r = (obs_range-1)*2+1;
            kernel = ones(r) / (r.^2);
            blurry = imfilter(I, kernel);

            t_filter = local_max_DIHI(blurry, obs_range);
            v_filter_surface = matrix2ip(compute_local_sum(I, t_filter, obs_range));
            v_filter_surface_list = [v_filter_surface_list;v_filter_surface];
            v_filter_alone = matrix2ip(compute_local_single(I, t_filter));
            v_filter_alone_list = [v_filter_alone_list; v_filter_alone];
        end

        result = [result; map_size, obs_range, mean(v_isolated_alone_list), mean(v_filter_alone_list), mean(v_isolated_surface_list), mean(v_filter_surface_list)];

    end

end
