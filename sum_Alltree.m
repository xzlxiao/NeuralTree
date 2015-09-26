% ����ͻ�޽ӵ���ͻ��
% �޽Ӻ���
% tree = cat_tree(intree1, intree2, inode1, inode2, options)
% ��root������һ��СƬ��
% tree = root_tree(intree, options)
clear;
[Large_trees_filename,Large_trees_path] = uigetfile('*.swc','SWC(*.swc)');
Large_trees_file = nio_load_tree([Large_trees_path,Large_trees_filename]);
% ��Large_trees_file�е�ÿһ��name�ַ����е�'_'��Ϊ'\_'
[~,l] = size(Large_trees_file);
for i = 1:l
    Large_trees_file{i}.name = strrep(Large_trees_file{i}.name,'_', '\_');
end
Large_trees = Large_trees_file;
% ��ȡ��ͻ
tree_axon = Large_trees{1};
% ��root������һ��СƬ��
tree_axon_reroot = root_tree(tree_axon);
% ����ͻȫ���ںϵ���ͻ�ڶ����ڵ��ϣ��������Alltree
for i = 2:l
    tree_child = Large_trees_file{i}
    Alltree = cat_tree(tree_axon, tree_child, 1, 2)
    sort_tree(Alltree,'-s');
end


%% ��������ͼ
% HP = dendrogram_tree(intree, diam, yvec, color, DD, wscale, options)
% Plots a dendrogram of the tree intree (must conform to BCT). HP is the handle to 
% the graphical object. Nx1 vector yvec simply assigns a y-value to each node (metric 
% path length by default, see ��Pvec_tree��), while Nx1 vector diam attributes a 
% diameter (single value = constant diameter). The dendrogram is offset by XYZ 3tupel DD 
% and coloured with RGB 3-tupel color. Single value wscale determines the spacing between two terminals.

figure;
dendrogram_tree(tree_axon);
axis off;
figure;
dendrogram_tree(tree_axon_reroot);
axis off;
figure;
dendrogram_tree(Alltree);
axis off;