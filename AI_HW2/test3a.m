clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TRAINING %%%%%%%%%%%%

% Load data file
tr = load('Q2/game_attrdata_train_Q2');
% Seperate out the input and target vectors
x = tr(:,1:16);
t = tr(:,17:20);

% Define learning rate,weights and bias terms
w=zeros(4,16);
alpha=0.0001;
b = [-1,-1,-1,-1];

% Loop till error less than epsilon
for itr=1:1000
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
te = load('Q2/game_attrdata_test_Q2.txt');
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