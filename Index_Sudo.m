function [rowIndex,colIndex] = Index_Sudo(row, col) 
% input:数字在九宫格中的位置
% output:数字在九宫格中的左上角坐标，数字像素为28*28已知
% 从在格子中的位置信息得到在矩阵中的信息
    wide = 4;   % 粗线
    thin = 2;   % 细线
    gezi = 44;  % 格子宽度
    liubai = 8; % 格子宽度与图像之间的差距
    rowIndex = wide+(gezi+thin)*(row-1)+liubai;
    colIndex = wide+(gezi+thin)*(col-1)+liubai;
end

