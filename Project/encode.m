function [alpha] = encode(im)
%reading the image
img=imread(im);
figure(1), imshow(img)
%splittting the image into its RGB components
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

R = double(R);
G = double(G);
B = double(B);

%converting RGB to yIQ
yy =  (0.299 * R) + (0.587 * G) + (0.114 * B);
I=  (0.596 * R) + (-0.274 * G) +(-0.322 * B);
Q = (0.211 * R) + (-0.523 * G )+ (0.312 * B);

%applying DWT to the Y part of the image
[yrow ycol]=size(yy);
[LL1,LH1,HL1,HH1]=dwt2(yy,'db1');


%calculating alpha
alpha2=calalpha(LH1);
alpha3=calalpha(HL1);
alpha = (alpha2+alpha3) / 2;


%reading the water mark
watermark=imread('mark.tif');
figure(2), imshow(watermark)

%splittting the watermark into its RGB components
R = watermark(:,:,1);
G = watermark(:,:,2);
B = watermark(:,:,3);

%converting RGB to yiq
R=double(R);
G=double(G);
B=double(B);


y1 =  (0.299 * R) + (0.587 * G) + (0.114 * B);
I1 =  (0.596 * R) + (-0.274 * G) +(-0.322 * B);
Q1 = (0.211 * R) + (-0.523 * G )+ (0.312 * B);


[y1row, y1col]=size(y1);
[LL2,LH2,HL2,HH2]=dwt2(y1,'db1');


val1 = newdwt (LL1,LL2,alpha);
val2 = newdwt (LH1,LH2,alpha);
val3 = newdwt (HL1,HL2,alpha);
val4 = newdwt (HH1,HH2,alpha);

%applying inverse dwt to the matrix
newY=idwt2(val1,val2,val3,val4,'db1',[yrow ycol]);

newY=double(newY);

%converting yiq to RGB
R1 =  (1.000 * newY) + (0.956 * I) + (0.621 * Q);
G1 =  (1.000 * newY) + (-0.272 * I) + (-0.647 * Q);
B1 = (1.000 * newY) + (-1.106 * I )+ (1.703 * Q);

R1=uint8(R1);
G1=uint8(G1);
B1=uint8(B1);

%Building  the RGB image and then showing as an output
encimage=cat(3, R1, G1, B1);
imwrite(encimage,'output1.tif');
figure(11), imshow('output1.tif')

end