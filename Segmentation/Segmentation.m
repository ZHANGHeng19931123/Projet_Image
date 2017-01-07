%% Segmentation part

clc;
clear;
close all;

%% load image

img = imread('Dataset/2euro_b1.jpg');
figure;imshow(img,[]);
title('image');

%% Preprocessing

% Gaussian filter
img1 = imfilter(img,fspecial('gaussian',[9 9],2));
figure;imshow(img1,[]);
title('Gaussian filter');

% Sharpening
img1 = imsharpen(img1);
figure;imshow(img1,[]);
title('Sharpening');

%% Segmentation
% first methode

img2 = rgb2gray(img1);
figure; imshow(squeeze(img2(:,:,1)),[]);

[gmax,gh,gv]=tse_imgrad(img2,'gog');
[fs,high]=tse_imhysthreshold(gmax);
img2 = tse_imextendedge(fs,gh,gv);

img22 = imclose(img2, strel('disk',4));
img22 = imclose(img22, strel('disk',6));
img22 = imclose(img22, strel('disk',8));
img22 = imclose(img22, strel('disk',10));
img22 = bwareaopen(img22,400);
img22 = imclearborder(img22, 8);
img22 = imfill(img22, 'holes');
figure; imshow(img22,[]);
figure;imshow(img22.*double(rgb2gray(img)),[]);

% second methode
r = medfilt2(double(img(:,:,1)), [3,3]); 
g = medfilt2(double(img(:,:,2)), [3,3]);
b = medfilt2(double(img(:,:,3)), [3,3]);
shadow_ratio = ((4/pi).*atan(((b-g))./(b+g)));
figure, imshow(shadow_ratio, []); colormap(jet); colorbar;
shadow_mask = shadow_ratio<-0.1;
shadow_mask = bwareaopen(shadow_mask, 150);
figure, imshow(shadow_mask, []);
shadow_mask1=imclose(shadow_mask,strel('disk',10));
shadow_mask1=imfill(shadow_mask1,'holes');
figure, imshow(shadow_mask1, []);
img23 = shadow_mask1;
figure, imshow(img23, []);
figure;imshow(img23.*double(rgb2gray(img)),[]);

%% third methode

I = rgb2gray(img1);

% Detect Entire Cell
[~, threshold] = edge(I, 'sobel');
fudgeFactor = .5;
BWs = edge(I,'sobel', threshold * fudgeFactor);
figure, imshow(BWs), title('binary gradient mask');

% Dilate the Image
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
for i = 4:2:10
    se = strel('disk',i);
    BWsdil = imclose(BWsdil, se);
end
BWsdil = bwareaopen(BWsdil,400,4);
BWsdil = imclearborder(BWsdil, 8);
figure, imshow(BWsdil), title('dilated gradient mask');

% Fill Interior Gaps
BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');

% Remove Connected Objects on Border
BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');

%  Smoothen the Object
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
BWfinal = bwareaopen(BWfinal,400,4);
figure, imshow(BWfinal), title('segmented image');

BWoutline = bwperim(BWfinal);
Segout = I;
Segout(BWoutline) = 255;
figure, imshow(Segout), title('outlined original image');

%% label

[img3,n] = bwlabel(img23);
figure;imshow(img3,[]);
figure;imshow(label2rgb(img3),[]);

%% measure

img4 = regionprops(img23, 'EquivDiameter');
EquivDiameter = cat(1, img4.EquivDiameter)