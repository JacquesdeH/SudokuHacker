function [rgbTable] = output(solved_pics, isempty, table)
% input:结果数组solved_pics, isempty，需要填入的图像table
% output: 返回table对应的RGB数组 
    maxNum = 420;
    % step1: 初始化RGB三维数组，预定义进行程序优化
    tableR = zeros(maxNum, maxNum);
    tableG = zeros(maxNum, maxNum);
    tableB = zeros(maxNum, maxNum);
    for m = 1:maxNum
        for n = 1:maxNum
            if table(m,n) < 200
                tableR(m,n) = 0;
                tableG(m,n) = 0;
                tableB(m,n) = 0;
            else
                tableR(m,n) = 255;
                tableG(m,n) = 255;
                tableB(m,n) = 255;
            end
        end
    end
    % step2: 遍历所有得到的结果，将新填入的数字变成红色
    for i = 1:9
        for j = 1:9
            if isempty(i,j) ~= 0
                ImgNum = imread("fonts/"+solved_pics(i,j)+".bmp");   % 数字图片位置
                ImgNum = 255-ImgNum;    % 转换成黑色的
                matrix=(ImgNum<210);    % 抠出图像的阈值
                [a,b]=find(matrix==1);  % 抠出的位置
                R = uint8(255-zeros(28,28));  % 做一个白色的图
                G = uint8(255-zeros(28,28));  % 做一个白色的图
                B = uint8(255-zeros(28,28));  % 做一个白色的图
                for k = 1:length(a)
                    R(a(k),b(k))=255;
                    G(a(k),b(k))=0;
                    B(a(k),b(k))=0;
                end
                [rowIndex,colIndex] = Index_Sudo(i,j);
                for m = 1:28
                    for n = 1:28
                        tableR(rowIndex+m,colIndex+n) = R(m,n);
                        tableG(rowIndex+m,colIndex+n) = G(m,n);
                        tableB(rowIndex+m,colIndex+n) = B(m,n);
                    end
                end
                rgbTable = cat(3,tableR, tableG, tableB);
            end
        end
    end  
    imshow(rgbTable);
end

