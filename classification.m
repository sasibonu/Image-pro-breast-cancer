data1 = [];
% data1 holds the data of Benign images(training data).
 
data2 = [];

% data2 holds the data of malignant or cancerous images(training data).

data3 = [];

% data3 holds the data of Benign images(testing data).

data4 = [];

% data4 holds the data of malignant or cancerous images(training data).

degree = 25;

% The degree of the poly hypothesis is 15.

for a = 1:4
    
    % 2 iterations - 1 for benign and 2 - for cancerous.
    
    if a == 1
        
        % Selecting the folder which contains the Benign images for training.
        
        folder_name = uigetdir('C:\Users\DELL\Documents','Select the folder with TRAIN Benign Data');
        
        srcFiles = dir(strcat(folder_name,'\*.jpg'));
    
        % Scan for files in the directory
    
    elseif a == 2
        
        % Selecting the folder which contains the Malignant images for training.
        
        folder_name = uigetdir('C:\Users\DELL\Documents','Select the folder with TRAIN Cancerous Data');
        
        srcFiles = dir(strcat(folder_name,'\*.jpg'));
    
        % Scan for files in the directory
        
    elseif a == 3
        
        % Selecting the folder which contains the Benign images for testing.
        
        folder_name = uigetdir('C:\Users\DELL\Documents','Select the Folder with TEST Benign Images');
        
        srcFiles = dir(strcat(folder_name,'\*.jpg'));
    
        % Scan for files in the directory
    
    elseif a == 4
        % Selecting the folder which contains the Malignant images for testing.
        
        folder_name = uigetdir('C:\Users\DELL\Documents','Select the Folder with TEST Cancer Images');
        
        srcFiles = dir(strcat(folder_name,'\*.jpg'));
    
        % Scan for files in the directory
    
    end
    
    % end of folder selection, now the actual algorithm starts.
    
    
    for k = 1 : length(srcFiles)
        
        % The loop runs on the folder with all the Image files.
        
        filename = strcat(folder_name,'\',srcFiles(k).name);
        
        % Selecting the image,putting pathname and filename together.
        
        A = double(im2bw(imread(filename)));
        
        % Reading the Image file.
        
       [I] = amf(A,7);
        
        %Adaptive Median Filtering
        
        cordinates = signature(I);
        
        % Calling the function Signature.
        
        [co_rel,std_err,poly_coeff] = polyreg(cordinates,degree);
        
        % Calling the function polyreg.
        
        if a == 1
            
            % Putting benign training data in data1.
            
            data1 = cat(1,data1,[co_rel std_err 1]);
        
        elseif a == 2
            
            % Putting malignant training data in data2.
            
            data2 = cat(1,data2,[co_rel std_err 0]);
        
        elseif a == 3
        
            % Putting Bening testing data in data3.
            
            data3 = cat(1,data3,[co_rel std_err 1]);
            
        elseif a == 4
            
            % Putting Bening testing data in data4.
            
            data4 = cat(1,data4,[co_rel std_err 0]);
            
        end
    end
end

% End of calculating the correlation coeff and standard error,
% now SVM training starts.

corr = [data1(:,1);data2(:,1)];

% concatenating benign and malignant correlation coefficient data.

stderr = [data1(:,2);data2(:,2)];

% concatenating benign and malignant standard error data.

result = [data1(:,3);data2(:,3)];

% concatenating the boolean data about whether the data represents benign
% or malignant,0 means malignant and 1 means benign.

training = [corr stderr];

% Concatenating Correlation coefficient and standard error,row wise.

SVMstruct = fitcsvm(training,result,'HyperparameterOptimizationOptions', struct('showplot',true),'KernelFunction','rbf','KernelScale',0.75);

% SVM Training with gaussian kernel function with standard deviation of the
% Gaussian equal to 1.The execution of the above command also outputs the
% plot.

testbenign = [data3(:,1) data3(:,2)];
testcancerous = [data4(:,1) data4(:,2)];
trainbenign = [data1(:,1) data1(:,2)];
traincancerous = [data2(:,1) data2(:,2)];

% A sample value of correlation coefficient and standard error.

[clf_testbenign] = predict(SVMstruct,testbenign);
[clf_testcancerous] = predict(SVMstruct,testcancerous);
[clf_trainbenign] = predict(SVMstruct,trainbenign);
[clf_traincancerous] = predict(SVMstruct,traincancerous);

[accuracy_train,accuracy_test,specificity_train,specificity_test,sensitivity_train,sensitivity_test] = confusion_matrix(clf_testbenign,clf_testcancerous,clf_trainbenign,clf_traincancerous);
% Classifying the sample according to the SVMstruct obtained above.