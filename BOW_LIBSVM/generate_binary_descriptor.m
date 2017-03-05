function [ BRLD ] = generate_binary_descriptor( sp,I,lines )
%Generate the binary descriptor of a line
%Input:sp is a 128*4 matrix, each row vector stores a test pair coordinate in
%normalized system; lines is a nl*4 matrix which stores the coordinates of
%two line endpoints; I is the input image, usually the convolutional image
%Output:BRLD is a nl*128 matrix. Each row vector is the descriptor of a
%line.
nl=size(lines,1);                                                           %the number of lines in an image
T=zeros(128,4);                                                             %coordinates in the real image
BRLD=zeros(nl,128);
for l=1:nl
    x1=lines(l,1);
    y1=lines(l,2);
    x2=lines(l,3);
    y2=lines(l,4);
    for i=1:128
        [T(i,1), T(i,2)]=coordinate_transform(sp(i,1),sp(i,2),x1,y1,x2,y2);
        [T(i,3), T(i,4)]=coordinate_transform(sp(i,3),sp(i,4),x1,y1,x2,y2);
    end
    T=round(T);
    for i=1:128
        if T(i,1)<=0
            continue
        end
        if T(i,1)>size(I,2)
            continue
        end
        if T(i,2)<=0
            continue
        end
        if T(i,2)>size(I,1)
            continue
        end
        if T(i,3)<=0
            continue
        end
        if T(i,3)>size(I,2)
            continue
        end
        if T(i,4)<=0
            continue
        end
        if T(i,4)>size(I,1)
            continue
        end
        if I(T(i,2),T(i,1))>=I(T(i,4),T(i,3))
            BRLD(l,i)=1;
        end
        BRLD(l,i)=2^(i-1)*BRLD(l,i);
    end
end



end

