function [] = do_index(opts,assignment_opts,k)
%Find the similarity between test images and training images and get the
%most similar k images

load(opts.trainset);
load(opts.testset);
load([opts.globaldatapath,'/',assignment_opts.name]);

train_data = BOW(:,trainset);
test_data = BOW(:,testset);

n_test = size(test_data,2);
n_train = size(train_data,2);

simi=zeros(n_train,n_test);
for i=1:n_test
    for j=1:n_train
        simi(j,i)=subspace(test_data(:,i),train_data(:,j));
    end
end

[rank,candidates]=sort(simi);


load(opts.image_names);

for p=1:n_test
    figure;
    subplot(2,k,1);
    imshow(imread([opts.imgpath,'/', image_names{n_train+p}]));
    for q=1:k
       subplot(2,k,q+k);
       imshow(imread([opts.imgpath,'/', image_names{candidates(q,p)}]));
    end
end


end

