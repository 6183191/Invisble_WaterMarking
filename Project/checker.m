img=imread('lake.tiff');
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
red=newY;
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




img=imread('lake.tiff');
figure(1), imshow('lake.tiff')
%splittting the image into its RGB components
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

R = double(R);
G = double(G);
B = double(B);

%converting RGB to yIQ
y =  (0.299 * R) + (0.587 * G) + (0.114 * B);
I=  (0.596 * R) + (-0.274 * G) +(-0.322 * B);
Q = (0.211 * R) + (-0.523 * G )+ (0.312 * B);

%applying DWT to the Y part of the image
[yrow ycol]=size(y);
[LL1,LH1,HL1,HH1]=dwt2(y,'db1');

alpha2=calalpha(LH1);
alpha3=calalpha(HL1);
alpha = (alpha2+alpha3) / 2;

%reading the watermark

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


[Uw1,Vw1,t1,cut1]=wsingularcal(LL2);    
[Uw2,Vw2,t2,cut2]=wsingularcal(LH2);
[Uw3,Vw3,t3,cut3]=wsingularcal(HL2);
[Uw4,Vw4,t4,cut4]=wsingularcal(HH2);

%now find the singular values of the original image
iS1=singcal(LL1);
iS2=singcal(LH1);
iS3=singcal(HL1);
iS4=singcal(HH1);


%reading the image
img2=imread('output1.tif');
figure(11),imshow('output1.tif')
%splittting the image into its RGB components
Rf = img2(:,:,1);
Gf = img2(:,:,2);
Bf = img2(:,:,3);

Rf = double(Rf);
Gf = double(Gf);
Bf = double(Bf);

%converting RGB to yIQ

y3 =  (0.299 * Rf) + (0.587 * Gf) + (0.114 * Bf);
I3 =  (0.596 * Rf) + (-0.274 * Gf) +(-0.322 * Bf);
Q3 = (0.211 * Rf) + (-0.523 * Gf )+ (0.312 * Bf);

%applying DWT to the y3 part of the image
[oLL1,oLH1,oHL1,oHH1]=dwt2(red,'db1');
oiS1 = singcal(oLL1);
oiS2 = singcal(oLH1);
oiS3 = singcal(oHL1);
oiS4 = singcal(oHH1);


create1 = findQuar(oiS1,iS1,alpha,cut1,Uw1,Vw1);
create2 = findQuar(oiS2,iS2,alpha,cut2,Uw2,Vw2);
create3 = findQuar(oiS3,iS3,alpha,cut3,Uw3,Vw3);
create4 = findQuar(oiS4,iS4,alpha,cut4,Uw4,Vw4);


%applying inverse dwt to the matrix
[y1r,y1c]=size(y1);
Yw=idwt2(create1,create2,create3,create4,'db1',[y1r, y1c]);
Yw=double(Yw);
%converting yiq to RGB
R3 =  (1.000 * Yw) + (0.956 * I1) + (0.621 * Q1);
G3 =  (1.000 * Yw) + (-0.272 * I1) + (-0.647 * Q1);
B3 = (1.000 * Yw) + (-1.106 * I1)+ (1.703 * Q1);

R3=uint8(R3);
G3=uint8(G3);
B3=uint8(B3);
%Building  the RGB image and then showing as an output
construct_watermark=cat(3, R3, G3, B3);
imwrite(construct_watermark,'construct_watermark.tif');
figure(4),imshow('construct_watermark.tif')
figure(12),imshow(construct_watermark-watermark)

clear


a=imread(num2str('lake.tiff'));
a = double(a);% original image
b=imread(num2str('output1.tif'));
b = double(b);%watermarked image
%a=kite;
%b=newY;
[r,c] = size(a);
sum1 =zeros(r,1);
for i=1 : r
   for j= 1: c
          sum1(i) = sum1(i)+((a(i,j)-b(i,j)) .^ 2);
      end
end
summ=sum(sum1);
%disp(sum);
mse =(1/(r*c)).* summ;
%disp(mse);
psnr = 10 .* (log10((255*255)/mse));
psnr

clear
img=imread('mark.tif');

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

R = double(R);
G = double(G);
B = double(B);

%converting RGB to yIQ
y1 =  (0.299 * R) + (0.587 * G) + (0.114 * B);
I1 =  (0.596 * R) + (-0.274 * G) +(-0.322 * B);
Q1 = (0.211 * R) + (-0.523 * G )+ (0.312 * B);

imge=imread('construct_watermark.tif');
R1 = imge(:,:,1);
G1 = imge(:,:,2);
B1 = imge(:,:,3);

R1 = double(R1);
G1 = double(G1);
B1 = double(B1);

%converting RGB to yuv
y2 =  (0.299 * R1) + (0.587 * G1) + (0.114 * B1);
I2 =  (0.596 * R1) + (-0.274 * G1) +(-0.322 * B1);
Q2 = (0.211 * R1) + (-0.523 * G1 )+ (0.312 * B1);


n1=callncc(y1,y2);
n2=callncc(I1,I2);
n3=callncc(Q1,Q2);
average=(n1+n2+n3)/3;
average
clear
