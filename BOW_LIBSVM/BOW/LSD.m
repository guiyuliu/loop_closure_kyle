function [] = LSD( opts )
%find lines in each image using LSD
%   
load(opts.image_names);
nimages=opts.nimages;


for f=1:nimages
    I = rgb2gray(imread([opts.imgpath,'/', image_names{f}]));
    fprintf('Finding lines in the %d th image...\n',f);
    lines = lsd(double(I));                                                 %LSD, lines is a n*5 matrix, n is the number of lines detected
    
    %%get all pixels on each line
    nl = size(lines,1);
    LBP=[];
    for i=1:nl
        if lines(i,5)>=6
            continue;                                                       %skip lines that are too "wide" 
        end
        x=[];y=[];
        x1=lines(i,1);
        y1=lines(i,2);
        x2=lines(i,3);
        y2=lines(i,4);
        m=1;
        L=sqrt((x2-x1)^2+(y2-y1)^2);                                        %length of the line
        k=(y2-y1)/(x2-x1);
        n=-1/k;
        xx=ceil(x1):1:floor(x2);
        yy=k*(xx-x1)+y1;
        yy=round(yy);
%         xx=[xx,xx];
%         yy=[yy-1,yy];
        ind=find(yy>=1&yy<=size(I,1));
        x=xx(ind);
        y=yy(ind);
        if length(x)<=1
            continue;
        end
        
        %%generate MSLD
        for j=1:length(x)
            
        
%         for j=1:length(x)
%             for p=-2:2
%                 if y(j)+p*n<1 || y(j)+p*n>size(I,1) || x(j)<1
%                     continue;
%                 end
%                 if p~=0
%                     if I(round(y(j)+p*n),round(x(j)))>=I(y(j),round(x(j)))
%                         LBP(i,m)=1;
%                     else LBP(i,m)=0;
%                     end
%                     m=m+1;
%                 end
%             end
%         end
%         
%     end
    
   
    mkdir(opts.localdatapathLSD,num2string(f,8));
    image_dir=sprintf('%s/%s/',opts.localdatapathLSD,num2string(f,8));
    save ([image_dir,'/','lines'], 'lines');
    save ([image_dir,'/','LBP'], 'LBP');
    fprintf('The %d th image finished...\n',f);
end
end

