function []=noises()
close all;
%{ 
salt and pepper
I = imread('output1.tif');
J = imnoise(I,'salt & pepper',0.02);
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)

speckle attack
I = imread('output1.tif');
J = imnoise(I,'speckle',v);
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)



gaussian
I = imread('output1.tif');
J = imnoise(I,'gaussian',0.02);

imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)



histogram equilizer
img=imread('output1.tif');
figure(1), imshow(img);

%splittting the image into its RGB components
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);


R = double(R);
G = double(G);
B = double(B);
y =  (0.299 * R) + (0.587 * G) + (0.114 * B);
I=  (0.596 * R) + (-0.274 * G) +(-0.322 * B);
Q = (0.211 * R) + (-0.523 * G )+ (0.312 * B);

y1=histeq(y);

R2 =  (1.000 * y1) + (0.956 * I) + (0.621 * Q);
G2 =  (1.000 * y1) + (-0.272 * I) + (-0.647 * Q);
B2 = (1.000 * y1) + (-1.106 * I)+ (1.703 * Q);


R2=uint8(R2);
G2=uint8(G2);
B2=uint8(B2);
%Building  the RGB image and then showing as an output
new_image=cat(3, R2, G2, B2);
imwrite(new_image,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(img-new_image)

sharpening
I = imread('output1.tif');
J=imsharpen(I,'Radius',0.1,'Amount',0.5);
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)

gaussain blur(low pass filter)
I = imread('output1.tif');
G = fspecial('gaussian',[5 5],1);
J=imfilter(I,G);
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)

cropping(512*30)
I = imread('output1.tif');
R1=I(:,:,1);
G1=I(:,:,2);
B1=I(:,:,3);
for i=1:512
    for j=1:30
        R1(i,j)=0;
        G1(i,j)=0;
        B1(i,j)=0;
    end
end
R1=uint8(R1);
G1=uint8(G1);
B1=uint8(B1);
J=cat(3, R1,G1,B1);
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)



cropping(50*50)
I = imread('output1.tif');
R1=I(:,:,1);
G1=I(:,:,2);
B1=I(:,:,3);
for i=1:512
    for j=1:30
        R1(i,j)=0;
        G1(i,j)=0;
        B1(i,j)=0;
    end
end
R1=uint8(R1);
G1=uint8(G1);
B1=uint8(B1);
J=cat(3, R1,G1,B1);
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)

jpeg compression

I = imread('output1.tif');
imwrite(I,'output2.jpg','Mode','lossy','Quality',60);
J=imread('output2.jpg');
figure(1), imshow('output2.jpg')
figure(2), imshow(I-J)

resize
I = imread('output1.tif');
T=imresize(I, [128 128]);
size(T)
J=imresize(T, [512 512]);
size(J)
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)

rotation
I = imread('output1.tif');
K=imrotate(I,2,'nearest','loose');
J=imresize(K,0.959);
figure(21),imshow(J);
imwrite(J,'output2.tif');
figure(22), imshow('output2.tif')
figure(23), imshow(I-J)

median filtering
img=imread('output1.tif');
figure(1), imshow(img);

%splittting the image into its RGB components
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

R = double(R);
G = double(G);
B = double(B);


R2=medfilt2(R);
G2=medfilt2(G);
B2=medfilt2(B);

R2=uint8(R2);
G2=uint8(G2);
B2=uint8(B2);
%Building  the RGB image and then showing as an output
new_image=cat(3, R2, G2, B2);
imwrite(new_image,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(img-new_image)

poisson attack
I = imread('output1.tif');
J = imnoise(I,'poisson');
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)

imadjust attack
I = imread('output1.tif');
J = imadjust(I,[0.1 0.1 0.1; .9 .9 1],[]);
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)

average filter 3x3

I = imread('output1.tif');
meanFilter = fspecial('average', [3 3]);
J = imfilter(I, meanFilter);
imwrite(J,'output2.tif');

gamma correction
hgamma = ...
   vision.GammaCorrector(2.2,'Correction','De-gamma');
I = imread('output1.tif');
J = step(hgamma, I);
imwrite(J,'output2.tif');
imshow(I-J)

%%
I = double(imread('output1.tif'));
for i =1:512
    for j=1:512
        I(i,j)=((I(i,j)./255)^0.8).*255;
    end
end
I=uint8(I);
imwrite(I,'output2.tif');
%%

gaussian noise mean=0, variance=0.01
img=imread('output1.tif');
figure(1), imshow(img);
 J=imnoise(img,'gaussian',0,0.01);
imwrite(J,'output2.tif');

variance =0.003
img=imread('output1.tif');
figure(1), imshow(img);
 J=imnoise(img,'gaussian',0,0.003);
imwrite(J,'output2.tif');


contrast adjustment
I = imread('output1.tif');
J=imcontrast(I);
imwrite(J,'output2.tif');
figure(1), imshow('output2.tif')
figure(2), imshow(I-J)



%}

img=imread('output1.tif');
figure(1), imshow(img);
 J=imnoise(img,'gaussian',0,0.01);
imwrite(J,'output2.tif');

end