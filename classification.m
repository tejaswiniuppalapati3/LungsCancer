function varargout = classification(varargin)
% CLASSIFICATION MATLAB code for classification.fig
%      CLASSIFICATION, by itself, creates a new CLASSIFICATION or raises the existing
%      singleton*.
%
%      H = CLASSIFICATION returns the handle to a new CLASSIFICATION or the handle to
%      the existing singleton*.
%
%      CLASSIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLASSIFICATION.M with the given input arguments.
%
%      CLASSIFICATION('Property','Value',...) creates a new CLASSIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before classification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to classification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help classification

% Last Modified by GUIDE v2.5 20-Jun-2022 19:07:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @classification_OpeningFcn, ...
                   'gui_OutputFcn',  @classification_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before classification is made visible.
function classification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to classification (see VARARGIN)

% Choose default command line output for classification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% Show Logo
logo = imread('Logo.png');
axes(handles.axes1)
imshow(logo);
set(handles.btn_load_dataset,'string','Load Dataset')
set(handles.btn_load_dataset,'ForegroundColor','Black')
clear global
clc
set(handles.txt_batch_size,'string','-');
set(handles.txt_output_layer,'string','-');
set(handles.txt_lbl_selected_net,'string','-');
set(handles.txt_total_layers,'string','-');

set(handles.txt_time_load_dataset,'string','-');
set(handles.txt_time_training_features,'string','-');
set(handles.txt_time_train_classifier,'string','-');
set(handles.txt_time_test_features,'string','-');
set(handles.txt_time_performance_measures,'string','-');


set(handles.txt_Accuracy,'string','-');
set(handles.txt_Error,'string','-');
set(handles.txt_Sensitivity,'string','-');
set(handles.txt_Specificity,'string','-');
set(handles.txt_Precision,'string','-');
set(handles.txt_FPR,'string','-');
set(handles.txt_F1_score,'string','-');


set(handles.btn_performance_evaluation,'string','Evaluate Performance');
set(handles.btn_extract_test_features,'string','Extract Test Features');
set(handles.btn_train_classifier,'string','Train Classifier');
set(handles.btn_start_training,'string','Extract Train Features');




% UIWAIT makes classification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = classification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Home Page Call
set(handles.btn_load_dataset,'string','Load Dataset')
set(handles.btn_load_dataset,'ForegroundColor','Black')
close(classification)
Home();


% --- Executes on button press in btn_detection.
function btn_detection_Callback(hObject, eventdata, handles)
% hObject    handle to btn_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Detection Page Call 
set(handles.btn_load_dataset,'string','Load Dataset')
set(handles.btn_load_dataset,'ForegroundColor','Black')
close(classification)
detection();


% --- Executes on button press in btn_load_dataset.
function btn_load_dataset_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Load Dataset
global imds_train imds_test imds_val
global mainFolder trainFolder testFolder valFolder categories
tic
mainFolder='D:\LungsCancer\Lungs\DS\';
trainFolder = fullfile(mainFolder, 'train');
valFolder = fullfile(mainFolder, 'valid');
testFolder = fullfile(mainFolder, 'test');
allfoldernames= struct2table(dir(trainFolder));
disp(trainFolder)
for (i=3:height(allfoldernames))
    new(i-2)=allfoldernames.name(i);
end
clear i
categories=new;
imds_train = imageDatastore(fullfile(trainFolder, categories), 'LabelSource','foldernames');
imds_val = imageDatastore(fullfile(valFolder, categories), 'LabelSource','foldernames');
imds_test = imageDatastore(fullfile(testFolder, categories), 'LabelSource','foldernames');

tbl_train = countEachLabel(imds_train);
tbl_val = countEachLabel(imds_val);
tbl_test = countEachLabel(imds_test);
% % %  Class Names 
set(handles.txt_class1,'string',tbl_train.Label(1))
set(handles.txt_class2,'string',tbl_train.Label(2))
set(handles.txt_class3,'string',tbl_train.Label(3))
set(handles.txt_class4,'string',tbl_train.Label(4))

% % %  No of Images
set(handles.txt_train1,'string',tbl_train.Count(1))
set(handles.txt_train2,'string',tbl_train.Count(2))
set(handles.txt_train3,'string',tbl_train.Count(3))
set(handles.txt_train4,'string',tbl_train.Count(4))

