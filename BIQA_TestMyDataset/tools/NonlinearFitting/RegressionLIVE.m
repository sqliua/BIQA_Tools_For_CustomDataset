function corr_coef = RegreesionLIVE(objectiveValues,mos)
%this script is used to calculate the pearson linear correlation
%coefficient and root mean sqaured error after regression

%get the objective scores computed by the IQA metric and the subjective
%scores provided by the dataset
% matData = load('VSIOnLIVE.mat');
% VSIOnLIVE = matData.VSIOnLIVE;
% objectiveValues = VSIOnLIVE(:,1);
% mos = VSIOnLIVE(:,2);

%plot objective-subjective score pairs
% p = plot(objectiveValues,mos,'+');
% set(p,'Color','blue','LineWidth',1);

%initialize the parameters used by the nonlinear fitting function
beta(1) = max(mos);
beta(2) = min(mos);
beta(3) = mean(objectiveValues);
beta(4) = 0.1;
beta(5) = 40;

%fitting a curve using the data
[bayta ehat,J] = nlinfit(objectiveValues,mos,@logistic,beta);
%given a ssim value, predict the correspoing mos (ypre) using the fitted curve
[ypre junk] = nlpredci(@logistic,objectiveValues,bayta,ehat,J);

RMSE = sqrt(sum((ypre - mos).^2) / length(mos));%root meas squared error
corr_coef = corr(mos, ypre, 'type','Pearson'); %pearson linear coefficient

%draw the fitted curve
% t = min(objectiveValues):0.01:max(objectiveValues);
% [ypre junk] = nlpredci(@logistic,t,bayta,ehat,J);
% hold on;
% p = plot(t,ypre);
% set(p,'Color','black','LineWidth',2);
% legend('Images in LIVE','Curve fitted with logistic function', 'Location','NorthEast');
% xlabel('Objective score by VSI');
% ylabel('MOS');
