function [rowIndex,colIndex] = Index_Sudo(row, col) 
% input:�����ھŹ����е�λ��
% output:�����ھŹ����е����Ͻ����꣬��������Ϊ28*28��֪
% ���ڸ����е�λ����Ϣ�õ��ھ����е���Ϣ
    wide = 4;   % ����
    thin = 2;   % ϸ��
    gezi = 44;  % ���ӿ��
    liubai = 8; % ���ӿ����ͼ��֮��Ĳ��
    rowIndex = wide+(gezi+thin)*(row-1)+liubai;
    colIndex = wide+(gezi+thin)*(col-1)+liubai;
end

