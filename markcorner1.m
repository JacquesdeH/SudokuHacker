function [leftup] = markcorner1(img)
%�˹���ͼƬ�е����������϶�����б�ע
%���룺ͼƬmatrix
%�����    leftup: ��������
%
%figure;
imshow(img);
set(gcf,'outerposition',get(0,'screensize'));
hold on;
[x0,y0] = ginput;
plot(x0,y0,'r*');
leftup = [x0(1),y0(1)];