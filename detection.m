function varargout = detection(varargin)
% DETECTION MATLAB code for detection.fig
%      DETECTION, by itself, creates a new DETECTION or raises the existing
%      singleton*.
%
%      H = DETECTION returns the handle to a new DETECTION or the handle to
%      the existing singleton*.
%
%      DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETECTION.M with the given input arguments.
%
%      DETECTION('Property','Value',...) creates a new DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detection

% Last Modified by GUIDE v2.5 20-Jun-2022 16:35:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detection_OpeningFcn, ...
                   'gui_OutputFcn',  @detection_OutputFcn, ...
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


% --- Executes just before detection is made visible.
function detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detection (see VARARGIN)

% Choose default command line output for detection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
clear global

global path_codes
path_codes =cd;

addpath(path_codes)
axes(handles.axes1); cla(handles.axes1); title('');
axes(handles.axes2); cla(handles.axes2); title('');
axes(handles.axes3); cla(handles.axes3); title('');
axes(handles.axes4); cla(handles.axes4); title('');
axes(handles.axes5); cla(handles.axes5); title('');
axes(handles.axes6); cla(handles.axes6); title('');
axes(handles.axes7); cla(handles.axes7); title('');
axes(handles.axes8); cla(handles.axes8); title('');
axes(handles.axes9); cla(handles.axes9); title('');
set(handles.lbl_image_name, 'String', '');
set(handles.lbl_circles, 'String', '');
set(handles.edit1, 'String', '');
set(handles.txt_no_of_circles, 'String', '');
set(handles.txt_tumor_area, 'String', '');
set(handles.tbl_centroid,'Data','');
set(handles.txt_Tumor_Type,'String','');
set(handles.lbl_segmentation_status, 'String', '');
clc
% Show Logo
logo = imread('Logo.png');
axes(handles.axes10)
imshow(logo);






% UIWAIT makes detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_load_image.
function btn_load_image_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% btn_load_image
%% Button Load Image
% cd dataset\detection
axes(handles.axes2); cla(handles.axes2); title('');
axes(handles.axes3); cla(handles.axes3); title('');
axes(handles.axes4); cla(handles.axes4); title('');
axes(handles.axes5); cla(handles.axes5); title('');
axes(handles.axes6); cla(handles.axes6); title('');
axes(handles.axes7); cla(handles.axes7); title('');
axes(handles.axes8); cla(handles.axes8); title('');
axes(handles.axes9); cla(handles.axes9); title('');
set(handles.lbl_image_name, 'String', '');
set(handles.lbl_circles, 'String', '');
set(handles.edit1, 'String', '');
set(handles.txt_no_of_circles, 'String', '');
set(handles.txt_tumor_area, 'String', '');
set(handles.tbl_centroid,'Data','');
set(handles.txt_Tumor_Type,'String','');
set(handles.lbl_segmentation_status, 'String', '');




global filename Selected_Image 
global path_codes
cd C:\LungsCancer\Lungs\detection
[filename, pathname] = uigetfile({'*.*'}, 'Load Image File');
cd(path_codes)


if isequal(filename,0)||isequal(pathname,0)
    warndlg('Failed to Load Image', 'Warning');
else
[~,imagename,~] = fileparts(filename);

set(handles.lbl_image_name, 'String', imagename);
Selected_Image = imread([pathname filename]);
Selected_Image = imresize (Selected_Image,[512,512]);
% Show Input Loaded Image on Axes 1 Location
axes(handles.axes1);
imshow(Selected_Image);
end

% --- Executes on button press in btn_noise_removal.
function btn_noise_removal_Callback(hObject, eventdata, handles)
% hObject    handle to btn_noise_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Noise Removal
global Selected_Image greyscale_Method median_filtering_Image
%Noise Removal Section

if size(Selected_Image,3)==3
greyscale_Method = rgb2gray(Selected_Image); %convert into grayscale
else
greyscale_Method=Selected_Image;
end
median_filtering_Image = customfilter(greyscale_Method); %Uses Noise Removal
axes(handles.axes2);
imshow(median_filtering_Image); %show image 


% --- Executes on button press in btn_binary_image.
function btn_binary_image_Callback(hObject, eventdata, handles)
% hObject    handle to btn_binary_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global median_filtering_Image binary_picture
%% Button Binary Image
%Binary Image Conversion
binary_picture = im2bw(median_filtering_Image, 0.2); %Convert into Black and White
axes(handles.axes3);
imshow(binary_picture); %show image 




% --- Executes on button press in btn_post_processing.
function btn_post_processing_Callback(hObject, eventdata, handles)
% hObject    handle to btn_post_processing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Post Processig
global postOpenImage_1 binary_picture
se1 = strel('disk', 2); %creates a flat, disk-shaped structure,
postOpenImage_1 = imopen(binary_picture, se1);
axes(handles.axes4);
imshow(postOpenImage_1); %show image


% --- Executes on button press in btn_invert_image.
function btn_invert_image_Callback(hObject, eventdata, handles)
% hObject    handle to btn_invert_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Invert Image
global binary_picture postOpenImage_1 postOpenImage_2
global invertedImage_1 invertedImage_2
%Create morphological structuring element
se2 = strel('disk', 8); %creates a flat, disk-shaped structure,
postOpenImage_2 = imopen(binary_picture, se2);

