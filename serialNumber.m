function [serial] =  serialNumber(num)
% input:����
% output:ministѵ�����������ȡ��Ӧ���ֵ�ͼ��
% ���ɶ�Ӧ��ͼƬ���
    if num == 0
        sumNum = 5000;
    end
    if num == 1
        sumNum = 6741;
    end
    if num == 2
        sumNum = 5957;
    end
    if num == 3
        sumNum = 6130;
    end
    if num == 4
        sumNum = 5841;
    end
    if num == 5
        sumNum = 5420;
    end
    if num == 6
        sumNum = 5917;
    end
    if num == 7
        sumNum = 6264;
    end
    if num == 8
       sumNum = 5850;
    end
    if num == 9
        sumNum = 5948;
    end
    serial=round(sumNum.*rand(1,1)); 
end