set(handles.txt_val1,'string',tbl_val.Count(1))
set(handles.txt_val2,'string',tbl_val.Count(2))
set(handles.txt_val3,'string',tbl_val.Count(3))
set(handles.txt_val4,'string',tbl_val.Count(4))

set(handles.txt_test1,'string',tbl_test.Count(1))
set(handles.txt_test2,'string',tbl_test.Count(2))
set(handles.txt_test3,'string',tbl_test.Count(3))
set(handles.txt_test4,'string',tbl_test.Count(4))


set(handles.btn_load_dataset,'string','Dataset Loaded')
set(handles.btn_load_dataset,'ForegroundColor','Green')

set(handles.txt_time_load_dataset,'string',num2str(toc));


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_exit.
function btn_exit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


% --- Executes on selection change in select_net_type.
function select_net_type_Callback(hObject, eventdata, handles)
% hObject    handle to select_net_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_net_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_net_type
global loaded_net net_type total_layers
allItems = handles.select_net_type.String;     % A cell array of all strings in the popup.
selectedIndex = handles.select_net_type.Value; % An integer saying which item has been selected.
net_type = allItems{selectedIndex};  % The one, single string which was selected.
net_type=lower(net_type);

% loaded_net = eval(net_type);

if strcmp(net_type,'vgg19') 
    load('net_vgg19.mat');
elseif strcmp(net_type,'alexnet') 
    load('net_alexnet.mat');
elseif strcmp(net_type,'inceptionv3') 
    load('net_inception.mat');
end

set(handles.txt_lbl_selected_net,'string',net_type);

total_layers = size(loaded_net.Layers,1);
set(handles.txt_total_layers,'string',num2str(total_layers));

% --- Executes during object creation, after setting all properties.
function select_net_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_net_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in select_output_layer.
function select_output_layer_Callback(hObject, eventdata, handles)
% hObject    handle to select_output_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_output_layer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_output_layer
%% Select Output Layer CallBack
global output_layer
allItems = handles.select_output_layer.String;     % A cell array of all strings in the popup.
selectedIndex = handles.select_output_layer.Value; % An integer saying which item has been selected.
output_layer = allItems{selectedIndex};  % The one, single string which was selected.
output_layer=lower(output_layer);
% loaded_net = eval(output_layer);

set(handles.txt_output_layer,'string',output_layer);



% --- Executes during object creation, after setting all properties.
function select_output_layer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_output_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in select_batch_size.
function select_batch_size_Callback(hObject, eventdata, handles)
% hObject    handle to select_batch_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_batch_size contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_batch_size
%% Select Batch Size 
global batch_size
allItems = handles.select_batch_size.String;     % A cell array of all strings in the popup.
selectedIndex = handles.select_batch_size.Value; % An integer saying which item has been selected.
batch_size = allItems{selectedIndex};  % The one, single string which was selected.
% output_layer=lower(output_layer);
% loaded_net = eval(output_layer);

set(handles.txt_batch_size,'string',batch_size);


% --- Executes during object creation, after setting all properties.
function select_batch_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_batch_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_start_training.
function btn_start_training_Callback(hObject, eventdata, handles)
% hObject    handle to btn_start_training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Start Training.
global loaded_net 

if size(loaded_net,1)==1
global net_type total_layers output_layer batch_size 
global imds_train imds_val imds_test trainingFeatures


    imr=loaded_net.Layers(1, 1).InputSize(:,1);
    imc=loaded_net.Layers(1, 1).InputSize(:,2);
%% Read and Process Images to resize images according to Neural Network
imds_train.ReadFcn = @(filename)fun_readAndPreprocessImage(filename,imr,imc);
imds_val.ReadFcn = @(filename)fun_readAndPreprocessImage(filename,imr,imc);
imds_test.ReadFcn = @(filename)fun_readAndPreprocessImage(filename,imr,imc);

set(handles.txt_batch_size,'string',batch_size);
set(handles.txt_output_layer,'string',output_layer);
set(handles.txt_lbl_selected_net,'string',net_type);
set(handles.txt_total_layers,'string',num2str(total_layers));

tic

set(handles.btn_start_training,'string','Extraction Started');
pause(0.05)
% disp('Training Feature extraction Started');
    trainingFeatures = activations(loaded_net, imds_train, output_layer, ...
 'MiniBatchSize', str2double(batch_size), 'OutputAs', 'columns');

