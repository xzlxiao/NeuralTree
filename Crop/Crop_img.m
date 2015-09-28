function [] = Crop_img(img_inf)
% 函数功能：图片裁剪
% 修改时间：2015-9-24
% 作者：肖镇龙
% function [] = Crop()
SrcDir=img_inf.SrcDir;        %文件输入地址
DstDir = img_inf.DstDir;    %文件输出地址
dirfile=dir(SrcDir);
Im_Name = img_inf.filename;
Im_Prefix = img_inf.prefix;
Im_Suffix = img_inf.suffix;

%以下数据由Fiji测量获得
CropWidthFirstPointCoordinate = img_inf.CropWidthFirstPointCoordinate;  %左上角点的横坐标
CropHeightFirstPointCoordinate = img_inf.CropHeightFirstPointCoordinate; %左上角点的纵坐标
CropWidth = img_inf.CropWidth;    %裁剪宽度
CropHeight = img_inf.CropHeight ;   %裁剪高度

zRange = [img_inf.Zstart img_inf.Zend];   %所需裁剪的图片编号范围

for z = zRange(1) : 1 :zRange(2)
    disp('----------------------------------'), disp(z) , disp('-----------------------------');%
    tic;
    %     Im=imread([SrcDir Im_Prefix num2str(z,'%05d') '.jpg']);
    Im=imread([SrcDir Im_Prefix num2str(z,'%05d') Im_Suffix  '.jpg']);
%     Rotate_Image = imrotate(Im,-30,'bilinear','loose');
    Crop_Image = imcrop(Im,[CropWidthFirstPointCoordinate CropHeightFirstPointCoordinate CropWidth-1 CropHeight-1]);
    imwrite(Crop_Image,[DstDir Im_Prefix num2str(z,'%05d') '_Crop.jpg'],'quality',95);
    toc;
end
disp('End');