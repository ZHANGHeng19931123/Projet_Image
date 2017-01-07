function mask = segmentation_1(img)

img2 = rgb2gray(img);

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

mask = img22;

end