function [] = CreateFolder(dir)
if ischar(dir) == 0
    error('地址名必须是字符串');
end
if exist(dir) == 0
mkdir(dir);
end