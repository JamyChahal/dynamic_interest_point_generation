% Perform plot display

[a, b] = size(backup_pip)
b=1
for k=1:a
    minData_pip(k, 1) = min(backup_pip{k,1});
    maxData_pip(k, 1) = max(backup_pip{k, 1});
    meanData_pip(k, 1) = mean(backup_pip{k, 1});
    minData_dip(k, 1) = min(backup_dip{k,1});
    maxData_dip(k, 1) = max(backup_dip{k, 1});
    meanData_dip(k, 1) = mean(backup_dip{k, 1});
end
for k=1:a
    free_pip(k, 1) = (backup_pip{k,2});
    free_dip(k, 1) = (backup_dip{k, 2});
end


%% PLOTTING KSDENSITY
count = 0;
figure(1)
for k=1:a
    count = count + 1;
    name = "O"+string(obs_range_list(k));
    subplot(a, b, count)
    ksdensity(backup_pip{k, 1})
    %histogram(backup_pip{k,1})
    hold on
    ksdensity(backup_dip{k, 1})
    %histogram(backup_dip{k,1})
    title(name)
    legend('pip', 'dip')
end

%% PLOTTING CDF
count = 0;
figure(2)
for k=1:a
    for kk=1:1
        count = count + 1;
        name = "O"+string(obs_range_list(k));
        subplot(a, b, count)
        ecdf(backup_pip{k, kk})
        hold on
        ecdf(backup_dip{k, kk})
        title(name)
        legend('pip', 'dip')
    end
end

nb_pip_mean = [];
nb_dip_mean = [];
for k=1:a
    nb_pip_mean(k) = numel(backup_pip{k, 1}) / 10;
    nb_dip_mean(k) = numel(backup_dip{k, 1}) / 10;
end

