clear all
close all
clc

mov=VideoReader('Database2\\video_2_project.mp4');
nFrames=mov.NumberOfFrames;

for no=1:nFrames
  videoFrame=read(mov,no);
  videoFrame=imresize(videoFrame,0.5);
  videoFrame_gray=rgb2gray(videoFrame);
      B = imrotate(videoFrame_gray,-90);
  
  imshow(B);
  
  imge_son1=sprintf('database\\goz\\frame%04d_face.bmp',no);
imwrite(uint8(B),imge_son1)
end

