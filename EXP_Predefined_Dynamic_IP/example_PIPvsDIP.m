clear all
clc

%% Read the A map 
disp("Read the A map")
Im_map = imread('mapAgrid.png');
Im_map = rgb2gray(Im_map);
resize = 3;
Im_map = imresize(Im_map, 1/resize);
figure(1)
imshow(Im_map)
title("Original map")

[a, b] = size(Im_map);
a_ip = 801;
b_ip = 631;

% IP from map A
%x_pip = [27.0000000000000	25.0000000000000	26.3437499999999	25.5853365384615	24.8269230769230	26.3437499999999	72.6069711538461	249.317307692308	187.127403846154	185.610576923077	249.317307692308	199.262019230769	296.338942307692	250.075721153846	186.368990384615	122.662259615385	121.903846153846	233.390625000000	311.507211538462	311.507211538462	232.632211538462	311.507211538462	311.507211538462	395.691105769231	392.657451923077	392.657451923077	391.899038461538	366.112980769231	426.786057692308	746.078125000000	775.656250000000	631.557692307692	552.682692307692	646.725961538461	616.389423076923	616.389423076923	775.656250000000	777.173076923077	696.781250000000	584.536057692308	585.294471153846	570.126201923077	441.195913461538	504.144230769231	569.367788461538	570.126201923077	506.419471153846	743.802884615384	695.264423076923	695.264423076923];
%y_pip = [25.9999999999999	164.000000000000	264.807091346154	331.547475961538	409.664062500000	581.065504807692	625.811899038462	596.233774038462	551.487379807692	502.190504807692	470.337139423077	410.422475961538	409.664062500000	330.030649038462	263.290264423077	156.353966346154	25.1484374999999	25.9068509615383	25.9068509615383	121.466947115385	169.246995192308	214.751802884615	265.565504807692	266.323918269231	328.513822115385	362.642427884615	485.505408653846	596.233774038462	627.328725961539	625.811899038462	487.022235576923	515.083533653846	439.242187500000	420.281850961538	359.608774038462	323.963341346154	358.091947115385	315.620793269231	295.143629807692	266.323918269231	216.268629807692	152.561899038461	169.246995192308	120.708533653846	105.540264423077	27.4236778846152	26.6652644230768	59.2770432692307	103.265024038461	153.320312500000];

x_pip = [25	26	26	26	26	26	72	122	122	185	186	186	200	233	233	249	249	249	296	312	312	312	312	366	392.224719101124	392.224719101124	393.224719101124	394.224719101124	426	441	506	506	554	569	569	569	585	585	616	616	631	646	696	696	696	743	746	776	776	776];
y_pip = [409	26	166	266	330	581	624	27	156	503.775280898876	266	552	409	27	169	329	469	596	409	27	122	216	266	596	329	486	360	266	624	169	26	122	439	27	106	153	218	267	326	360	516	421	106	153	296	59	624	316	360	486];

xx = uint32(x_pip/b_ip * a);
yy = uint32(y_pip/a_ip * b);
t_pip = zeros(a, b);
for i=1:length(xx)
    t_pip(yy(i), xx(i)) = 1;
end

obs_range = 20;
obs_range = 20;

%% Perform the sum of the idleness with predefined IP; without the dark area
disp("Perform the sum of idleness with predefined IP")
I = randi([0 100], a, b);
for i=1:a
    for j=1:b
        if Im_map(i,j) < 20
            I(i,j) = 0;
        end
    end
end

I_pip = compute_local_sum(I, t_pip, obs_range);
v_pip = matrix2ip(I_pip);

%% DIP Generation with the obstacles
disp("Apply dynamic IP algorithm")
r = (obs_range-1)*2+1;
kernel = ones(r) / (r.^2);
blurry = imfilter(I, kernel);
t_dip = local_max_DIHI(blurry, obs_range, Im_map);
I2 = compute_local_sum(I, t_dip, obs_range);
v2 = matrix2ip(I2);

%% DIP Generation on the obstacles
disp("Apply dynamic IP algorithm on obstacles")
t_dip_on = local_max_DIHI(blurry, obs_range, Im_map, true);
I3 = compute_local_sum(I, t_dip_on, obs_range);
v3 = matrix2ip(I3);

%% Display the map with predefined ip
disp("Display predefined ip")
figure(3)

t_pip_rectangle = zeros(a,b);
for i=1:a
    for j=1:b
        if t_pip(i, j) > 0
           [start_x, end_x, start_y, end_y] = get_window(i, j, obs_range, a, b);
           t_pip_rectangle(start_x:end_x, start_y:end_y) = max(0.5, t_pip_rectangle(start_x:end_x, start_y:end_y));
           t_pip_rectangle(i,j) = 1;
        end
    end
end

Im_display = display_map(Im_map, t_pip_rectangle);
imshow(Im_display)
title("Predefined IP")

%% Display the map with dynamic ip
disp("Display dynamic ip")
figure(4)
t_dip_rectangle = zeros(a,b);
for i=1:a
    for j=1:b
        if t_dip(i, j) > 0
           [start_x, end_x, start_y, end_y] = get_window(i, j,obs_range, a, b);
           t_dip_rectangle(start_x:end_x, start_y:end_y) = 0.5;
           t_dip_rectangle(i,j) = 1;
        end
    end
end
Im_display = display_map(Im_map, t_dip_rectangle);
imshow(Im_display)
title("Dynamic IP")

%% Display the map with dynamic ip without obstacles
disp("Display dynamic ip")
figure(5)
t_dip_rectangle_free = zeros(a,b);
for i=1:a
    for j=1:b
        if t_dip_on(i, j) > 0
           [start_x, end_x, start_y, end_y] = get_window(i, j,obs_range, a, b);
           t_dip_rectangle_free(start_x:end_x, start_y:end_y) = 0.5;
           t_dip_rectangle_free(i,j) = 1;
        end
    end
end
Im_display = display_map(Im_map, t_dip_rectangle_free);
imshow(Im_display)
title("Dynamic IP on obstacles")