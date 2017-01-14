function img_o = preprocessing(img)

% Gaussian filter
img_o = imfilter(img,fspecial('gaussian',[9 9],2));

% Sharpening
img_o = imsharpen(img_o);

end