clear pg_opts
rootpath='C:\Users\lgy\Desktop\loop_closure_kyle\BOW_LIBSVM\';

%%
%addpath libsvm;
addpath BOW;

%% change these paths to point to the image, data and label location
images_set=strcat(rootpath,'images');
data=strcat(rootpath,'data');
labels=strcat(rootpath,'labels');

%%
pg_opts.imgpath=images_set; % image path
pg_opts.datapath=data;
pg_opts.labelspath=labels;

%%
% local and global data paths
pg_opts.localdatapathSIFT=sprintf('%s/local/SIFT',pg_opts.datapath);
pg_opts.localdatapathBRLD=sprintf('%s/local/BRLD',pg_opts.datapath);
pg_opts.globaldatapath=sprintf('%s/global',pg_opts.datapath);

% initialize the training set
pg_opts.trainset=sprintf('%s/trainset.mat',pg_opts.labelspath);
% initialize the test set
pg_opts.testset=sprintf('%s/testset.mat',pg_opts.labelspath);
% initialize the labels
%pg_opts.labels=sprintf('%s/labels.mat',pg_opts.labelspath);
% initialize the image names
pg_opts.image_names=sprintf('%s/image_names.mat',pg_opts.labelspath);

% Classes
%pg_opts.classes = load([pg_opts.labelspath,'/classes.mat']);
%pg_opts.classes = pg_opts.classes.classes;
%pg_opts.nclasses = length(pg_opts.classes);

%load(sprintf('%s',pg_opts.labels));
%pg_opts.nimages = size(labels,1);

load(pg_opts.trainset);
load(pg_opts.testset);
pg_opts.ntraning = length(find(trainset==1));
pg_opts.ntesting = length(find(testset==1));
pg_opts.nimages = pg_opts.ntraning+pg_opts.ntesting;

%% creat the directory to save data 
MakeDataDirectory(pg_opts);
