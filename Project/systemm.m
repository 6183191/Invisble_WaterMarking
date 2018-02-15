arr=zeros(4,3);  
for ki=1:4    
      jj=1;
      pic={'pepper.tiff','lake.tiff','house.tiff','lena.bmp'};
      fprintf('image is %');
      pic{ki}
      [alpha]=encode(pic{ki});
      fprintf('alpha= %f\n',alpha);
      arr(ki,jj+2)=alpha;
      clear alpha;
     %clearvars -except ki j psnr ncc alpha arr pic jj;
      noises();
     %clearvars -except ki j psnr ncc alpha arr pic jj;
     psnr=pcheck(pic{ki});
     arr(ki,jj)=psnr;
     fprintf('psnr =%f\n',psnr);
     clear psnr;
     %clearvars -except ki j psnr ncc alpha arr pic;
     decode(pic{ki});
     %clearvars -except ki j psnr ncc alpha arr pic;
     ncc=ncc();
     fprintf('ncc= %f\n',ncc);
     arr(ki,jj+1)=ncc;
     clear ncc;
   %imagge1=pic{ki};
   %imagge1=strrep(imagge1,'.tiff','/');
   %imagge1=strrep(imagge1,'.bmp','/');
   %name2=strcat('./results/output/',imagge1,'attacks/imadjust/');
   %name1=name2;
   %name1=strcat(name1,'output2.tif');
   
   %copyfile('output2.tif',name1);
   %name3=strcat(name2,'construct_watermark.tif');
   %copyfile('construct_watermark.tif',name3);
   
   delete('output2.tif');
   delete('output1.tif');
    
 delete('construct_watermark.tif');
end

xlswrite('results/rr.xlsx',arr);
   close all