
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
 % calculating psnr
 function [psnr]=pcheck(im)

a=imread(num2str(im));
a = double(a);% original image
b=imread(num2str('output2.tif'));
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
%disp(psnr);
 end