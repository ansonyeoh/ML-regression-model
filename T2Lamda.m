%% T2Lamda.m
% Computer Based Test 1
% Xiang Yang 16/10/2017
clear all; close all;

%% Load the data of the men's 100 Olympic Games
load olympics.mat
N = size(male100,1);
x = male100(:,1);
t = male100(:,2);
% Rescale x for numerical reasons
x = x - x(1);
x = x./4;

%% Run a cross-validation over model orders
X = [];
testX=[];
K = 5 ;%K-fold CV
sizes = repmat(floor(N/K),1,K);
sizes(end) = sizes(end) + N - sum(sizes);
csizes = [0 cumsum(sizes)];

% Get random test data
order = randperm(N);
testx = x(order); 
testt = t(order);

range = 1;% Set a range for lamda
maxorder= 4;% 1st Order polynomial / change it to 4 for 4th Order Polynomial
r = 0;

% Build the structure of model
for k = 0:maxorder
    X = [X x.^k];
    testX = [testX testx.^k];
end

% Traversal the lamda from 0 to 1 with the accuracy of 10^-6
for lamda = 0:0.00001:range
        for fold=1:K
           
            foldX = X(csizes(fold)+1:csizes(fold+1),:);
            foldt = t(csizes(fold)+1:csizes(fold+1));
            % Set the data of foldX empty on trainX
            % So that trainX contains the all the data apart from the data on
            % foldX
            trainX = X;
            trainX(csizes(fold)+1:csizes(fold+1),:) = [];
            
            traint = t;
            traint(csizes(fold)+1:csizes(fold+1)) = [];
            
            % According to the regularized least squares solution 
            w = inv(trainX' * trainX + N * lamda * eye(size(trainX,2))) * trainX' * traint;
            fold_pred = foldX*w;
            cv_loss(fold,r+1) = mean((fold_pred-foldt).^2);
            ind_pred = testX*w;
            ind_loss(fold,r+1) = mean((ind_pred - testt).^2);
            train_pred = trainX*w;
            train_loss(fold,r+1) = mean((train_pred - traint).^2);
        end
    r = r+1;
end

%% Plot the results
figure(1);
plot(0:0.00001:range,mean(cv_loss,1),'linewidth',2)
xlabel('Lamda');
ylabel('Loss');
title('CV Loss');
