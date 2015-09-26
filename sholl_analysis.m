%% loading
clearvars -except All_Dendrites_length All_branch All_dendrites_num All_Terminal All_sholl count_num;
% 判断并设置计数器
if exist('count_num') == 0
    disp('---------------------------分割线-------------------------------');
    count_num = 1;
    disp(['No.', num2str(count_num)])
elseif exist('count_num') == 1
    if exist('tree_num') == 1
        if tree_num == [0]
            count_num = count_num - 1;
            if count_num < 1
                count_num = 1;
                disp('---------------------------分割线-------------------------------');
                disp(['No.', num2str(count_num)])
            end
        end
    else
        disp('---------------------------分割线-------------------------------');
        disp(['No.', num2str(count_num)])
    end
else
    disp('There is a error,please check up "count_num"');
    break
end

[tree_tmp, tree_scale] = nio_load_tree();
tree_num = length(tree_tmp);
%% reformation
voxel_size1 = [0.35 0.35 1];%
voxel_size2 = [0.3 0.3 1];
for ward = 1 : tree_num
    tree_tmp{ward}.X  = tree_tmp{ward}.X / voxel_size1(1) * voxel_size2(1);
    tree_tmp{ward}.Y  = tree_tmp{ward}.Y / voxel_size1(2) * voxel_size2(2);
    tree_tmp{ward}.Z  = tree_tmp{ward}.Z / voxel_size1(3) * voxel_size2(3);
end
tree_scale.X  = tree_scale.X / voxel_size1(1) * voxel_size2(1);
tree_scale.Y  = tree_scale.Y / voxel_size1(2) * voxel_size2(2);
tree_scale.Z  = tree_scale.Z / voxel_size1(3) * voxel_size2(3);
%% sholl analysis
global tree;
tree = tree_tmp;
tree_num = length(tree);
% root_tree = load_tree('G:\guocongdi\GI13442\FrA\SpatialGraph1_cell.swc');

% root_xyz = [0 0 0];%%
% root_tree.X = root_xyz(1);
% root_tree.Y = root_xyz(2);
% root_tree.Z = root_xyz(3);
diameter = 10;%%
length_dd = 1;
s = cell(1, tree_num);
for ward = 1: tree_num
%     tree_new = cat_tree(root_tree, tree{ward});
    [s{ward}, dd,~,~,~,~,~] = sholl_tree(tree{ward}, diameter);
    if length_dd < length(dd)
        length_dd = length(dd);
    end
end
yy =  zeros(tree_num, length_dd);
for ward = 1 : tree_num
    yy(ward, 1:length(s{ward})) = s{ward};
end
y = sum(yy);
y_First_dendrites = yy(1,:);    % 将轴突单独分离出来
x = 0:diameter:(diameter*(length_dd-1));
tree_name_1 = tree{1}.name;
tree_name_2 = strrep(tree_name_1,'_','\_');
sholl_figure = figure;
subplot(2,1,1);
stairs(x,y);
title([tree_name_2 ' 神经元全分支'], 'Color', 'b');
subplot(2,1,2);
stairs(x,y_First_dendrites);
title([tree_name_2 ' 神经元轴突'], 'Color', 'r');
sholl_pathname_1 = sholl_pathname('jpg');
saveas(sholl_figure, sholl_pathname_1);
% imwrite(sholl_figure,sholl_pathname_1);
delete(sholl_figure);
%% measure
Primary_dendrites = length(tree_tmp);
Dendrites_length = 0;
for ward = 1 : tree_num
    Dendrites_length = Dendrites_length + sum(len_tree(tree_tmp{ward}));
end
Volume = (max(tree_scale.X) - min(tree_scale.X))*(max(tree_scale.Y) - min(tree_scale.Y))*(max(tree_scale.Z) - min(tree_scale.Z));
Total_branch = 0;
for ward = 1 : tree_num
    Total_branch = Total_branch + sum(B_tree(tree_tmp{ward}))*2 + 1;
end
Total_terminal = 0;
for ward = 1 : tree_num
    Total_terminal = Total_terminal + sum(T_tree(tree_tmp{ward}));
end
All_Dendrites_length(count_num) = [Dendrites_length];
All_branch(count_num) = [Total_branch];
All_dendrites_num(count_num) = [Primary_dendrites];
All_Terminal(count_num) = [Total_terminal];
All_sholl(count_num) = {y_First_dendrites};
    
%% 计数
count_num = count_num + 1;
