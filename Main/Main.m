%% Main Programme

clc;
clear;
close all;

%% load image

img = imread('Dataset/4_3.jpg');
figure;imshow(img,[]);
title('original image');

%% Preprocessing and Segmentation

img = preprocessing(img);
mask = segmentation_3(img);
figure;imshow(mask.*double(rgb2gray(img)),[]);
title('mask');

%% Recognition

[value_total, centroids, values] = recognition_1(mask, img);
% show results
figure;imshow(img,[]);
hold on;
for i = 1:size(values,1)
    text(centroids(i,1),centroids(i,2),num2str(values(i)),'Color','red','FontSize',14, 'FontWeight', 'bold', 'HorizontalAlignment', 'center')
end
text(0,0, num2str(value_total),'Color','red','FontSize',14, 'FontWeight', 'bold')
hold off;
title('recognition result');