% sholl analysis·��������
% strcmp�����Ƚ����ַ���
% ƴ��·����ʱ���������ʾ��������޷�ʶ��
function a = sholl_pathname(suffix)
global tree
tree_name = tree{1}.name;   % ��Ԫ������
tree_path = 'D:\Start_Program\Tmp\'; % �����·����
if strcmp(suffix,'jpg')     % strcmp�����Ƚ����ַ���
    tree_suffix = '.jpg';    %�����ʽ
elseif strcmp(suffix,'txt')
    tree_suffix = '.txt';
end
tree_name_tmp = [tree_path tree_name tree_suffix];
% bb = mat2str(tree_name_tmp);
a = tree_name_tmp;
end