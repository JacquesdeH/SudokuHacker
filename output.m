function [rgbTable] = output(num, index, table)
% input: 需要填入的数字num,对应的坐标index,需要填入的图像table
% output: 返回table对应的RGB数组 

    % step1: 初始化RGB三维数组，预定义进行程序优化
    tableR = zeros(312, 312);
    tableG = zeros(312, 312);
    tableB = zeros(312, 312);
    for m = 1:312
        for n = 1:312
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
    for i = 1:length(num)
        serial = serialNumber(num(i));
        ImgNum = imread("train/"+int2str(num(i))+"_" +int2str(serial)+".bmp"); 
        ImgNum = 255-ImgNum;    % 转换成黑色的
        matrix=(ImgNum<210);    % 抠出图像的阈值
        [a,b]=find(matrix==1);  % 抠出的位置
        R = uint8(255-zeros(28,28));  % 做一个白色的图
        G = uint8(255-zeros(28,28));  % 做一个白色的图
        B = uint8(255-zeros(28,28));  % 做一个白色的图
        for j = 1:length(a)
            R(a(j),b(j))=255;
            G(a(j),b(j))=0;
            B(a(j),b(j))=0;
        end
        imshow(I);
        [rowIndex,colIndex] = Index_Sudo(index(i,1),index(i,2));
        for m = 1:28
            for n = 1:28
                tableR(rowIndex+m,colIndex+n) = R(m,n);
                tableG(rowIndex+m,colIndex+n) = G(m,n);
                tableB(rowIndex+m,colIndex+n) = B(m,n);
            end
        end
    end
    rgbTable = cat(3,tableR, tableG, tableB);
    imshow(rgbTable);
end

