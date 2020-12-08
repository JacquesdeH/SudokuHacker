function [digit_pics,is_empty]  = img2nums(filename)
%���룺ͼƬ�����ƣ�������ڵ�ǰ�ļ����¿����·��
%�����digit_picsΪ28*28*81�ľ��󣬰���81��28*28������ͼƬ��digit1 = reshape(digit_pics(1,:),28,28)
%       is_empty Ϊ9*9����1Ϊ�� 0Ϊ�ǿ�
%�ֶ���ǲ���1��������4���ǣ�˳��Ϊ���ϣ��������£�����
%�ֶ���ǲ���2�����������Ͻǣ����ߵ����Ե

pic_size = 28;
margin = 10;
box_size = pic_size+margin;
img = imread(filename);
%img = imread('IMG_1.JPG');


%step 1 ���ԭ����ͼƬ��4������
moving_points = markcorner4(img);

close all;


%step 2 ��ԭͼƬ����͸��任
fixed_points = [0,0;
    9*box_size,0;
    9*box_size,9*box_size;
    0,9*box_size];%Ŀ��ͼƬ��4������

img = projection(img,moving_points,fixed_points);
%pause


%step 3 ���͸��任��ͼ������Ͻ�
leftup = markcorner1(img);
img = imcrop(img,[leftup,box_size*9,box_size*9]);
img_gray = rgb2gray(img);
BW = adaptivethresh(img_gray);

close all;

%step 4 ȡ��81����������
k = [0,1,2,3,4,5,6,7,8];
k1 = box_size * k + margin/2;
[X,Y] = meshgrid(k1,k1);
X1 = X + pic_size;
Y1 = Y + pic_size;
figure;
imshow(img_gray);
hold on;
plot(X,Y,'r*')
plot(X1,Y1,'G*')
B = [X(:),Y(:),(pic_size-1)*ones(1,81)',(pic_size-1)*ones(1,81)'];
digit_pics = zeros(pic_size,pic_size,81);
for i=1:81
    tmp = imcrop(img_gray,B(i,:));
    %tmp = rgb2gray(tmp)
    if i ==1
        display((im2double(reshape(tmp(:),pic_size,pic_size))));
    end
    tmp = reshape(tmp(:),pic_size,pic_size)./256;
    tmp = im2bw(tmp,graythresh(tmp));
    tmp = 1-tmp;
    digit_pics(:,:,i) = tmp;
end

%imshow(reshape(digit_pics(10,:),28,28))���÷���

%step 5 �ж��Ƿ���ڿո���
is_empty = zeros(1,81);
for i = 1:81
    if sum(sum(adaptivethresh(digit_pics(:,:,i)))) > pic_size * pic_size * 0.95
        is_empty(i) = 1;
    end
end

is_empty = reshape(is_empty,9,9);


