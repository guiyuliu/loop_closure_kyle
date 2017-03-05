# loop_closure_kyle
this is the loop closure testing for BRLD/SIFT by Shiwei Zhuang
This program is all  in  matlab
###1.Open the directory “labels” 
 - open ini.m,change the path
    pre_data_path='**E:\loop_closure_kyle**\BOW_LIBSVM\images' to your
    own path
 - run prepare_training.m
 - then run prepare_testing .m

###2.Go back to the main directory 

 - open ini.m  (this ini.m is different from the former one),change the
   path "rootpath='**E:\loop_closure_kyle**\BOW_LIBSVM\'" to your own path;
 - run  main.m, then you can see the matching results 

if there is an error "未定义函数或变量 'pg_opts'", change your matlab path to  the main directory  BOW_LIBSVM
###3.This version is  for BRLD testing , the binary robust line descriptor 
if you want to see the results of SIFT, run the code which is annotated in main.m


##各个函数说明
###ini初始化：
规定pg_opts的各种路径
创建文件夹，data/local和global
Local:BRLD和SIFT两个文件夹，用于存储每张图片的描述子
Global:用来存储一些全局flag
##GenerateBRLDdescriptors
生成BRLD的描述子,存储在data/local/BRLD的每个文件夹里
**flag**：data/global/desBRLD_settings，标志BRLD是否生成
**如果要添加训练/测试图片，改变后将desBRLD_settings.mat移除**，修改循环变量，就可以为新添加的图片生成描述子
error：lsd无法调用，重新编译lsd，见文件***lsd在matlab中的编译及使用***

###CalculateBRLDDictionary
通过k-means聚类的方法，用training中的图片来生成vocabulary
600个聚类中心,是一个600x128
结果Save到data/global/BRLD_dictinary.mat   
训练照片所有线条描述子的聚类中心就是词典中的词汇
**flag**：BRLD_features_settings

##do_assignment
分配tf-idf权重，即计算每张图片的BOW向量
**flag**：BOW_BRLD_settings
如果添加了新图片，要生成bow向量，把flag从global文件夹里移除，
##do_index
找到测试图像和训练图像之间的相似性，并获得最相似的k个图像
计算相似性用的是subspace函数，即BOW之间向量的夹角
