function [moving_points] = markcorner4(img)
%�˹���ͼƬ�е������Ķ�����б�ע����ע˳��Ϊ���ϣ����ϣ����£�����
%���룺ͼƬmatrix
%�����moving_points����ʽΪ4*2���󣬱�ʾ4���㣬���ں���͸�ӱ任
figure;
imshow(img);
set(gcf,'outerposition',get(0,'screensize'));
hold on;
[x0,y0] = ginput;
plot(x0,y0,'r*');
moving_points = [x0,y0];
