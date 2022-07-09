clear all
clc

%% Read the A map 
disp("Read the A map")
Im_topo = imread('mapAgrid.png');
Im_topo = rgb2gray(Im_topo);
resize = 3;
Im_topo = imresize(Im_topo, 1/resize);
figure(1)
imshow(Im_topo)

[a, b] = size(Im_topo);
a_ip = 801;
b_ip = 631;

x_pip = [25	26	26	26	26	26	72	122	122	185	186	186	200	233	233	249	249	249	296	312	312	312	312	366	392.224719101124	392.224719101124	393.224719101124	394.224719101124	426	441	506	506	554	569	569	569	585	585	616	616	631	646	696	696	696	743	746	776	776	776];
y_pip = [409	26	166	266	330	581	624	27	156	503.775280898876	266	552	409	27	169	329	469	596	409	27	122	216	266	596	329	486	360	266	624	169	26	122	439	27	106	153	218	267	326	360	516	421	106	153	296	59	624	316	360	486];

xx = uint32(x_pip/b_ip * a);
yy = uint32(y_pip/a_ip * b);
t_pip = zeros(a, b);
for i=1:length(xx)
    t_pip(yy(i), xx(i)) = 1;
end

obs_range = 10;
obs_range = 20;

obs_range_list=10:5:35;
%obs_range_list=10:5:15;
nb_obs_range = numel(obs_range_list);

backup_pip = {};
backup_dip = {};
backup_dip_on = {};

%parfor(ob=1:nb_obs_range, 6)
for ob=1:nb_obs_range
    obs_range=obs_range_list(ob);
    disp("Looping.. obs_range=")
    disp(obs_range)
    v_pip_list = [];
    free_pip_list = 0;
    v_dip_list = [];
    free_dip_list = 0;
    v_dip_on_list = [];
    free_dip_on_list = 0;
    %for map=1:1
    parfor map=1:1000,6;
        I = randi([0 100], a, b);
        for i=1:a
            for j=1:b
                if Im_topo(i,j) < 20
                    I(i,j) = 0;
                end
            end
        end
        %% Perform the sum of the idleness with predefined IP; without the dark area
        disp("Perform the sum of idleness with predefined IP")
    
        I_pip = compute_local_sum(I, t_pip, obs_range);
        v_pip = matrix2ip(I_pip);
        [free_pip, ~] = get_pi_free(I, t_pip, obs_range, Im_topo, false);
        v_pip_list = [v_pip_list;v_pip];
        free_pip_list = free_pip_list+free_pip;
        
        %% Generate our own algo to generate IP 
        disp("Apply dynamic IP algorithm"),
        r = (obs_range-1)*2+1;
        kernel = ones(r) / (r.^2);
        blurry = imfilter(I, kernel);
        %% With obstacles
        t_dip = local_max_DIHI(blurry, obs_range, Im_topo);
        I_dip = compute_local_sum(I, t_dip, obs_range);
        v_dip = matrix2ip(I_dip);
        [free_dip, ~] = get_pi_free(I, t_dip, obs_range, Im_topo, false);
        v_dip_list = [v_dip_list;v_dip];
        free_dip_list = free_dip_list+free_dip;
        %% Without obstacles
        t_dip_on = local_max_DIHI(blurry, obs_range, Im_topo, true);
        I_dip_on = compute_local_sum(I, t_dip_on, obs_range);
        v_dip_on = matrix2ip(I_dip_on);
        [free_dip_on, ~] = get_pi_free(I, t_dip_on, obs_range, Im_topo, true);
        v_dip_on_list = [v_dip_on_list;v_dip_on];
        free_dip_on_list = free_dip_on_list+free_dip_on;

    end
    backup_pip{ob, 1} = v_pip_list;
    backup_pip{ob, 2} = free_pip_list;
    backup_dip{ob, 1} = v_dip_list;
    backup_dip{ob, 2} = free_dip_list;
    backup_dip_on{ob, 1} = v_dip_on_list;
    backup_dip_on{ob, 2} = free_dip_on_list;
end
