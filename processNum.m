function ImgFill = processNum(ImgNum, i)
% input:�����ԭʼ.bmpͼ���������Ԥ�������Ϣ׷�٣�����ȡ���·�ע�ͣ��������
% ͼ��Ԥ����
    ImgNum = 255-ImgNum;    % ת���ɺ�ɫ��
    matrix=(ImgNum<210);    % �ٳ�ͼ�����ֵ
    [a,b]=find(matrix==1);  % �ٳ���λ��
    ImgFill = uint8(255-zeros(28,28));  % ��һ����ɫ��ͼ
    for j = 1:size(a)
        ImgFill(a(j),b(j))=ImgNum(a(j),b(j));
    end
%     figure;
%     imshow(ImgFill);
%     imwrite(ImgFill, num2str(i)+"_input.jpg"); ���Ԥ��ʧ�ܱ���׷��
end

