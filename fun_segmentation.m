function [BW5,final_1,final_2] = fun_segmentation(invertedImage_1,invertedImage_2)

%% Segmentation
% Specify initial contour
mask = zeros(size(invertedImage_1)); 
mask(50:end-50,50:end-50) = 1;

%Segments image into foreground and background
bw_1 = activecontour(invertedImage_1, mask, 800); %800 iterations 
bw_2 = activecontour(invertedImage_2, mask, 400); %400 iterations 

%Create Combination Pictures with Inverted image and Contour
mix_Image_1 = invertedImage_1 + bw_1;
filter_mix_Image_1 = medfilt2(mat2gray(mix_Image_1),[5 5]); %Filtering
mix_Image_2 = invertedImage_2 + bw_2;
filter_mix_Image_2 = medfilt2(mat2gray(mix_Image_2),[7 7]); %Filtering

%Black White Combination to Create Final Images
final_2 = im2bw(filter_mix_Image_2, 0.6);
final_1 = im2bw(filter_mix_Image_1, 0.6);
pre_final = final_1; %transfer
subplot(3,3,6); %divides figure into rectangular panes
BW5 = imfill(pre_final,'holes');
imshow(BW5); %show image
title('Segmented'); %image name

end