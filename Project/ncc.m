 function [average]=ncc()
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
delete('output2.jpg');
delete('construct_watermark.tif');
close all;
 end