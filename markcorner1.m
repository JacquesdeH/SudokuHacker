function [leftup] = markcorner1(img)
%人工对图片中的数独的左上顶点进行标注
%输入：图片matrix
%输出：    leftup: 左上坐标
%
%figure;
imshow(img);
set(gcf,'outerposition',get(0,'screensize'));
hold on;
[x0,y0] = ginput;
plot(x0,y0,'r*');
leftup = [x0(1),y0(1)];