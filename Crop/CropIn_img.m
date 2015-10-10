function [] = CropIn_img(img_inf)
% 函数功能：图片裁剪及反色
% 修改时间：2015-10-2
% 作者：肖镇龙
% function [] = CropIn_img(img_inf)
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
waitbar_crop3 = waitbar(0, '当前图片序列进度');
steps = img_inf.Zend - img_inf.Zstart;
for z = zRange(1) : 1 :zRange(2)
    disp('----------------------------------'), disp(z) , disp('-----------------------------');%
    tic;
    waitbar((z-img_inf.Zstart)/steps, waitbar_crop3, strcat('正在裁剪当前序列第', num2str(z-img_inf.Zstart), '张图片'));
    %     Im=imread([SrcDir Im_Prefix num2str(z,'%05d') '.jpg']);
    Im=imread([SrcDir Im_Prefix num2str(z,'%05d') Im_Suffix  '.jpg']);
%     Rotate_Image = imrotate(Im,-30,'bilinear','loose');
    Crop_Image = imcrop(Im,[CropWidthFirstPointCoordinate CropHeightFirstPointCoordinate CropWidth-1 CropHeight-1]);
    Crop_tmp = img_invert(Crop_Image);
    imwrite(Crop_tmp,[DstDir Im_Prefix num2str(z,'%05d') '.jpg'],'quality',95);
    toc;
end
close(waitbar_crop3);
disp('End');