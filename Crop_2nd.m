% 此脚本用于图片裁剪
clear all;
close all;
clc;
SrcDir='E:\MOSTData\MBA-GI13443_Ongoing\Left hippocampal tissue mod\06201-06700\picture\';        %文件输入地址
DstDir = 'E:\MOSTData\MBA-GI13443_Ongoing\Left hippocampal tissue mod\06201-06700\2nd crop_2\'; %文件输出地址
dirfile=dir(SrcDir);
% ImNum=size(dirfile);
Im_Name = dirfile(3).name;
if size(dirfile,2)<12
    Im_Name =dirfile(4).name; %skip the Thumb file
end
Im_Prefix = Im_Name(1:11);  %输入名称前缀长度
Im_suffix = Im_Name(19:22); %输入名称后缀长度
% z = 4501;
FirstIm=imread([SrcDir Im_Name]);
%fileName=[SrcDir Imprefix '_' num2str(y,'%02d') '_' num2str(x,'%02d') '.jpg'];
Imsize=size(FirstIm);
% Imheight=uint16(Imsize(1)/3);
Imheight = uint16(Imsize(1));
% Imwidth=uint16(Imsize(2)/3);
Imwidth = uint16(Imsize(2));
% clear FirstIm;


%以下数据由Fiji测量获得
CropWidthFirstPointCoordinate = 9900;  %左上角点的横坐标
CropHeightFirstPointCoordinate = 5664; %左上角点的纵坐标
CropWidth = 1740;    %裁剪宽度
CropHeight = 1704;   %裁剪高度

zRange = [06201 06700];   %所需裁剪的图片编号范围

for z = zRange(1) : 1 :zRange(2)
    disp('----------------------------------'), disp(z) , disp('-----------------------------');%
    tic;
    %     Im=imread([SrcDir Im_Prefix num2str(z,'%05d') '.jpg']);
    Im=imread([SrcDir Im_Prefix  '_' num2str(z,'%05d') '_' Im_suffix '.jpg']);
%     Rotate_Image = imrotate(Im,-30,'bilinear','loose');
    Crop_Image = imcrop(Im,[CropWidthFirstPointCoordinate CropHeightFirstPointCoordinate CropWidth-1 CropHeight-1]);
    imwrite(Crop_Image,[DstDir Im_Prefix '_' num2str(z,'%05d') '_Crop.jpg'],'quality',95);
    toc;
end
disp('End');