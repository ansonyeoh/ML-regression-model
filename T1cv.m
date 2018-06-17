%% T1cv.m
% Computer Based Test 1
% Xiang Yang 16/10/2017
clear all; close all;

%% Load the male 400 Olympic data
load olympics.mat
N = size(male400,1);
x = male400(:,1);
t = male400(:,2);
% Rescale x for numerical reasons
x = x - x(1);
x = x./4;

%% Run a cross-validation over model orders
maxorder = 4;
X = [];
testX = [];
K = 10 %K-fold CV
sizes = repmat(floor(N/K),1,K);
sizes(end) = sizes(end) + N - sum(sizes);
csizes = [0 cumsum(sizes)];

% Get random test data
order = randperm(N);
testx = x(order); 
testt = t(order);

for k = 0:maxorder
    X = [X x.^k];
    testX = [testX testx.^k]; 
    for fold = 1:K
        % Partition the data
        % foldX contains the data for just one fold
        % trainX contains all other data
        
        foldX = X(csizes(fold)+1:csizes(fold+1),:);
        foldt = t(csizes(fold)+1:csizes(fold+1));
        % Set the data of foldX empty on trainX
        % So that trainX contains the all the data apart from the data on
        % foldX
        trainX = X;
        trainX(csizes(fold)+1:csizes(fold+1),:) = [];
        % So does the traint 
        traint = t;
        traint(csizes(fold)+1:csizes(fold+1)) = [];
        
        % Using the training data to get estimated w
        w = inv(trainX'*trainX)*trainX'*traint;
        fold_pred = foldX*w; % Predicted cv t = foldX * w
        cv_loss(fold,k+1) = mean((fold_pred-foldt).^2);% Put the cross validation loss of each fold onto the cv_loss
        
        ind_pred = testX*w; % Predicted independent test t = testX * w
        ind_loss(fold,k+1) = mean((ind_pred - testt).^2); % Put the independent test loss of each fold onto the ind_loss
        
        train_pred = trainX*w; % Predicted train t = tarinX * w
        train_loss(fold,k+1) = mean((train_pred - traint).^2);% Put the train loss of each fold onto the train_loss
    end
end

%% Plot the results
figure(1);
subplot(131)
plot(0:maxorder,mean(cv_loss,1),'linewidth',2)
xlabel('Model Order');
ylabel('Loss');
title('CV Loss');
subplot(132)
plot(0:maxorder,mean(train_loss,1),'linewidth',2)
xlabel('Model Order');
ylabel('Loss');
title('Train Loss');
subplot(133)
plot(0:maxorder,mean(ind_loss,1),'linewidth',2)
xlabel('Model Order');
ylabel('Loss');
title('Independent Test Loss')