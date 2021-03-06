clc;
clear all;
close all;
str = input('Enter the name of the data file\n(full path if it is outside this directory)\nEnter name in single quotes\n');
% data = load ('columbus_price_vs_sf.txt');
data = load (str);

% Seperate vectors for price and square feet
y=data(:,1);
x=data(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4a - Compute mean, standard deviation, minimum, maximum of data
% Minimum and maximum
[min_d,max_d] = min_max_data(data);
fprintf('Price\nMinimum = %f\nMaximum = %f\n',min_d(1,1),max_d(1,1));
fprintf('\nSquare Feet\nMinimum = %f\nMaximum = %f\n',min_d(1,2),max_d(1,2));

% Mean
m = mean_data(data);
fprintf('\nPrice\nMean = %.10f\n',m(1,1));
fprintf('\nSquare Feet\nMean = %.10f\n',m(1,2));


% Standard Deviation
s = sdev_data(m,data);
fprintf('\nPrice\nStandard Deviation = %.10f\n',s(1,1));
fprintf('\nSquare Feet\nStandard Deviation = %.10f\n',s(1,2));
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4b - Compute linear regression coefficients
% Normalized y and x
ny = (y-min_d(1,1))./(max_d(1,1)-min_d(1,1));
nx = (x-min_d(1,2))./(max_d(1,2)-min_d(1,2));

N = size(data,1);
sxy = 0;
sx2 = 0;

% sigma of xi*yi
sxy = sum(y.*x);
% sigma of xi^2
sx2 = sum(x.^2);
% sigma of xi and yi
sx = sum(x);
sy = sum(y);

% Calculate w1 and w0
w1 = ((N*(sxy)) - (sx*sy))/((N*(sx2))- (sx^2));
w0 = (sy - (w1*sx))/N;

% Display the coefficients
fprintf('\nCoefficients are - \n w1 = %.10f,w0 = %.10f',w1,w0);
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4c - Batch Gradient Descent
% Define optimal values
ow1 = w1;
ow0 = w0;
% Set alpha,epsilon, count
alpha = 0.00000000001;
count = 0;
epsilon = 0.001;
% Start with non-optimal weights
w1 = ow1+100;
w0 = ow0+100;
deltaw0=1;
deltaw1=1;

while ((abs(deltaw0) > epsilon) || (abs(deltaw1) >= epsilon))
   fprintf('\n w1 = %.10f, w0 = %.10f',w1,w0);
   fw0=0;
   fw1=0;
   for i=1:N
       fw0 = fw0 + (y(i,1)-(w1*x(i,1)+w0));
       fw1 = fw1 + ((y(i,1)-(w1*x(i,1)+w0))*x(i,1));
   end 
   deltaw0 = alpha*fw0;
   deltaw1 = alpha*fw1;

   neww0 = w0+deltaw0;
   neww1 = w1+deltaw1;
   
   if (abs(deltaw0) > epsilon)
       w0 = neww0;      
   end
   if (abs(deltaw1) > epsilon)
        w1 = neww1;
   end
   if ((abs(deltaw0) > epsilon)||(abs(deltaw1) > epsilon))
       count=count+1;
   end
   if (count>10000000)
       disp('\nDoes not converge for given values even after 10000000 iterations !\n');
       break;
   end
end
fprintf('\nOptimal w1 = %.10f,w0 = %.10f',ow1,ow0);
fprintf('\nFinal w1 = %.10f,w0 = %.10f',w1,w0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


