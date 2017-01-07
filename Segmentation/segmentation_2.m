function mask = segmentation_2(img)

r = medfilt2(double(img(:,:,1)), [3,3]); 
g = medfilt2(double(img(:,:,2)), [3,3]);
b = medfilt2(double(img(:,:,3)), [3,3]);
shadow_ratio = ((4/pi).*atan(((b-g))./(b+g)));
shadow_mask = shadow_ratio<-0.1;
shadow_mask = bwareaopen(shadow_mask, 150);
shadow_mask1=imclose(shadow_mask,strel('disk',10));
shadow_mask1=imfill(shadow_mask1,'holes');
mask = shadow_mask1;

end
