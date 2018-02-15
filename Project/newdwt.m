
function [breakk] = newdwt(a,b,alpha)
% LL1
%Take the LH1 part and divide them into cells of 8*8
break1=mat2cell(a,8.*ones(1,32),8.*ones(1,32));

%applying DCT to every 8*8 block
for i=1:32
    for j=1:32
        betbuf=cell2mat(break1(i,j));
        break1(i,j)=mat2cell(dct2(betbuf),8,8);
    end
end


%collecting the DC coefficients from every 8*8 block
for i = 1:32
    for j = 1:32
        a=cell2mat(break1(i,j));
        dctx1(i,j)=a(1,1);
    end
end

%applying SUV to the matrix dctx(matrix of DC coeff)
[U1,S1,V1] = svd(dctx1);
iS1= svd(dctx1);


% LL2
    
%Take the LH1 part and divide them into cells of 8*8
cut1=mat2cell(b,16.*ones(1,16),16.*ones(1,16));
%applying DCT to every 8*8 block
for i=1:16
    for j=1:16
        betbuf2=cell2mat(cut1(i,j));
        cut1(i,j)=mat2cell(dct2(betbuf2),16,16);
    end
end
%collecting the DC coefficients from every 8*8 block
for i = 1:16
    for j = 1:16
        a1=cut1{i,j};
        wdctx1(i,j)=a1(1,1);
    end
end
[Uw1,Sw1,Vw1] = svd(wdctx1);

%to get all the singular values of wdctx
iwS1=svd(wdctx1);
leng=length(iwS1);
full_leng=length(iS1);
%applying the formula S1=S1+ alpha *Sww 
for i=1:full_leng
        
     if i <= leng
        iSnew1(i)=iS1(i) + (iwS1(i) .* alpha );
    else 
        iSnew1(i)=iS1(i);
     end
end

iSnew1=iSnew1';
%put the iS1 value in the diagonals of S1
[r,c] = size(S1);
S1_n=zeros(r,c);
for i=1:r
    for j=1:c
        if i == j 
            S1_n(i,i)=iSnew1(i);
        end
    end
end
invdctx1= U1 * S1_n * V1';


%putting back the DC coeff after modification
for i = 1:32
    for j = 1:32
        an(1,1)=invdctx1(i,j);
        tempp=break1{i,j};
        tempp(1,1)=an(1,1);
        break1{i,j}=tempp;
    end
end

%applying inverse dct to the matrix
for i=1:32
    for j=1:32
        betbuf=cell2mat(break1(i,j));
        break1(i,j)=mat2cell(idct2(betbuf),8,8);
    end
end

%converting cells to matrix
breakk=cell2mat(break1);
end