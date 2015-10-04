function A = img_prj( A, B, k)
% 函数功能：图片投影
% 修改时间：2015-10-4
% 作者：肖镇龙
% function A = img_prj( A, B)
% 参数：
% k: 0, min投影； 1, max投影
if isequal(size(A), size(B)) == 0
    error('输入的图片大小不同');
end
if k == 0       % min投影
    if A == B
        return;
    else
        [c, r] = size(A);
        for i = 1 : c
            for j = 1 : r
                if A(i, j) > B(i, j)
                    A(i, j) = B(i, j);
                end
            end
        end
        return
    end
elseif k == 1       % max投影
    if A == B
        return;
    else
        [c, r] = size(A);
        for i = 1 : c
            for j = 1 : r
                if A(i, j) < B(i, j)
                    A(i, j) = B(i, j);
                end
            end
        end
        return
    end
else
    error('请输入正确的参数')
end

