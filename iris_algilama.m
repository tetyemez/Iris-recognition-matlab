clear all
clc

%FaceDetect = vision.CascadeObjectDetector();bb_Face = step(FaceDetect,Image);

EyeDetect = vision.CascadeObjectDetector('RightEyeCART');

Image = imread('9.bmp');
test_size = 3;
im_size = length(size(Image));
bb_Eye = step(EyeDetect,Image);
eye_crop = imcrop(Image,bb_Eye(1,:));

if test_size == im_size
    eye_crop = rgb2gray(eye_crop);
end
eye_crop = imresize(eye_crop, [30 30]);
h = bb_Eye(1,3);
w = bb_Eye(1,4);
eye = imcrop(eye_crop,[1,10,h,w]);
%imshow(eye);
 %Histogram Equalization
 HistEq = histeq(eye);
 %figure, imshow (HistEq);
 %title('Histogram Equalization');
 
 %Binarization 
 % threshold 
t = 16;
% find values below
ind_below = (HistEq < t);
% find values above
ind_above = (HistEq >= t);
% set values below to black
HistEq(ind_below) = 255;
% set values above to white
HistEq(ind_above) = 0;
%imshow(HistEq); 
%title ('Histogram equalization');
%title('Binarization');

 %Morphologic Operations (Erosion & Dilation) 
 filledHistEq = imfill(HistEq,'holes');
 se = strel('ball',1,1);
 eroded = imdilate(filledHistEq,se);
 se2 = strel('ball',1,1);
 dilate=imdilate(eroded,se2);
 %figure, imshow(eroded);
 %title('Erosion');
 %figure, imshow(dilate);
 %title('Dilation');
 
 %Find iris
  [L,num] = bwlabel(dilate,8);
  
    RP = regionprops (L, 'Area');
    max=0;
    for i=1:num
        if (RP(i).Area > max)
            max = RP(i).Area;
        end
    end
    
    for j=1:num
        if (max == RP(j).Area)
            maxx_ind = j;
        end
    end   
  
 %Bounding Box  
  RP1 = regionprops (L, 'BoundingBox');
  figure
  eye = imadjust(eye);
  imshow(eye);
  title('Iris Positioning');
  hold on;
  rectangle('Position',[RP1(maxx_ind).BoundingBox],'EdgeColor','r');
  clear all;
%end