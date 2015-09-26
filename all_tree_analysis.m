% gene_tree_test
% [filename, pathname] = uigetfile( ...
% {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
% '*.*','All Files' },...
% '请选择要修改的图片（可多选）', ...
% 'MultiSelect', 'on');
% 此函数的用法为
% [FileName,PathName,FilterIndex] = uigetfile(FilterSpec,DialogTitle,DefaultName)
% FileName：返回的文件名
% PathName：返回的文件的路径名
% FilterIndex：选择的文件类型 
% FilterSpec：文件类型设置
% DialogTitle：打开对话框的标题
% DefaultName：默认指向的文件名
% '-s': 展示结果，可用于制作demo; '-m': 在某些结果中展示movie; '-w': 显示进度条; '-e': echo
% changes made to the tree
% 问题：当结果不存在时计数器归零
% 计数器可改为Large_trees_group的元素个数加1

clearvars -except final_result count_num Large_trees_group tree_axon_group cvol_group cvol_mean_group;
% 判断并设置计数器
if exist('count_num') == 0
    disp('---------------------------分割线-------------------------------');
    count_num = 1;
    disp(['No.', num2str(count_num)])
elseif exist('count_num') == 1
    [~,count_num] = size(Large_trees_group);
    count_num = count_num + 1;
    disp('---------------------------分割线-------------------------------');
    disp(['No.', num2str(count_num)])
end

    
%% gene_tree
    
[Large_trees_filename,Large_trees_path] = uigetfile('*.swc','SWC(*.swc)');
if Large_trees_filename == 0
    disp('未选择数据');
    break
end
Large_trees_file = nio_load_tree([Large_trees_path,Large_trees_filename]);
% 将Large_trees_file中的每一个name字符串中的'_'变为'\_'
[~,l] = size(Large_trees_file);     % l是主分支的数量
for i = 1:l
    Large_trees_file{i}.name = strrep(Large_trees_file{i}.name,'_', '\_');
end
Large_trees = Large_trees_file;
Large_trees_group(count_num) = {Large_trees};  % 获取神经元组
% 获取轴突
tree_axon = Large_trees{1};
tree_axon_group(count_num) = {tree_axon};
% 绘制gene_tree图
gene_figure = figure;
genes = gene_tree(Large_trees_group, '-s');
% 改变y轴下限为-1
YULim = get(gca, 'YLim');
a = YULim(2);
set(gca,'YLim',[-1,a]);
clear a YULim;
delete(gene_figure);
%% Type(BCT), termination(T,0), continuation(C,1), branch point(b，2）
% typeN_num = typeN_tree(Large_trees)';
% typeN_char = typeN_tree(Large_trees, '-bct')';
% 将Large_trees中的每一个结构体赋予变量Large_trees_sig，由TypeN_tree处理后，再赋予元胞数组Large_trees_num和Large_trees_char
Large_trees_num = cell(1,l);
Large_trees_char = cell(1,l);
for i = 1:l
    Large_trees_sig = Large_trees{i};
    typeN_num = typeN_tree(Large_trees_sig)';
    typeN_char = typeN_tree(Large_trees_sig, '-bct')';
    Large_trees_num(i) = {typeN_num};
    Large_trees_char(i) = {typeN_char};
end
%% 统计分支角度
% angleB = angleB_tree(intree, options)
% '-m': 动画展示
% 将Large_trees中的每一个结构体赋予变量Large_trees_sig，由angleB_tree处理后，再赋予元胞数组Large_trees_angleB
% 尝试使用稀疏矩阵储存角度信息
Large_trees_angleB = cell(1,l);
for i = 1:l
    Large_trees_sig = Large_trees{i};
    angleB = angleB_tree(Large_trees_sig)';
    Large_trees_angleB(i) = {angleB};
end
%% 统计片段（1/微米）体积test
% cvol = cvol_tree(intree, options)
% 将Large_trees中的每一个结构体赋予变量Large_trees_sig，由cvol_tree处理后，再赋予元胞数组Large_trees_cvol
% '-s'画出相应树枝的柱图
% 问题，怎样将多个树枝的柱图合并成一张图
% bug处理inf值失效，HT-A0003
Large_trees_cvol = cell(1,l);
for i = 1:l
    Large_trees_sig = Large_trees{i};   %将每一个树突分支赋予该变量
    cvol = cvol_tree(Large_trees_sig);      %分别计算每一个树突的片段体积
    % 去除inf值，用前后的平均值代替，如果是数组第一个或最后一个，则取后两个或前两个值得平均值
 k = 1;
        inf_ind = isinf(cvol);
        [inf_r, ~] = find(inf_ind == 1);
        [cvol_r,~] = size(cvol);
        [inf_rr, ~] = size(inf_r);
        while inf_rr >= 1 && k <=5 
            for j = 1 : inf_rr
                if inf_r(j) + k  <= cvol_r
                    if inf_r(j) - k >= 1 
                        mean_cvol = (cvol(inf_r(j) - k)+ cvol(inf_r(j)+k))./2;
                    elseif  inf_r + k > cvol_r
                        mean_cvol = (cvol(inf_r(j) - (k+1))+ cvol(inf_r(j) - k))./2;
                    elseif inf_r - k < 1
                        mean_cvol = (cvol(inf_r(j) + (k+1))+ cvol(inf_r(j) + k))./2;
                    end
                end
            cvol(inf_r(j)) = mean_cvol;
            end
        inf_ind = isinf(cvol);
        [inf_r, ~] = find(inf_ind == 1);
        [inf_rr, ~] = size(inf_r);
        k = k + 1;
        end
       inf_ind = isinf(cvol);
       [inf_r, ~] = find(inf_ind == 1);
       [inf_rr, ~] = size(inf_r);
      cvol(isnan(cvol)==1)=0;
      Large_trees_cvol(i) = {cvol};
end
% 将体积数据变为一个一维数组cvol_tmp，再赋给元胞数组cvol_group
cvol_tmp = Large_trees_cvol{1}';
for i = 2 : l
    cvol_tmp = [cvol_tmp,Large_trees_cvol{i}'];
end
cvol_group(count_num) = {cvol_tmp};
cvol_mean = mean(cvol_tmp);
cvol_mean_group(count_num) = [cvol_mean];
%% 统计分支点位置及数量
% B = B_tree(intree, options)
% 将Large_trees中的每一个结构体赋予变量Large_trees_sig，由B_tree, sum,
% find处理后，再赋予元胞数组Large_trees_Bp, Large_trees_Bsum, Large_trees_Bloc
Large_trees_Bp = cell(1,l);
Large_trees_Bsum = cell(1,l);
Large_trees_Bloc = cell(1,l);
for i = 1:l
    Large_trees_sig = Large_trees{i};
    B = B_tree(Large_trees_sig);
    Large_trees_Bp(i) = {B};
    Large_trees_Bsum(i) = {sum(B)};
    Large_trees_Bloc(i) = {find(B)};
end

%% 一些统计数据的展示
% HP = dstats_tree(stats, vcolor, options)
% 将Large_trees变为元胞数组的元胞数组，并用dstats_tree函数处理
% Options are showing only global statistics '-g'?, only distributions '-d'? and smoothen the distributions '-c'?
% dstats_tree(stats_tree({Large_trees}));
%cell_Large_trees = {Large_trees,Large_trees,Large_trees,Large_trees,Large_trees}
%stats_Large_trees = stats_tree(cell_Large_trees)
%dstats_tree(stats_Large_trees)
% figure_stats = figure;
% dstats_tree(stats_tree(tree_axon_group));
% delete(figure_stats);
