function [] = GenerateBrldDescriptors( opts,descriptor_opts )

fprintf('Building BRLD descriptors...\n\n');

descriptor_flag=1;
try
    descriptor_opts2=getfield(load([opts.globaldatapath,'/',descriptor_opts.name,'_settings']),'descriptor_opts');
    if(isequal(descriptor_opts,descriptor_opts2))
        descriptor_flag=0;
        display('descriptor has already been computed for this settings');
    else
        display('Overwriting descriptor with same name, but other descriptor settings !!!!!!!!!!');
    end
end

if(descriptor_flag)
    
    load(opts.image_names);
    nimages=opts.nimages;
    load('sp.mat');
    subwindow=ones(5)/25;
    
    for f=1:nimages
        I=imread([opts.imgpath,'/',image_names{f}]);
        I=double(rgb2gray(I));
        [hgt,wid]=size(I);
        lines=lsd(I);
        II=conv2(I,subwindow,'same');
        BRLD=generate_binary_descriptor(sp,II,lines);
        
        features.data=BRLD;
        features.M=20;
        features.W=40;
        features.wid=wid;
        features.hgt=hgt;
        features.patchSize=25;
        
        
        mkdir(opts.localdatapathBRLD,num2string(f,8));
        image_dir=sprintf('%s/%s/',opts.localdatapathBRLD,num2string(f,8)); % location descriptor
        save ([image_dir,'/','BRLD_features'], 'features');           % save the descriptors
        
        fprintf('The %d th image finished...\n',f);
    end
    save ([opts.globaldatapath,'/',descriptor_opts.name,'_settings'],'descriptor_opts');
end

end

