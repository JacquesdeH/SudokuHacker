function [moving_points] = markcorner4(img)
%人工对图片中的数独的顶点进行标注，标注顺序为左上，右上，右下，左下
%输入：图片matrix
%输出：moving_points，格式为4*2矩阵，表示4个点，用于后续透视变换
figure;
imshow(img);
set(gcf,'outerposition',get(0,'screensize'));
hold on;
[x0,y0] = ginput;
plot(x0,y0,'r*');
moving_points = [x0,y0];