inverted = ones(size(binary_picture));
% inverted= imclearborder(inverted);

%Creates Inverted Picture
invertedImage_1 = inverted - postOpenImage_1;
invertedImage_2 = inverted - postOpenImage_2;
axes(handles.axes5);
imshow(invertedImage_1); %show image

% --- Executes on button press in btn_segmentation.
function btn_segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to btn_segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Segmentation
set(handles.lbl_segmentation_status, 'String', 'Segmentation Started');

global invertedImage_1 invertedImage_2
global segmented final_1 final_2
%% Segmentation


[segmented,final_1,final_2] = fun_segmentation(invertedImage_1,invertedImage_2);

axes(handles.axes6);
imshow(segmented); %show image
set(handles.lbl_segmentation_status, 'String', 'Segmentation Completed');

% --- Executes on button press in btn_Finalize.
function btn_Finalize_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Finalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Dispaly Final Image
%% Button Finalize
global final_1 final_2
axes(handles.axes7);
imshow(final_1); %show image

% --- Executes on button press in btn_find_circles.
function btn_find_circles_Callback(hObject, eventdata, handles)
% hObject    handle to btn_find_circles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Find Circles
%Find Circles within Image using Polarity and Sensitivity
warning('off', 'all')
global final_1 final_2 circle_image 
global centers radii

circle_image = final_1;

[centers,radii] = imfindcircles(circle_image,[1 9],'ObjectPolarity','dark','Sensitivity',0.88);
axes(handles.axes8);
imshow(circle_image); %show image

viscircles(centers,radii,'EdgeColor','r'); % Circles Display Green
no_of_circles =size(centers, 1);

disp(['Numbers of Circles : ',num2str(no_of_circles)]);
set(handles.lbl_circles, 'String', num2str(no_of_circles));



% --- Executes on button press in btn_Plotting.
function btn_Plotting_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Plotting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Plotting
global final_1 final_2 Selected_Image
global centers pre_colour_pic

segment_pic = final_2 - final_1; % Creates Segmented Image
%Creates before Colour Image 
pre_colour_pic = im2bw(medfilt2(mat2gray(segment_pic),[3 3]), 0.6);
axes(handles.axes9);
imshow(Selected_Image)

%Circles Segmented Circles
[B] = bwboundaries(pre_colour_pic,'holes');
hold on
for k  = 1:length(B)
boundary = B{k};
plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
end
hold off;



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over btn_load_image.



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Reset.
function btn_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Reset
axes(handles.axes1); cla(handles.axes1); title('');
axes(handles.axes2); cla(handles.axes2); title('');
axes(handles.axes3); cla(handles.axes3); title('');
axes(handles.axes4); cla(handles.axes4); title('');
axes(handles.axes5); cla(handles.axes5); title('');
axes(handles.axes6); cla(handles.axes6); title('');
axes(handles.axes7); cla(handles.axes7); title('');
axes(handles.axes8); cla(handles.axes8); title('');
axes(handles.axes9); cla(handles.axes9); title('');
set(handles.lbl_image_name, 'String', '');
set(handles.lbl_circles, 'String', '');
set(handles.edit1, 'String', '');
set(handles.txt_no_of_circles, 'String', '');
set(handles.txt_tumor_area, 'String', '');
set(handles.tbl_centroid,'Data','');
set(handles.txt_Tumor_Type,'String','');
set(handles.lbl_segmentation_status, 'String', '');



% --- Executes on button press in btn_exit.
function btn_exit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path_codes
close(detection)
rmpath(path_codes)
clear all;



% --- Executes on button press in btn_Evaluate.
function btn_Evaluate_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Evaluate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Evaluate
global centers radii pre_colour_pic segmented
if size(centers,1)> 1
%     sliderValue = int32(get(handles.slider1, 'Value'));
    
    set(handles.edit1, 'String', 'Yes');
%     set(handles.edit1, 'String', '');
else 
    set(handles.edit1, 'String', 'No');
end
totalarea = sum(sum(segmented));
for i=1:size(centers,1)
area(1,i) = pi*radii(i).^2;

disp(['Circle ', num2str(i), ' Radius = ',num2str(radii(i)), ' Area = ',...
    num2str(area(i))])

end

total_tumor_area=sum(area);
disp(['Total Tumor Area : ',num2str(total_tumor_area)])

effected = (total_tumor_area / totalarea) *100;

disp (['Effected Ratio :' num2str(effected),' % ']);

set(handles.txt_no_of_circles, 'String', num2str(size(centers,1)));
set(handles.txt_tumor_area, 'String', num2str(total_tumor_area));
set(handles.tbl_centroid,'Data',centers);
tbl_centroid.RowName = 'numbered';

if total_tumor_area <= 1000
        set(handles.txt_Tumor_Type,'String','Low');

    elseif (total_tumor_area >= 1000) && (total_tumor_area <=2000)
        set(handles.txt_Tumor_Type,'String','Medium');
    elseif (total_tumor_area >= 2000) && (total_tumor_area <=4500)
        set(handles.txt_Tumor_Type,'String','High');
    else
        set(handles.txt_Tumor_Type,'String','Critical');
    end


% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Home
close(detection)
Home();


% --- Executes on button press in btn_classification.
function btn_classification_Callback(hObject, eventdata, handles)
% hObject    handle to btn_classification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(detection);
classification();
