function [successful] = sudorun(filename)
% clear all;
% problem_idx = 1;
% load pics to workspace
% [digit_pics, is_empty] = img2nums_gray("photoImg/IMG_"+problem_idx+".jpg");
[digit_pics, is_empty] = img2nums_gray(filename);
% digit_pics = ones(28, 28, 81);
% predict model output
load convnet_model.mat convnet
preds = zeros(1, 81);
for k=1:81
    cur_img = digit_pics(:,:,k);
    beauty_img = beautify(cur_img);
    out = predict(convnet, beauty_img);
    [~, pred] = max(out);
    pred = pred - 1;
    preds(1, k) = pred;
end
preds = uint32(reshape(preds, 9, 9));
% use dlx algorithm by first outlining zeros from original pic
empty_mask = uint32(~is_empty);
masked_pics = preds .* empty_mask;
try
    solved_pics = dlx_solve(masked_pics);
catch
    msgbox({'Error occurred in digit recognition !','Please select points carefully !'}, 'Error')
    successful=false;
    return
end
% original_input = imread("originImg/input_"+problem_idx+".jpg");
rgb_output = output(solved_pics, is_empty);
% imwrite(rgb_output, "outputImg/solved_"+problem_idx+".jpg");
imwrite(rgb_output, "output.jpg");
successful=true;
return

