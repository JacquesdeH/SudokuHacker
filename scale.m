function res = scale( img,a,b )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

img((img<a))=(img((img<a))).^b;
res = img;
end

