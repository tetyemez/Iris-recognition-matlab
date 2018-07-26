clear all
clc

FaceDetect = vision.CascadeObjectDetector();
EyeDetect = vision.CascadeObjectDetector('RightEye');

img = imread('7.bmp');

BB_face = step(FaceDetect,img);

if size(BB_face(:,1))>0
	BB_face(1,2)=BB_face(1,2)+20;
	face=imcrop(img,BB_face(1,:));
	centerx=size(face,1)/2;
	centery=size(face,2)/2;
	half=imcrop(face,[1,1,BB_face(1,3),centery]);
	
	BB_eye=step(EyeDetect,half(1,2));
	n=size(BB_eye,1);
    
	if(n==2)     
		for it=2:size(BB_eye,1)
			if ~(abs(BB_eye(1,2)-BB_eye(it,2))>8)
				 BB_eye(2,:)=BB_eye(it,:);
				 break;
			 end
        end 		         	
             			re=imcrop(face,BB_eye(1,:));
             			le=imcrop(face,BB_eye(2,:));
                        imshow (le);
                        imshow (re);
    end
end

%figure,imshow(img);
%hold on;
%grid on;
%for i = 1:size(BB)
%    rectangle('Position',BB(:,:),'EdgeColor','r');
%end
