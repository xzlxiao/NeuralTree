function [] = CropIn_img(img_inf)
% �������ܣ�ͼƬ�ü�����ɫ
% �޸�ʱ�䣺2015-10-2
% ���ߣ�Ф����
% function [] = CropIn_img(img_inf)
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
waitbar_crop3 = waitbar(0, '��ǰͼƬ���н���');
steps = img_inf.Zend - img_inf.Zstart;
for z = zRange(1) : 1 :zRange(2)
    disp('----------------------------------'), disp(z) , disp('-----------------------------');%
    tic;
    waitbar((z-img_inf.Zstart)/steps, waitbar_crop3, strcat('���ڲü���ǰ���е�', num2str(z-img_inf.Zstart), '��ͼƬ'));
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