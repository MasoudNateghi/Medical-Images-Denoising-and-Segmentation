clear; close all; clc; 
cd Snake_GVF
I = im2double(imread("example.png"));
cd Snake_GVF
figure, imshow(I);
% [y,x] = getpts;
x=[96 51 98 202 272 280 182];
y=[63 147 242 262 211 97 59];
% Make an array with the clicked coordinates
P=[x(:), y(:)];
% Start Snake Process
Options=struct;
Options.Verbose=true;
Options.Iterations=400;
Options.Kappa=4;
Options.Alpha=0.1;
Options.Beta=0.1;
Options.Delta=-0.1;
[O,J]=Snake2D(I,P,Options);
sgtitle("Basic Snake", "interpreter", "latex")
% Show the result
Irgb(:,:,1)=I;
Irgb(:,:,2)=I;
Irgb(:,:,3)=J;
figure, imshow(Irgb,[]); 
hold on; plot([O(:,2);O(1,2)],[O(:,1);O(1,1)]);
sgtitle("Basic Snake", "interpreter", "latex")
% Start GVF Process
Options=struct;
Options.Verbose=true;
Options.Iterations=600;
Options.Wedge=2;
Options.Wline=0;
Options.Wterm=0;
Options.Kappa=4;
Options.Sigma1=8;
Options.Sigma2=8;
Options.Alpha=0.1;
Options.Beta=0.1;
Options.Mu=0.2;
Options.Delta=-0.1;
Options.GIterations=600;
[O,J]=Snake2D(I,P,Options);
sgtitle("GVF", "interpreter", "latex")
% Show the result
Irgb(:,:,1)=I;
Irgb(:,:,2)=I;
Irgb(:,:,3)=J;
figure, imshow(Irgb,[]); 
hold on; plot([O(:,2);O(1,2)],[O(:,1);O(1,1)]);
sgtitle("GVF", "interpreter", "latex")
cd ..\..