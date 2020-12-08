clear all;
% load pics to workspace
[digit_pics, is_empty] = img2nums('image/IMG_1.JPG');
% digit_pics = ones(28, 28, 81);
reshaped_pics = reshape(digit_pics, 784, 81);
load net120.mat
load net28.mat
outs = sim(net28, reshaped_pics);
[maxout, preds] = max(outs);
preds = uint32(reshape(preds, 9, 9));
% use dlx algorithm by first outlining zeros from original pic
empty_mask = uint32(~is_empty);
masked_pics = preds .* empty_mask;
solved_pics = dlx_solve(masked_pics);