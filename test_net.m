load net120.mat
imgs = img2nums('image/IMG_1.JPG');
input = zeros(784,81);
for i=1:81
    input(:,i) = reshape(imgs(:,:,i)',784,1);
end
output = sim(net120,input);
[m,I]=max(output);
sudoku = reshape(I-1,9,9);