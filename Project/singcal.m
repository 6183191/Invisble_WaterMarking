function [iS1]=singcal(a)
% LL1
%Take the LH1 part and divide them into cells of 8*8
breakk1=mat2cell(a,8.*ones(1,32),8.*ones(1,32));

%applying DCT to every 4*4 block
for i=1:32
    for j=1:32
        betbuf=cell2mat(breakk1(i,j));
        breakk1(i,j)=mat2cell(dct2(betbuf),8,8);
    end
end


%collecting the DC coefficients from every 4*4 block
for i = 1:32
    for j = 1:32
        a=cell2mat(breakk1(i,j));
        dctx1(i,j)=a(1,1);
    end
end

%applying SUV to the matrix dctx(matrix of DC coeff)
iS1= svd(dctx1);
end