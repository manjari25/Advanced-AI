%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1
% Did the non-coding altenative

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2
clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TRAINING %%%%%%%%%%%%

% Load train data file
% str = input('Enter training data file name');
% tr = load(str);
tr = load('exam_data_linsep_train.dat');
% tr = load('exam_data_nonlinsep_train.dat');
% Seperate out the input and target vectors
x = tr(:,1:size(tr,2)-1);
t = tr(:,size(tr,2));
% Define learning rate,weights and bias terms
w=[0 0 0 0];
b = -1; 
alpha=0.0001;
epsilon = 0.001;
avg_error = 2;
% Loop till error greater than epsilon
% while (avg_error>epsilon)
% Loop for specific number of iterations
for itr = 1:30000
    sum_error=0;
    % For each training value
    for i=1:size(x,1)
        % calculate input
        yin = b + sum(x(i,:).*w);
        % calculate activation
        y=binaryActivation(yin);
        % Adjust Weights
        if ((t(i,1)-y)~=0)
            w = w+((alpha*(t(i,1)-y)).*x(i,:));
            b = b + alpha*(t(i,1)-y);
            sum_error=sum_error+(t(i,1)-y);
        end        
    end  
    avg_error = abs(sum_error/size(x,1));
%     avg_error
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TESTING %%%%%%%%%%%%

% Load test data file
% str = input('Enter testing data file name');
% te = load(str);
te = load('exam_data_linsep_test.dat');
% te = load('exam_data_nonlinsep_test.dat');
% Seperate out the input and target vectors
x = te(:,(1:size(te,2)-1));
t = te(:,size(te,2));

% For each input value
for i=1:size(x,1)
        % calculate input
        yin = b + sum(x(i,:).*w);
        % calculate activation
        y=binaryActivation(yin);
        output(i,1) = y;
end
%  Compare with actual output
mismatch = evaluate(output,t);

% Display results
fprintf('Weights-%f');
disp(w);
fprintf('\nBias-%f',b);
fprintf('\nPercentage of misclassification-%f percent',mismatch);
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3a

clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TRAINING %%%%%%%%%%%%

% Load data file
tr = load('game_codedata_train_new.dat');
% Seperate out the input and target vectors
x = tr(:,1:16);
t = tr(:,17:20);

% Define learning rate,weights and bias terms
w=zeros(4,16);
alpha=0.0001;
b = [-1,-1,-1,-1];

% Loop till error less than epsilon
for itr=1:25000
    % For each training value
    for i=1:size(x,1)
        for k=1:size(w,1)
            yin(1,k) = b(1,k) + sum(x(i,:).*w(k,:));
        end
        % Find maximum         
        [~,idx] = max(yin);
        % assign maximum as output
        for k=1:size(yin,2)
               if(k==idx)
                   y(1,k) = 1;
               else
                   y(1,k) = 0;
               end
        end
        % Calculate error
        error = t(i,:)-y;
        % Adjust Weights
        if (any(error)~=0)
            % find indices of wrongly labelled nodes
            idx1 = find(error==1);
            idx2 = find(error==-1);
            temp = (alpha.*(x(i,:)));
            % Update weights and bias for those nodes
            w(idx2,:) = w(idx2,:) -  temp;
            w(idx1,:) = w(idx1,:) +  temp;
            b(1,idx2)=b(1,idx2) - alpha;
            b(1,idx1)=b(1,idx1) + alpha;
        end
    end
end          

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TESTING %%%%%%%%%%%%%

% Load data file
te = load('game_codedata_test_new.dat');
% Seperate out the input and target vectors
x = te(:,1:16);
t = te(:,17:20);
%Testing
for i=1:size(x,1)
   for k=1:size(w,1)
       yin(1,k) = b(1,k) + sum(x(i,:).*w(k,:));
   end
   [~,idx] = max(yin);
   for k=1:size(w,1)
       if(k==idx)
           y(1,k) = 1;
       else
           y(1,k) = 0;
       end
   end
   output(i,:) = y;
end
% Mismatch Percentage
mismatch = evalute_multi_class(output,t);
% Results
fprintf('\nPercentage of misclassification-%f percent',mismatch);
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3b

clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TRAINING %%%%%%%%%%%%

% Load data file
tr = load('game_codedata_train_new.dat');
% Seperate out the input and target vectors
x = tr(:,1:16);
t = tr(:,17:20);
% Define learning rate,weights and bias terms
% Hidden layer(assume 8 hidden nodes)
v = rand(8,16); 
bh = (-1.*ones(1,8));
% Output layer
w = rand(4,8);
b = (-1.*ones(1,4));

alpha=0.001;
epsilon=0.001;
sum_e=0;
E=5;

%while(E>epsilon)
for itr=1:10000
    sum_e = 0;
    % For each training example
    for i=1:size(x,1)
        % Hidden layer
        for k=1:size(v,1)
                zin(1,k) = bh(1,k) + sum(x(i,:).*v(k,:));
        end
        % Activation of hidden layer input
        [zout,zoutdy] = activation(zin);
        %Output layer
        for k=1:size(w,1)
                yin(1,k) = b(1,k) + sum(zout.*w(k,:));
        end
        % Activation of hidden layer output
        [y,dy] = activation(yin);  
        % Compute error
        error = t(i,:)-y;
        sum_e = sum_e+(error*error');
        % Weight updation of output layer weights
        f = error.*dy;    
        for i=1:size(w,1)
            w(i,:)=w(i,:)+alpha*(f(1,i).*zout);
        end
        % Bias updation of ouput layer    
        for i=1:size(b,1)
            b(1,i)=b(1,i)+alpha.*f(1,i);
        end
        % Bias updation of hidden layer
        temp=0;
        for i=1:size(zout,2)
            for j=1:size(w,1)
               temp = temp + w(j,i)*f(1,j);
            end
            fo(1,i) = zoutdy(1,i)*temp;
        end
        bh = bh + alpha.*fo;
       % Weight updation of hidden layer weights
       for i=1:size(v,1)
            v(i,:) = v(i,:) + alpha*(fo(1,i).*x(i,:));       
       end
    end
    E = sum_e/size(x,1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TESTING %%%%%%%%%%%%%

% Load data file
te = load('game_codedata_test_new.dat');
% Seperate out the input and target vectors
x = te(:,1:16);
t = te(:,17:20);

for i=1:size(x,1)
    % Hidden layer
    for k=1:size(v,1)
            zin(1,k) = bh(1,k) + sum(x(i,:).*v(k,:));
    end
    % Activation of hidden layer input
    [zout,~] = activation(zin);
    %Output layer
    for k=1:size(w,1)
            yin(1,k) = b(1,k) + sum(zout.*w(k,:));
    end
    % Activation of hidden layer output
    [y,~] = activation(yin);  
    [~,idx] = max(y);
    for k=1:size(w,1)
       if(k==idx)
           y(1,k) = 1;
       else
           y(1,k) = 0;
       end
   end
   output(i,:) = y;
end
% Mismatch Percentage
mismatch = evalute_multi_class(output,t);
% Result
fprintf('\nPercentage of misclassification-%f percent',mismatch);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 