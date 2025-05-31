% %https://www.mathworks.com/help/vision/examples/image-category-classification-using-deep-learning.html
clear all
clc
close all
%% Dataset Paths
mainFolder='F:\Datasets\Lungs\Data\';
trainFolder = fullfile(mainFolder, 'train');
valFolder = fullfile(mainFolder, 'valid');
testFolder = fullfile(mainFolder, 'test');
allfoldernames= struct2table(dir(trainFolder));
for (i=3:height(allfoldernames))
    new(i-2)=allfoldernames.name(i);
end
clear i
categories=new;
imds_train = imageDatastore(fullfile(trainFolder, categories), 'LabelSource','foldernames');
imds_val = imageDatastore(fullfile(valFolder, categories), 'LabelSource','foldernames');
imds_test = imageDatastore(fullfile(testFolder, categories), 'LabelSource','foldernames');


%%

% Find the first instance of an image for each category
%% Pretrained Net AlexNet
net = vgg19();

imr=net.Layers(1, 1).InputSize(:,1);
imc=net.Layers(1, 1).InputSize(:,2);

imds_train.ReadFcn = @(filename)fun_readAndPreprocessImage(filename,imr,imc);
imds_val.ReadFcn = @(filename)fun_readAndPreprocessImage(filename,imr,imc);
imds_test.ReadFcn = @(filename)fun_readAndPreprocessImage(filename,imr,imc);

% [trainingSet, testSet] = splitEachLabel(imds, 0.7, 'random');
% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;

%%
featureLayer = 'fc7';
%featureLayer = 'pool5-drop_7x7_s1';
%%
tic
disp('Training Feature extraction Started');
trainingFeatures = activations(net, imds_train, featureLayer, ...
 'MiniBatchSize', 64, 'OutputAs', 'columns');

disp(['Training Feature Exatraction Took: ', num2str(toc)]);

%%
% Get training labels from the trainingSet
trainingLabels = cellstr(imds_train.Labels);

% Train multiclass SVM classifier using a fast linear solver, and set
% 'ObservationsIn' to 'columns' to match the arrangement used for training
% features.
classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
%%
%%
% Extract test features using the CNN
tic
disp('testing Feature extraction Started');
testFeatures = activations(net, imds_test, featureLayer, ...
 'MiniBatchSize', 64, 'OutputAs', 'columns');
disp(['Testing Feature Exatraction Took: ', num2str(toc)]);
%%
% Pass CNN image features to trained classifier

[predictedLabels,probs]= predict(classifier, testFeatures, 'ObservationsIn', 'columns');

predictedLabels=categorical(predictedLabels);


% Get the known labels
testLabels = imds_test.Labels;

% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);

% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2))

% Display the mean accuracy

% Accuracy 
accuracy = mean(diag(confMat))
%%
%% Getting All results using Customised ConfMat
plotconfusion(testLabels,predictedLabels)

[c_matrix,Result,RefereceResult]= fun_getMatrix(testLabels,predictedLabels,3)

 trainingFeatures =trainingFeatures';
 testFeatures =testFeatures';


%%
features_train=double(trainingFeatures);
labels_train=trainingLabels;
FV_Full=array2table(features_train);
FV_Full.type=labels_train;


%%
x2=testFeatures;
y2=testLabels;
xy2=array2table(x2);
xy2.type=y2;

% cd F:\Study\MS(CS)\Papers\5_object\mat\
%%save model

save('Train_Alex','FV_Full','xy2','net','classifier');


%% Testing 
idx = randperm(numel(imds_test.Files),16);
figure
for i = 1:4
    subplot(2,2,i)
    I = readimage(imds_test,idx(i));
    imshow(I)
    label = predictedLabels(idx(i));
    title(string(label) + " = " + string(imds_test.Labels(idx(i))));
end
