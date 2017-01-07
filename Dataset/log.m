warning('all', 'off');

close all;

fileName = '2euro_a2.jpg';
% startPoint = [549,399];
% endPoint =[731,524];
meanValue= [0, 0, 0];

% imtool(fileName);
img = imread(fileName);
% 
% for j = startPoint(1):endPoint(1)
%     for i = startPoint(2):endPoint(2)
%         meanValue(1) = meanValue(1) + img(i, j, 1);
%         meanValue(2) = meanValue(2) + img(i, j, 2);
%         meanValue(3) = meanValue(3) + img(i, j, 3);
%     end
% end
% 
% meanValue = meanValue./(startPoint(1)-endPoint(1))./(startPoint(2)-endPoint(2));


[img_crop, rect] = imcrop(img);
img_crop = double(img_crop);
for i = 1:size(img_crop,1)
    for j = 1:size(img_crop,2)
        meanValue(1) = meanValue(1) + img_crop(i, j, 1);
        meanValue(2) = meanValue(2) + img_crop(i, j, 2);
        meanValue(3) = meanValue(3) + img_crop(i, j, 3);
    end
end

meanValue = meanValue./size(img_crop,1)./size(img_crop,2);

meanValue


close all;


[img_crop, rect] = imcrop(img);
img_crop = double(img_crop);
for i = 1:size(img_crop,1)
    for j = 1:size(img_crop,2)
        meanValue(1) = meanValue(1) + img_crop(i, j, 1);
        meanValue(2) = meanValue(2) + img_crop(i, j, 2);
        meanValue(3) = meanValue(3) + img_crop(i, j, 3);
    end
end

meanValue = meanValue./size(img_crop,1)./size(img_crop,2);

meanValue

close all;

imtool(fileName);