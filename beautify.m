function ret = beautify(cur_img)
%BEAUTIFY �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    cur_min = min(min(cur_img));
    new_img = round((cur_img-cur_min)./(256-cur_min).*256);
    new_img = round(scale(new_img, 30, 0.2));
    ret = new_img;
end

