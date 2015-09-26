% sholl analysis路径名生成
% strcmp函数比较两字符串
% 拼接路径名时需用数组表示，否则会无法识别
function a = sholl_pathname(suffix)
global tree
tree_name = tree{1}.name;   % 神经元的名称
tree_path = 'D:\Start_Program\Tmp\'; % 保存的路径名
if strcmp(suffix,'jpg')     % strcmp函数比较两字符串
    tree_suffix = '.jpg';    %保存格式
elseif strcmp(suffix,'txt')
    tree_suffix = '.txt';
end
tree_name_tmp = [tree_path tree_name tree_suffix];
% bb = mat2str(tree_name_tmp);
a = tree_name_tmp;
end