%% T1poly.m
% Computer Based Test 1
% Xiang Yang 16/10/2017
clear all; close all;
%% Load the Olympic men¡¯s 400m data
load olympics.mat
x = male400(:,1);
t = male400(:,2);
% Rescale x for numerical reasons
x = x - x(1);
x = x./4;
%% Linear Model 
plotx = [x(1)-2:0.01:x(end)+2]';
X = [];
plotX = [];
% Build the structure linear function for both X and plotX
for k = 0:1 %Linear model
    X = [X x.^k];
    plotX = [plotX plotx.^k];
end
% Estimated w
w = inv(X'*X)*X'*t;
% Plot the model
figure(1);hold off
figure(1);hold off
plot(x,t,'bo','markersize',10); % Mark the data points
xlabel('Olympic number (note, not year!)');
ylabel('Winning time');
hold on
plot(plotx,plotX*w,'r','linewidth',2) % Model: t=plotX*w and plot the pattern of the LINEAR model

%% Quadratic model 
plotx = [x(1)-2:0.01:x(end)+2]';
X = [];
plotX = [];
% Build the structure quadratic function for both X and plotX
for k = 0:2 % 2nd order polynomial
    X = [X x.^k];
    plotX = [plotX plotx.^k];
end
% Estimated w 
w = inv(X'*X)*X'*t;
% Plot the model
figure(2);hold off
figure(2);hold off
plot(x,t,'bo','markersize',10); % Mark the data points
xlabel('Olympic number (note, not year!)');
ylabel('Winning time');
hold on
plot(plotx,plotX*w,'r','linewidth',2) % Model: t=plotX*w and plot the pattern of the QUADRATIC model
%% Cubic Model 
plotx = [x(1)-2:0.01:x(end)+2]';
X = [];
plotX = [];
% Build the structure cubic function for both X and plotX
for k = 0:3 % 3rd Order Polynomial
    X = [X x.^k];
    plotX = [plotX plotx.^k];
end
% Estimated w 
w = inv(X'*X)*X'*t;
% Plot the model
figure(3);hold off
figure(3);hold off
plot(x,t,'bo','markersize',10);% Mark the data points
xlabel('Olympic number (note, not year!)');
ylabel('Winning time');
hold on
plot(plotx,plotX*w,'r','linewidth',2) % Model: t=plotX*w and plot the pattern of the CUBIC model
%% Quartic Model
plotx = [x(1)-2:0.01:x(end)+2]';
X = [];
plotX = [];
% Build the structure quartic function for both X and plotX
for k = 0:4
    X = [X x.^k];
    disp(X);
    plotX = [plotX plotx.^k];
end
% Estimated w 
w = inv(X'*X)*X'*t;
% Plot the model
figure(4);hold off
figure(4);hold off
plot(x,t,'bo','markersize',10);% Mark the data points
xlabel('Olympic number (note, not year!)');
ylabel('Winning time');
hold on
plot(plotx,plotX*w,'r','linewidth',2) % Model: t=plotX*w and plot the pattern of the QUARTIC model