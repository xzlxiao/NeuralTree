% �˽ű�����ͼƬ�ü�
clear all;
close all;
clc;
SrcDir='I:\MOSTData\MBA-GI13442_preprocess\08301-08800\';        %�ļ������ַ
DstDir = 'I:\MOSTData\MBA-GI13442_ongoing\Right hippocampal tissue mod\08301-08800\'; %�ļ������ַ
dirfile=dir(SrcDir);
% ImNum=size(dirfile);
Im_Name = dirfile(3).name;
if size(dirfile,2)<12
    Im_Name =dirfile(4).name; %skip the Thumb file
end
Im_Prefix = Im_Name(1:11);  %��������ǰ׺����
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
CropHeight = 8512;   %�ü��߶�
CropWidth = 5984;    %�ü����
CropWidthFirstPointCoordinate = 22528;  %���Ͻǵ�ĺ�����
CropHeightFirstPointCoordinate = 4096; %���Ͻǵ��������

zRange = [08301 08800];   %����ü���ͼƬ��ŷ�Χ

for z = zRange(1) : 1 :zRange(2)
    disp('----------------------------------'), disp(z) , disp('-----------------------------');%
    tic;
    %     Im=imread([SrcDir Im_Prefix num2str(z,'%05d') '.jpg']);
    Im=imread([SrcDir Im_Prefix  '_' num2str(z,'%05d') '.jpg']);
%     Rotate_Image = imrotate(Im,-30,'bilinear','loose');
    Crop_Image = imcrop(Im,[CropWidthFirstPointCoordinate CropHeightFirstPointCoordinate CropWidth-1 CropHeight-1]);
    imwrite(Crop_Image,[DstDir Im_Prefix '_' num2str(z,'%05d') '_Crop.jpg'],'quality',95);
    toc;
end
disp('End');