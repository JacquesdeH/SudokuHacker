function [dst_img] = projection(img,moving_points,fixed_points)
tfom = fitgeotrans(moving_points,fixed_points,'projective');
X = moving_points(:,1);
Y = moving_points(:,2);
%[x,y] = transformPointsForward(tfom,X(:),Y(:));
%figure;plot(x,y,'ro');title('��֤��������')
%grid on

dst_img = imwarp(img,tfom);

%figure;imshow(dst_img);title('ͼ�����任��ϵͳ������')