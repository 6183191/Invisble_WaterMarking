
function [create1] = findQuar(oiS1,iS1,alpha,cut1,Uw1,Vw1)
%applying SUV to the matrix dctx(matrix of DC coeff)
l=length(Uw1);
%applying the formula wS=(iS3-iS1)/ alpha
%length1=length(iS1);
wS1=zeros(1,l);
for i=1:l
      wS1(i) = ((oiS1(i) - iS1(i)) / alpha) ;
end
wS1=wS1';

%put the ws value in the diagonals of Sw_new
[r, c]=size(Uw1);
Sw_n1 = zeros(r,c);
for i=1:r
    for j=1:c
        if i == j
            Sw_n1(i,j) = wS1(i);
        end
    end
end
Sw_n1=Sw_n1';           
%inverse of svd to the dctx matrix
inv1= Uw1 * Sw_n1 * Vw1';
%figure(40),imshow(double(wdctx)-double(invw))
create1=cell2mat(cut1);
create1=mat2cell(create1,16.*ones(1,16),16.*ones(1,16));
%putting back the DC coeff after modification
a4=zeros(16,16);
for i = 1:16
    for j = 1:16
        a4(1,1)=inv1(i,j);
        tempp3=create1{i,j};
        tempp3(1,1)=a4(1,1);
        create1{i,j}=tempp3;
    end
end

%applying inverse dct to the matrix
for i=1:16
    for j=1:16
        betbuf4=cell2mat(create1(i,j));
        create1(i,j)=mat2cell(idct2(betbuf4),16,16);
    end
end

%converting cells to matrix
create1=cell2mat(create1);

end