set(handles.btn_start_training,'string','Feature Extracted');
set(handles.txt_time_training_features,'string',num2str(toc));

else
    f = errordlg('Neural Network Not Loaded','Error');
end


% --- Executes on button press in btn_train_classifier.
function btn_train_classifier_Callback(hObject, eventdata, handles)
% hObject    handle to btn_train_classifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global trainingFeatures
if size(trainingFeatures,1)>1
    global imds_train trainingLabels classifier
    tic
    
    trainingLabels = cellstr(imds_train.Labels);

% Train multiclass SVM classifier using a fast linear solver, and set
% 'ObservationsIn' to 'columns' to match the arrangement used for training
% features.
set(handles.btn_train_classifier,'string','Training Started');
pause(0.01)
classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
set(handles.btn_train_classifier,'string','Classifier Trained');
set(handles.txt_time_train_classifier,'string',num2str(toc));

disp(['Classifier Trained in :' num2str(toc)]);

else
    f = errordlg('Features Not Extracted','Error');
end


% --- Executes on button press in btn_extract_test_features.
function btn_extract_test_features_Callback(hObject, eventdata, handles)
% hObject    handle to btn_extract_test_features (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Extract Test Features

global loaded_net
if size(loaded_net,1)==1
    global imds_test loaded_net 
    global output_layer batch_size testFeatures
    
% Train multiclass SVM classifier using a fast linear solver, and set
% 'ObservationsIn' to 'columns' to match the arrangement used for training
% features.
tic
set(handles.btn_extract_test_features,'string','Extraction Started');
testFeatures = activations(loaded_net, imds_test, output_layer, ...
 'MiniBatchSize', str2double(batch_size), 'OutputAs', 'columns');

set(handles.btn_extract_test_features,'string','Feature Extracted');
disp(['Testing Feature Exatraction Took: ', num2str(toc)]);
set(handles.txt_time_test_features,'string',num2str(toc));

else
     f = errordlg('Neural Network Not Loaded','Error');
end

% --- Executes on button press in btn_performance_evaluation.
function btn_performance_evaluation_Callback(hObject, eventdata, handles)
% hObject    handle to btn_performance_evaluation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Performance Evaluation

global testFeatures classifier

if size(testFeatures,1)>1 && size(classifier,1)==1
global imds_test confMat accuracy predictedLabels
tic

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
figure(2),
plotconfusion(testLabels,predictedLabels),title('Confusion Matrix');

[c_matrix,Result,RefereceResult]= fun_getMatrix(testLabels,predictedLabels,3)

set(handles.txt_Accuracy,'string',num2str(Result.Accuracy));
set(handles.txt_Error,'string',num2str(Result.Error));
set(handles.txt_Sensitivity,'string',num2str(Result.Sensitivity));
set(handles.txt_Specificity,'string',num2str(Result.Specificity));
set(handles.txt_Precision,'string',num2str(Result.Precision));
set(handles.txt_FPR,'string',num2str(Result.FalsePositiveRate));
set(handles.txt_F1_score,'string',num2str(Result.F1_score));

set(handles.btn_performance_evaluation,'string','Performance Evaluated');
set(handles.txt_time_performance_measures,'string',num2str(toc));

else
    f = errordlg('Classifier Not Trained & Test Features Not Extracted','Error');
end


% --- Executes on button press in btn_classification_results.
function btn_classification_results_Callback(hObject, eventdata, handles)
% hObject    handle to btn_classification_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Show Classification
%% Testing 
global imds_test predictedLabels
if size(predictedLabels,1)>1

idx = randperm(numel(imds_test.Files),9);
figure(3)
    for i = 1:9
        subplot(3,3,i)
        I = readimage(imds_test,idx(i));
        imshow(I)
        label = predictedLabels(idx(i));
        actual_label =imds_test.Labels(idx(i));

        if label == actual_label
          title([' \color{black}' string(label) + " = " + string(imds_test.Labels(idx(i)))])
        else
             title([string(label) + ' = \color{red}'  + string(imds_test.Labels(idx(i)))])
        end

    end
else
      f = errordlg('Classifier Not Trained & Test Features Not Extracted','Error');
end
 
