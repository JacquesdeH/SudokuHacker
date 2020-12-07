function [rgbTable] = output(num, index, table)
% input: ��Ҫ���������num,��Ӧ������index,��Ҫ�����ͼ��table
% output: ����table��Ӧ��RGB���� 

    % step1: ��ʼ��RGB��ά���飬Ԥ������г����Ż�
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
    % step2: �������еõ��Ľ����������������ֱ�ɺ�ɫ
    for i = 1:length(num)
        serial = serialNumber(num(i));
        ImgNum = imread("train/"+int2str(num(i))+"_" +int2str(serial)+".bmp"); 
        ImgNum = 255-ImgNum;    % ת���ɺ�ɫ��
        matrix=(ImgNum<210);    % �ٳ�ͼ�����ֵ
        [a,b]=find(matrix==1);  % �ٳ���λ��
        R = uint8(255-zeros(28,28));  % ��һ����ɫ��ͼ
        G = uint8(255-zeros(28,28));  % ��һ����ɫ��ͼ
        B = uint8(255-zeros(28,28));  % ��һ����ɫ��ͼ
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

