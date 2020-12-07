function ImgFill = processNum(ImgNum, i)
% input:读入的原始.bmp图像。如果想做预测错误信息追踪，可以取消下方注释，可以输出
% 图像预处理
    ImgNum = 255-ImgNum;    % 转换成黑色的
    matrix=(ImgNum<210);    % 抠出图像的阈值
    [a,b]=find(matrix==1);  % 抠出的位置
    ImgFill = uint8(255-zeros(28,28));  % 做一个白色的图
    for j = 1:size(a)
        ImgFill(a(j),b(j))=ImgNum(a(j),b(j));
    end
%     figure;
%     imshow(ImgFill);
%     imwrite(ImgFill, num2str(i)+"_input.jpg"); 如果预测失败便于追踪
end

