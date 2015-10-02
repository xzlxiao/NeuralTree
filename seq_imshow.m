% ¡¨–¯Õº∆¨œ‘ æ
% seq_imshow
[filename, pathname] = uigetfile({'*.jpg', 'JPGÕº∆¨'; '*.tif', 'TIFÕº∆¨'}, '—°‘ÒÕº∆¨', 'MultiSelect' , 'on');
[~, n] = size(filename);
for i = 1 : n
    eval(['f', num2str(i), '= imread([pathname, filename{i}]);']);
    eval(['figure, imshow(f', num2str(i), ');']);
end