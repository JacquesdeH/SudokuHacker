function [rgbTable] = output(solved_pics, isempty)
% input:�������solved_pics, isempty
% output: ����table��Ӧ��RGB���� 
    table = createTable();
    maxNum = 420;
    % step1: ��ʼ��RGB��ά���飬Ԥ������г����Ż�
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
    % step2: �������еõ��Ľ����������������ֱ�ɺ�ɫ
    for i = 1:9
        for j = 1:9
            ImgNum = imread("fonts/"+solved_pics(i,j)+".bmp");   % ����ͼƬλ��
            ImgNum = 255-ImgNum;    % ת���ɺ�ɫ��
            matrix=(ImgNum<210);    % �ٳ�ͼ�����ֵ
            [a,b]=find(matrix==1);  % �ٳ���λ��
            R = uint8(255-zeros(28,28));  % ��һ����ɫ��ͼ
            G = uint8(255-zeros(28,28));  % ��һ����ɫ��ͼ
            B = uint8(255-zeros(28,28));  % ��һ����ɫ��ͼ
            if isempty(i,j) ~= 0
                for k = 1:length(a)
                    R(a(k),b(k))=255;
                    G(a(k),b(k))=0;
                    B(a(k),b(k))=0;
                end
            end
            if isempty(i,j) == 0
                for k = 1:length(a)
                    R(a(k),b(k))=0;
                    G(a(k),b(k))=0;
                    B(a(k),b(k))=0;
                end
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
    % imshow(rgbTable);
end

