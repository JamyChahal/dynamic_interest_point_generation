clear all
clc

% map_size = 200;
% obs_range = 3;
% nbr_agent = 3;
% IM = [82	66	44	75	35	16	10	86	78	55	65	31	8	3	3	6	17	96	3	25;
% 91	3	38	25	83	80	97	62	39	29	38	93	26	89	75	68	39	92	56	29;
% 12	85	77	51	59	31	0	35	24	75	81	43	80	92	50	4	83	5	89	62;
% 92	94	80	70	55	53	78	51	40	19	53	18	2	80	48	7	81	74	67	26;
% 63	68	18	89	92	16	82	40	9	69	35	91	93	9	91	52	6	27	19	83;
% 9	76	49	96	28	60	87	7	13	18	94	98	73	26	61	9	40	42	37	99;
% 28	75	45	55	76	26	8	24	95	37	88	44	49	33	62	82	53	55	46	73;
% 55	39	65	14	76	66	40	12	96	63	55	11	58	68	86	82	42	95	99	34;
% 96	66	71	15	38	69	26	18	58	78	62	26	23	13	81	72	66	42	15	58;
% 97	17	76	26	57	75	80	24	6	8	59	41	46	72	58	15	63	99	86	10;
% 15	71	27	84	7	45	43	42	23	93	20	60	97	10	18	66	29	30	65	91;
% 98	3	68	25	5	8	91	5	35	78	30	26	55	66	24	52	43	70	38	88;
% 96	27	66	82	53	23	18	91	82	49	47	60	52	49	89	98	1	67	19	82;
% 49	4	16	24	78	92	26	95	1	44	23	71	23	78	2	65	99	54	43	26;
% 80	9	12	93	94	15	14	49	4	45	85	22	49	72	49	80	16	70	48	60;
% 14	83	50	35	13	83	13	49	17	30	19	11	63	91	16	45	10	67	12	2;
% 42	70	96	19	57	54	87	34	65	51	22	29	68	89	98	43	37	17	59	42;
% 92	32	34	25	47	100	58	90	73	51	17	32	39	33	71	83	20	12	22	31;
% 80	95	59	62	1	7	55	37	65	82	22	42	37	70	50	8	49	100	38	16;
% 96	3	22	47	34	44	14	11	45	80	44	51	99	19	47	13	34	17	58	18];
% 
% IM = randi([0 100], map_size, map_size); %Idleness map
% [map_size_x, map_size_y] = size(IM);
% 
% 
% % Generate the interest point list 
% r = (obs_range-1)*2+1;
% kernel = ones(r) / (r.^2);
% blurry = imfilter(IM, kernel);
% t3 = compute_local_max_v3(blurry, obs_range);
% Ip3 = compute_local_sum(IM, t3, obs_range);
% IP_pose3 = get_pose_idleness_pi(IM);
% 
% t1 = compute_local_max(blurry, obs_range);
% Ip1 = compute_local_sum(IM, t1, obs_range);
% IP_pose1 = get_pose_idleness_pi(IM);

%% Run for different parameter (map_size and obs_range)
map_size_list = [50, 100, 250, 500, 700];
obs_range_list = [3, 5, 10, 20, 30, 50];
loop = 100;

result_av = ["obs", "map_size", "mean", "max", "min"];
sum_idleness_map = [];

for m=1:length(map_size_list)
    map_size = map_size_list(m)
    for n=1:length(obs_range_list)
        obs_range = obs_range_list(n)
        v = [];
        parfor(i=1:loop,6)
            disp(i)
            I = randi([0 100], map_size, map_size);

            r = (obs_range-1)*2+1;
            kernel = ones(r) / (r.^2);

            I_blurry = imfilter(I, kernel);
            t = compute_local_max_v3(I_blurry, obs_range);
            
            kernel2 = ones(r);
            I_redundancy = imfilter(t, kernel2);

            nb = sum(sum(I_redundancy > 1));

            v = [v; nb];
        end
        %["obs", "map_size", "mean_1", "max_1", "min_1", "mean_2", "max_2", "min_2", "mean_3", "max_3", "min_3"];
        result_av = [result_av; obs_range, map_size, mean(v), max(v), min(v)];
    end
end


