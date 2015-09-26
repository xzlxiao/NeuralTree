% gene_tree_test
% [filename, pathname] = uigetfile( ...
% {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
% '*.*','All Files' },...
% '��ѡ��Ҫ�޸ĵ�ͼƬ���ɶ�ѡ��', ...
% 'MultiSelect', 'on');
% �˺������÷�Ϊ
% [FileName,PathName,FilterIndex] = uigetfile(FilterSpec,DialogTitle,DefaultName)
% FileName�����ص��ļ���
% PathName�����ص��ļ���·����
% FilterIndex��ѡ����ļ����� 
% FilterSpec���ļ���������
% DialogTitle���򿪶Ի���ı���
% DefaultName��Ĭ��ָ����ļ���
% '-s': չʾ���������������demo; '-m': ��ĳЩ�����չʾmovie; '-w': ��ʾ������; '-e': echo
% changes made to the tree
% ���⣺�����������ʱ����������
% �������ɸ�ΪLarge_trees_group��Ԫ�ظ�����1

clearvars -except final_result count_num Large_trees_group tree_axon_group cvol_group cvol_mean_group;
% �жϲ����ü�����
if exist('count_num') == 0
    disp('---------------------------�ָ���-------------------------------');
    count_num = 1;
    disp(['No.', num2str(count_num)])
elseif exist('count_num') == 1
    [~,count_num] = size(Large_trees_group);
    count_num = count_num + 1;
    disp('---------------------------�ָ���-------------------------------');
    disp(['No.', num2str(count_num)])
end

    
%% gene_tree
    
[Large_trees_filename,Large_trees_path] = uigetfile('*.swc','SWC(*.swc)');
if Large_trees_filename == 0
    disp('δѡ������');
    break
end
Large_trees_file = nio_load_tree([Large_trees_path,Large_trees_filename]);
% ��Large_trees_file�е�ÿһ��name�ַ����е�'_'��Ϊ'\_'
[~,l] = size(Large_trees_file);     % l������֧������
for i = 1:l
    Large_trees_file{i}.name = strrep(Large_trees_file{i}.name,'_', '\_');
end
Large_trees = Large_trees_file;
Large_trees_group(count_num) = {Large_trees};  % ��ȡ��Ԫ��
% ��ȡ��ͻ
tree_axon = Large_trees{1};
tree_axon_group(count_num) = {tree_axon};
% ����gene_treeͼ
gene_figure = figure;
genes = gene_tree(Large_trees_group, '-s');
% �ı�y������Ϊ-1
YULim = get(gca, 'YLim');
a = YULim(2);
set(gca,'YLim',[-1,a]);
clear a YULim;
delete(gene_figure);
%% Type(BCT), termination(T,0), continuation(C,1), branch point(b��2��
% typeN_num = typeN_tree(Large_trees)';
% typeN_char = typeN_tree(Large_trees, '-bct')';
% ��Large_trees�е�ÿһ���ṹ�帳�����Large_trees_sig����TypeN_tree������ٸ���Ԫ������Large_trees_num��Large_trees_char
Large_trees_num = cell(1,l);
Large_trees_char = cell(1,l);
for i = 1:l
    Large_trees_sig = Large_trees{i};
    typeN_num = typeN_tree(Large_trees_sig)';
    typeN_char = typeN_tree(Large_trees_sig, '-bct')';
    Large_trees_num(i) = {typeN_num};
    Large_trees_char(i) = {typeN_char};
end
%% ͳ�Ʒ�֧�Ƕ�
% angleB = angleB_tree(intree, options)
% '-m': ����չʾ
% ��Large_trees�е�ÿһ���ṹ�帳�����Large_trees_sig����angleB_tree������ٸ���Ԫ������Large_trees_angleB
% ����ʹ��ϡ����󴢴�Ƕ���Ϣ
Large_trees_angleB = cell(1,l);
for i = 1:l
    Large_trees_sig = Large_trees{i};
    angleB = angleB_tree(Large_trees_sig)';
    Large_trees_angleB(i) = {angleB};
end
%% ͳ��Ƭ�Σ�1/΢�ף����test
% cvol = cvol_tree(intree, options)
% ��Large_trees�е�ÿһ���ṹ�帳�����Large_trees_sig����cvol_tree������ٸ���Ԫ������Large_trees_cvol
% '-s'������Ӧ��֦����ͼ
% ���⣬�����������֦����ͼ�ϲ���һ��ͼ
% bug����infֵʧЧ��HT-A0003
Large_trees_cvol = cell(1,l);
for i = 1:l
    Large_trees_sig = Large_trees{i};   %��ÿһ����ͻ��֧����ñ���
    cvol = cvol_tree(Large_trees_sig);      %�ֱ����ÿһ����ͻ��Ƭ�����
    % ȥ��infֵ����ǰ���ƽ��ֵ���棬����������һ�������һ������ȡ��������ǰ����ֵ��ƽ��ֵ
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
% ��������ݱ�Ϊһ��һά����cvol_tmp���ٸ���Ԫ������cvol_group
cvol_tmp = Large_trees_cvol{1}';
for i = 2 : l
    cvol_tmp = [cvol_tmp,Large_trees_cvol{i}'];
end
cvol_group(count_num) = {cvol_tmp};
cvol_mean = mean(cvol_tmp);
cvol_mean_group(count_num) = [cvol_mean];
%% ͳ�Ʒ�֧��λ�ü�����
% B = B_tree(intree, options)
% ��Large_trees�е�ÿһ���ṹ�帳�����Large_trees_sig����B_tree, sum,
% find������ٸ���Ԫ������Large_trees_Bp, Large_trees_Bsum, Large_trees_Bloc
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

%% һЩͳ�����ݵ�չʾ
% HP = dstats_tree(stats, vcolor, options)
% ��Large_trees��ΪԪ�������Ԫ�����飬����dstats_tree��������
% Options are showing only global statistics '-g'?, only distributions '-d'? and smoothen the distributions '-c'?
% dstats_tree(stats_tree({Large_trees}));
%cell_Large_trees = {Large_trees,Large_trees,Large_trees,Large_trees,Large_trees}
%stats_Large_trees = stats_tree(cell_Large_trees)
%dstats_tree(stats_Large_trees)
% figure_stats = figure;
% dstats_tree(stats_tree(tree_axon_group));
% delete(figure_stats);
