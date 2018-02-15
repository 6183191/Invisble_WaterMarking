%to find the value of alpha
function [alph] =calalpha(quad)
 
HHL1=quad;
for i=1:256
    for j=1:256
        HHL1(i,j)=norm(HHL1(i,j));
        
    end
end
maxi=max(max(HHL1));
mini=min(min(HHL1));
differ=maxi-mini;
for i = 1:256
    for j=1:256
        ke(i,j)=norm(HHL1(i,j)-mini);
    end
end
ke = ke ./ differ;
ke= wblcdf(ke,1,1.5);
alph = mean(mean(ke)) ;
alph  =0.01+alph;
end
