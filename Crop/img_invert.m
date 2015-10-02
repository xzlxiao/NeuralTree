function varargout = img_invert(img_file)
% �������ܣ�ͼƬ��ɫ
% �޸�ʱ�䣺2015-10-2
% ���ߣ�Ф����
% varargout = img_invert(img_file)
if nargin == 0
    [filename, pathname] = uigetfile({'*.jpg', 'JPGͼƬ'; '*.tif', 'TIFͼƬ'}, 'ѡ��ͼƬ', 'MultiSelect' , 'on');
    if pathname == 0 
        disp('δѡ��ͼƬ');
        return;
    end
    [~,n] = size(filename);
    for i = 1 : n
        filename_tmp = filename{i};
        dir = strcat(pathname, filename_tmp);
        img_file = imread(dir);
        [x1, y1] = size(img_file);
        img_inv = im2uint8(zeros(x1, y1));
        for j = 1 : x1
            for k = 1 : y1
                img_inv(j, k) = 255 - img_file(j, k);
            end
        end
        [name, suffix] = strtok(filename{i}, '.');
        if strcmp(suffix, '.tif') == 0
            filename{i} = strcat(name, '.tif');
        end
        path_write = strcat(pathname, 'INVERT\', filename{i});
        if exist([pathname, 'INVERT\']) == 0
            mkdir(pathname, 'INVERT');
        end
        imwrite( img_inv, path_write);
    end
    return
elseif nargin == 1
     [x1, y1] = size(img_file);
        img_inv = im2uint8(zeros(x1, y1));
        for j = 1 : x1
            for k = 1 : y1
                img_inv(j, k) = 255 - img_file(j, k);
            end
        end
        varargout = {img_inv};
end