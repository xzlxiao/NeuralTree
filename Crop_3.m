   % �˽ű�����ͼƬ�ü�
clear all;
close all;
clc;
SrcDir='E:\MOSTData\MBA-GI13443_Ongoing\Left hippocampal tissue mod\07701-08200\INVERT\';        %�ļ������ַ
DstDir = 'E:\MOSTData\MBA-GI13443_Ongoing\Left hippocampal tissue mod\07701-08200\2nd crop_3\'; %�ļ������ַ
dirfile=dir(SrcDir);
% ImNum=size(dirfile);
Im_Name = dirfile(3).name;
if size(dirfile,2)<12
    Im_Name =dirfile(4).name; %skip the Thumb file
end
Im_Prefix = Im_Name(1:11);  %��������ǰ׺����
Im_midfix = Im_Name(13:23); %�������ƺ�׺����
% z = 4501;
FirstIm=imread([SrcDir Im_Name]);
%fileName=[SrcDir Imprefix '_' num2str(y,'%02d') '_' num2str(x,'%02d') '.jpg'];
Imsize=size(FirstIm);
% Imheight=uint16(Imsize(1)/3);
Imheight = uint16(Imsize(1));
% Imwidth=uint16(Imsize(2)/3);
Imwidth = uint16(Imsize(2));
% clear FirstIm;


%����������Fiji�������
CropWidthFirstPointCoordinate =8340;  %���Ͻǵ�ĺ�����
CropHeightFirstPointCoordinate = 1728; %���Ͻǵ��������
CropWidth = 2004;    %�ü����
CropHeight = 2028;   %�ü��߶�

zRange = [07701 08200];   %����ü���ͼƬ��ŷ�Χ

for z = zRange(1) : 1 :zRange(2)
    disp('----------------------------------'), disp(z) , disp('-----------------------------');%
    tic;
    %     Im=imread([SrcDir Im_Prefix num2str(z,'%05d') '.jpg']);
    Im=imread([SrcDir Im_Prefix '_' Im_midfix '_' num2str(z,'%05d')  '.tif']);
%     Rotate_Image = imrotate(Im,-30,'bilinear','loose');
    Crop_Image = imcrop(Im,[CropWidthFirstPointCoordinate CropHeightFirstPointCoordinate CropWidth-1 CropHeight-1]);
    imwrite(Crop_Image,[DstDir Im_Prefix '_' num2str(z,'%05d') '_Crop.jpg'],'quality',95);
    toc;
end
disp('End');