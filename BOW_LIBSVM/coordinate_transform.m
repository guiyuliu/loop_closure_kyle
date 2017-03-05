function [ x,y ] = coordinate_transform( x0,y0,x1,y1,x2,y2 )
%Transform coordinates in normallized system to coordinates in the real
%image.
%   The normalization is done by projecting the original line to the line
%   between (0,0) and (1,0). The input (x0,y0) is the coordinates in normalized
%   system and (x1,y1), (x2,y2) are the two end points of a line in the
%   real image. The output (x,y) are coordinates of (x0,y0) in the real
%   image.
k=(y2-y1)/(x2-x1);
a=atan(k);
l=sqrt((x2-x1)^2+(y2-y1)^2);
A=[x0 y0 1]';
T1=[l 0 0;0 1 0;0 0 1];                                                     %尺度变换
T2=[cos(a) -sin(a) 0;sin(a) cos(a) 0;0 0 1];                                %旋转变换
if x1<=x2
    T3=[1 0 x1;0 1 y1;0 0 1];                                               %平移变换
else
    T3=[1 0 x2;0 1 y2;0 0 1];
end
T=T3*T2*T1;
B=T*A;
x=B(1);
y=B(2);


end

