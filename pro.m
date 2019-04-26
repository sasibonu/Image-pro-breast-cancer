function varargout = pro(varargin)
%PRO MATLAB code file for pro.fig
%      PRO, by itself, creates a new PRO or raises the existing
%      singleton*.
%
%      H = PRO returns the handle to a new PRO or the handle to
%      the existing singleton*.
%
%      PRO('Property','Value',...) creates a new PRO using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to pro_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PRO('CALLBACK') and PRO('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PRO.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pro

% Last Modified by GUIDE v2.5 25-Apr-2019 00:22:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pro_OpeningFcn, ...
                   'gui_OutputFcn',  @pro_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before pro is made visible.
function pro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for pro
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pro wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pro_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Image.
function Image_Callback(hObject, eventdata, handles)
% hObject    handle to Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.jpg', 'Pick a Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
    filename=strcat(pathname,filename);
    
    InputImage=imread(filename);
    
    axes(handles.axes1);
    imshow(InputImage);
    
    handles.InputImage=InputImage;
    end
    % Update handles structure
guidata(hObject, handles);



% --- Executes on button press in Amf.
function Amf_Callback(hObject, eventdata, handles)
% hObject    handle to Amf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InputImage=handles.InputImage;
        GrayScaleImage=(InputImage);
               
        NoisyImage=GrayScaleImage;
        NoisyImage=double(GrayScaleImage);
        [R C P]=size(NoisyImage);
        OutImage=zeros(R,C);
        Zmin=[];
        Zmax=[];
        Zmed=[];
        

        for i=1:R
        
            for j=1:C
                       if (i==1 & j==1)


                  % for right top corner[8,7,6]
                        elseif (i==1 & j==C)


                    % for bottom left corner[2,3,4]
                        elseif (i==R & j==1)


                             % for bottom right corner[8,1,2]

                        elseif (i==R & j==C)


                            %for top edge[8,7,6,5,4]

                        elseif (i==1)


                                                    % for right edge[2,1,8,7,6]

                        elseif (i==R)

                                % // for bottom edge[8,1,2,3,4]

                        elseif (j==C)


                                 %// for left edge[2,3,4,5,6]

                        elseif (j==1)





                       else



                                     SR1 = NoisyImage((i-1),(j-1));
                                     SR2 = NoisyImage((i-1),(j));
                                     SR3 = NoisyImage((i-1),(j+1));
                                     SR4 = NoisyImage((i),(j-1));
                                     SR5 = NoisyImage(i,j);
                                     SR6 = NoisyImage((i),(j+1));
                                     SR7 = NoisyImage((i+1),(j-1));
                                     SR8 = NoisyImage((i+1),(j));
                                     SR9 = NoisyImage((i+1)),((j+1));
                                     TempPixel=[SR1,SR2,SR3,SR4,SR5,SR6,SR7,SR8,SR9];
                                     Zxy=NoisyImage(i,j);
                                     Zmin=min(TempPixel);
                                     Zmax=max(TempPixel);
                                     Zmed=median(TempPixel);
                                     A1 = Zmed - Zmin;
                                     A2 = Zmed - Zmax;

                                     if A1 > 0 && A2 < 0

                                          %   go to level B
                                          B1 = Zxy - Zmin;
                                          B2 = Zxy - Zmax;
                                          if B1 > 0 && B2 < 0
                                              PreProcessedImage(i,j)= Zxy;
                                          else
                                              PreProcessedImage(i,j)= Zmed;

                                          end
                                     else

                                         if ((R > 4 && R < R-5) && (C > 4 && C < C-5))

                                         S1 = NoisyImage((i-1),(j-1));
                                         S2 = NoisyImage((i-2),(j-2));
                                         S3 = NoisyImage((i-1),(j));
                                         S4 = NoisyImage((i-2),(j));
                                         S5 = NoisyImage((i-1),(j+1));
                                         S6 = NoisyImage((i-2),(j+2));
                                         S7 = NoisyImage((i),(j-1));
                                         S8 = NoisyImage((i),(j-2));

                                         S9 = NoisyImage(i,j);
                                         S10 = NoisyImage((i),(j+1));
                                         S11 = NoisyImage((i),(j+2));
                                         S12 = NoisyImage((i+1),(j-1));
                                         S13 = NoisyImage((i+2),(j-2));
                                         S14 = NoisyImage((i+1),(j));
                                         S15 = NoisyImage((i+2),(j));
                                         S16 = NoisyImage((i+1)),((j+1));
                                         S17 = NoisyImage((i+2)),((j+2));
                                         TempPixel2=[S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17];
                                         Zmed2=median(TempPixel2);
                                         PreProcessedImage(i,j)= Zmed2;
                                         else

                                         PreProcessedImage(i,j)= Zmed;

                                         end

                                     end         

                  end    

            end
        end
        
        
        
        
        PreProcessedImage3=[]
        PreProcessedImage3(:,:,1)=PreProcessedImage;
        PreProcessedImage3(:,:,2)=PreProcessedImage;
        PreProcessedImage3(:,:,3)=PreProcessedImage;

        PreProcessedImage=PreProcessedImage3;
        PreProcessedImage=uint8(PreProcessedImage);
        axes(handles.axes2);
        imshow(PreProcessedImage,[]);
        handles.PreProcessedImage=PreProcessedImage;
    
    % Update handles structure
guidata(hObject, handles);

warndlg('Process completed'); 
    


% --- Executes on button press in Feature.
function Feature_Callback(hObject, eventdata, handles)
% hObject    handle to Feature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 PreProcessedImage=  handles.PreProcessedImage;

        
        Y=double(PreProcessedImage);
        
        cropped_image = Y;

        K = 3;
        q = 5;
        [segmented_image, class_membership, class_means, bias_field, bias_removed_image, residual_image, initial_means ...
         initial_segment, objective_function] = fcm(cropped_image,q,K)

        axes(handles.axes2);
        imshow(segmented_image,[]);
        handles.segmented_image = segmented_image;
    
        disp('exit');    
    

    % Update handles structure
    guidata(hObject, handles);
warndlg('Process completed'); 

        
