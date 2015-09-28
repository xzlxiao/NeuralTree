function [] = Crop_img(img_inf)
% �������ܣ�ͼƬ�ü�
% �޸�ʱ�䣺2015-9-24
% ���ߣ�Ф����
% function [] = Crop()
SrcDir=img_inf.SrcDir;        %�ļ������ַ
DstDir = img_inf.DstDir;    %�ļ������ַ
dirfile=dir(SrcDir);
Im_Name = img_inf.filename;
Im_Prefix = img_inf.prefix;
Im_Suffix = img_inf.suffix;

%����������Fiji�������
CropWidthFirstPointCoordinate = img_inf.CropWidthFirstPointCoordinate;  %���Ͻǵ�ĺ�����
CropHeightFirstPointCoordinate = img_inf.CropHeightFirstPointCoordinate; %���Ͻǵ��������
CropWidth = img_inf.CropWidth;    %�ü����
CropHeight = img_inf.CropHeight ;   %�ü��߶�

zRange = [img_inf.Zstart img_inf.Zend];   %����ü���ͼƬ��ŷ�Χ

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