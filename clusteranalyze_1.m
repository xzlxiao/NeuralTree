%clusteranalyze_1
clear
[num_1, tex_1] = xlsread('sholl_Data_20150714');
num_2 = num_1;
num_2(isnan(num_2)==1)=0; %把NaN变为0
% num_2 = num_2 - 3;
% num_2 = zscore(num_2);
% redblue_N = redbluecmap(11);
winter_1 = winter(128);
ID_1 = tex_1(2:end, 2);
cluster_gram_1 = clustergram(num_2, 'rowlabels', ID_1, 'colormap', winter_1, ...
    'Cluster', 'column','standardize', 'row');
%标记特定的样本群体
% rm = struct('GroupNumber', {1,3}, 'Annotation', {'A','B'},...
%     'Color', {'r', 'k'});
% cm = struct('GroupNumber', {3,15}, 'Annotation', {'C','D'},...
%     'Color', {'b', 'y'});
% set(cluster_gram_1, 'RowGroupMarker', rm, 'ColumnGroupMarker',cm)
% 
% %Get the handle for colorbar button
% cbButton = findall(gcf, 'tag', 'HMInertColorbar');
% %Get callback(clickedCallback)for the button
% ccb = get(cbButton, 'ClickedCallback');
% ccb = @(insertColorbarCB)cluster_gram_1; 
% %Change the button state to 'on'(clicked down)
% set(cbButton, 'state', 'on');
% %Run the callback to create the colorbar
% ccb{1}(cbButton, [], ccb{2});

