 function [val]=callncc(a,b)
 [r c]=size(a);
 sum1=zeros(r,1);
 for i=1:r
     for j=1:c
     temp=a(i,j).* b(i,j);
     sum1(i)=sum1(i)+temp;
     end
 end
 numerator=sum(sum1);
 temp1=a.^2;
 temp2=b.^2;
 sum2=zeros(r,1);
 sum3=zeros(r,1);
 for i=1:r
     for j=1:c
     sum2(i)=sum2(i)+temp1(i,j);
     sum3(i)=sum3(i)+temp2(i,j);
     end
 end
 p1=sum(sum2);
 p2=sum(sum3);
 p1=sqrt(p1);
 p2=sqrt(p2);
 denominator=p1 .*  p2;
 val=numerator/denominator;
 end
 