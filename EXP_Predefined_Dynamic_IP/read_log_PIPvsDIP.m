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
    name = "PDF for an observation range of "+string(obs_range_list(k)+" cells");
    subplot(3, 2, count)
    ksdensity(backup_pip{k, 1})
    %histogram(backup_pip{k,1})
    hold on
    ksdensity(backup_dip{k, 1})
    hold on
    ksdensity(backup_dip_on{k, 1})
    %histogram(backup_dip{k,1})
    title(name)
    lgd = legend('pip', 'dip', 'dip\_onob.');
    lgd.Location = 'northwest';
    xlabel('Surface idleness')
    ylabel('Probability')
end

%% PLOTTING CDF
count = 0;
figure(2)
for k=1:a
    for kk=1:1
        count = count + 1;
        name = "obs="+string(obs_range_list(k));
        subplot(a, b, count)
        ecdf(backup_pip{k, kk})
        hold on
        ecdf(backup_dip{k, kk})
        title(name)
        legend('pip', 'dip')
    end
end

%% PLOTTING KSDENSITY SEVERAL FIGURE
count = 0;

% for k=1:a
%     f = figure(3+count);
%     count = count + 1;
%     name = "obs="+string(obs_range_list(k));
%     ksdensity(backup_pip{k, 1})
%     xlabel('Surface idleness')
%     ylabel('Probability')
%     %histogram(backup_pip{k,1})
%     hold on
%     ksdensity(backup_dip{k, 1})
%     %histogram(backup_dip{k,1})
%     title(name)
%     legend('pip', 'dip', 'dip_free')
% end
