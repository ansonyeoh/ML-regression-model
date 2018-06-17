%%
clear all;clc;
%%
x1=[-4 1;-5 2;-3 3;-2.5 4.5;-4 5];
% data for class 1
x2=[3 1;3.5 0;4 0.5;4 -1;3.5 -1];
% data for class 2
t1=[1;1;1;1;1]; 
% targets of class 1
t2=[2;2;2;2;2]; 
% targets of class 2
xnew = [-2 2]; 
% new point to be determined
%%
m1=mean(x1); 
% mean of class 1
cv1=cov(x1,1); 
% covariance of class 1
m2=mean(x2); 
% mean of class 2
cv2=cov(x2,1); 
% covariance of class 2
%%
pc1 = 0.5; 
% prior class 1
pc2 = 0.5; 
% prior class 2
%%
ccl1 = mvnpdf(xnew, m1, cv1); 
% class conditional likelihood for class 1
ccl2 = mvnpdf(xnew, m2, cv2); 
% class conditional likelihood for class 2
%%
posterior1 = ccl1*pc1; 
% posterior for class 1
posterior2 = ccl2*pc2; 
% posterior for class 2
%%
prob1 = posterior1 / (posterior1+posterior2); 
% probability for class 1
prob2 = posterior2 / (posterior1+posterior2); 
% probability for class 2