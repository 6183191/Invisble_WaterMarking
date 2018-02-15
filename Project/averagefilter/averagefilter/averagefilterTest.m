% Compare the integral image method with IMFILTER.
% The output images should be the same (error = 0).

% Parameters
image = imread('eight.tif');
m = 3;
n = 5;

% Integral image method
filteredMy = averagefilter(image, m, n);
figure(1)
imshow(filteredMy)

% Built in method
meanFilter = fspecial('average', [m n]);
filtered = imfilter(image, meanFilter);
figure(2)
imshow(filtered)

% Pixel-wise comparison of the methods 
error = sum(sum(abs(filtered-filteredMy)));
display(sprintf('The pixel-wise error of the filter is: %0.0f', error));