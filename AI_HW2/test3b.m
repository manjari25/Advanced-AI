clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TRAINING %%%%%%%%%%%%

% Load data file
tr = load('Q2/game_attrdata_train_Q2');
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
for itr=1:3000
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
te = load('Q2/game_attrdata_test_Q2.txt');
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