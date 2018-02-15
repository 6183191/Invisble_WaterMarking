function [Uw1,Vw1,t1,cut1] = wsingularcal(LL2)
%Take the LH1 part and divide them into cells of 8*8
cut1=mat2cell(LL2,16.*ones(1,16),16.*ones(1,16));

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
t1=svd(wdctx1);
end