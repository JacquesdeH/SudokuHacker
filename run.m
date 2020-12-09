clear all;
% load pics to workspace
[digit_pics, is_empty] = img2nums_gray('image/IMG_2.JPG');
% digit_pics = ones(28, 28, 81);
% predict model output
load convnet_model.mat
preds = zeros(1, 81);
for k=1:81
    cur_img = digit_pics(:,:,k);
    cur_min = min(min(cur_img));
    new_img = round((cur_img-cur_min)./(256-cur_min).*256);
    new_img = round(scale(new_img, 30, 0.2));
    out = predict(convnet, new_img);
    [~, pred] = max(out);
    pred = pred - 1;
    preds(1, k) = pred;
end
preds = uint32(reshape(preds, 9, 9));
% use dlx algorithm by first outlining zeros from original pic
empty_mask = uint32(~is_empty);
masked_pics = preds .* empty_mask;
solved_pics = dlx_solve(masked_pics);