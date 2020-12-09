function res = scale( img,a,b )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

img((img<a))=(img((img<a))).^b;
res = img;
end

