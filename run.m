clear all;
problem_idx = 1;
% load pics to workspace
[digit_pics, is_empty] = img2nums_gray("photoImg/IMG_"+problem_idx+".jpg");
% digit_pics = ones(28, 28, 81);
% predict model output
load convnet_model.mat
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
    disp('Error occurred in digit recognition!')
end
original_input = imread("originImg/input_"+problem_idx+".jpg");
rgb_output = output(solved_pics, is_empty, original_input);
imwrite(rgb_output, "outputImg/solved_"+problem_idx+".jpg");
