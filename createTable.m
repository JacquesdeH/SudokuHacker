%% 构造格子，输出为一个312*312像素的九宫格
function [Img] = createTable()
% 输出格子图像Img
Img = uint8(255-zeros(312));
for i = 1:4
    for j = 1:312
        Img(i,j) = 0;
        Img(j,i) = 0;
    end
end
for i = 1:9
    first = 4+32*i+2*(i-1)+1;
    second = 4+32*i+2*(i-1)+2;
    for k = 1:312
        Img(first,k) = 0;
        Img(second, k) = 0;
        Img(k,first) = 0;
        Img(k, second) = 0;
    end
end
for i = 311:312
    for k = 1:312
        Img(i,k)=0;
        Img(k,i)=0;
    end
end
imwrite(Img, "table.jpg");  % 把格子画出来