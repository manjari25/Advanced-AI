%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1
clc;
close all;
clear all;
str = input('Enter the name of the data file\n(full path if it is outside this directory)\nEnter name in single quotes\n');
% data = load('1dgauss_au12.txt');
data = load (str);
% Compute global mean
m = mean(data);
s = std(data);
% Define number of gaussians and number of data points
N = 3;
delta = ones(N,1);
n = size(data,1);
% Define probabilities
P = [1/N;1/N;1/N];
% Initialize random mean and standard deviation
M = [m+0.1;m;m-0.1];
S = [s+0.5;s;s-0.5];
itr=0;
fprintf('Initialization:\n');
fprintf('P1 = %f,P2 = %f,P3 = %f\n',P(1,1),P(2,1),P(3,1));
fprintf('M1 = %f,M2 = %f,M3 = %f\n',M(1,1),M(2,1),M(3,1));
fprintf('S1 = %f,S2 = %f,S3 = %f\n\n',S(1,1),S(2,1),S(3,1));
while((delta(1,1)>1e-9)||(delta(2,1)>1e-9)||(delta(3,1)>1e-9))
    itr=itr+1;
    Pcx = []; 
    Pij = [];
    anorm = [];
    soft_count = [];
    % Expectation
    for j=1:n
        for i=1:N
           Pcx(j,i) = gaussian(data(j,1),M(i,1),S(i,1))*P(i,1);
        end
    end
    anorm = sum(Pcx,2);
    % Alpha-normalize    
    for i=1:N   
        Pij(:,i) = Pcx(:,i)./anorm(:,1);
    end
    % Soft counts     
    soft_count = sum(Pij);
    soft_count = soft_count';
    % Maximization
    % New means and standard deviation
    for j=1:N
        temp=0;
        temp1=0;
        for i=1:n
            temp=temp+sum((Pij(i,j)*data(i,1)));
            temp1=temp1+sum(Pij(i,j)*(data(i,1).^2));
        end 
        M_new(j,1) = temp/soft_count(j,1);        
        tvar(j,1) = temp1/soft_count(j,1);
    end
    S_new = sqrt((tvar-((M_new).^2)));
    % New class prior
    P_new = soft_count./sum(soft_count);
    delta = M_new-M;
    M = M_new;
    S = S_new;
    P = P_new;
end
fprintf('End Parameters:\n');
fprintf('P1 = %f,P2 = %f,P3 = %f\n',P(1,1),P(2,1),P(3,1));
fprintf('M1 = %f,M2 = %f,M3 = %f\n',M(1,1),M(2,1),M(3,1));
fprintf('S1 = %f,S2 = %f,S3 = %f\n\n',S(1,1),S(2,1),S(3,1));
fprintf('Iterations for convergence:%d\n\n',itr);
fprintf('True Parameters:\n');
fprintf('P1 = %f,P2 = %f,P3 = %f\n',300/900,300/900,300/900);
fprintf('M1 = %f,M2 = %f,M3 = %f\n',mean(data(1:300)),mean(data(301:600)),mean(data(601:900)));
fprintf('S1 = %f,S2 = %f,S3 = %f\n',std(data(1:300)),std(data(301:600)),std(data(601:900)));
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2
clc;
close all;
clear all;
fulldata = load('1dgauss_au12.txt');
data = fulldata(1:700);
% data = fulldata(201:800);

% Compute global mean
m = mean(data);
s = std(data);
% Define number of gaussians and number of data points
N = 3;
delta = ones(N,1);
n = size(data,1);
% Define probabilities
P = [1/N;1/N;1/N];
% Initialize random mean and standard deviation
M = [m+0.1;m;m-0.1];
S = [s+0.5;s;s-0.5];
itr=0;
fprintf('Initialization:\n');
fprintf('P1 = %f,P2 = %f,P3 = %f\n',P(1,1),P(2,1),P(3,1));
fprintf('M1 = %f,M2 = %f,M3 = %f\n',M(1,1),M(2,1),M(3,1));
fprintf('S1 = %f,S2 = %f,S3 = %f\n\n',S(1,1),S(2,1),S(3,1));
while((delta(1,1)>1e-9)||(delta(2,1)>1e-9)||(delta(3,1)>1e-9))
    itr=itr+1;
    Pcx = []; 
    Pij = [];
    anorm = [];
    soft_count = [];
%     Expectation
    for j=1:n
        for i=1:N
           Pcx(j,i) = gaussian(data(j,1),M(i,1),S(i,1))*P(i,1);
        end
    end
    anorm = sum(Pcx,2);
%     Alpha-normalize    
    for i=1:N   
        Pij(:,i) = Pcx(:,i)./anorm(:,1);
    end
%     Soft counts     
    soft_count = sum(Pij);
    soft_count = soft_count';
%     Maximization
%     New means and standard deviation
    for j=1:N
        temp=0;
        temp1=0;
        for i=1:n
            temp=temp+sum((Pij(i,j)*data(i,1)));
            temp1=temp1+sum(Pij(i,j)*(data(i,1).^2));
        end 
        M_new(j,1) = temp/soft_count(j,1);        
        tvar(j,1) = temp1/soft_count(j,1);
    end
    S_new = sqrt((tvar-((M_new).^2)));
%     New class prior
    P_new = soft_count./sum(soft_count);
    delta = M_new-M;
    M = M_new;
    S = S_new;
    P = P_new;
end
fprintf('End Parameters:\n');
fprintf('P1 = %f,P2 = %f,P3 = %f\n',P(1,1),P(2,1),P(3,1));
fprintf('M1 = %f,M2 = %f,M3 = %f\n',M(1,1),M(2,1),M(3,1));
fprintf('S1 = %f,S2 = %f,S3 = %f\n\n',S(1,1),S(2,1),S(3,1));
fprintf('Iterations for convergence:%d\n\n',itr);

fprintf('True Parameters:\n');
fprintf('P1 = %f,P2 = %f,P3 = %f\n',300/700,300/700,100/700);
fprintf('M1 = %f,M2 = %f,M3 = %f\n',mean(data(1:300)),mean(data(301:600)),mean(data(601:700)));
fprintf('S1 = %f,S2 = %f,S3 = %f\n',std(data(1:300)),std(data(301:600)),std(data(601:700)));

% fprintf('P1 = %f,P2 = %f,P3 = %f\n',100/600,300/600,200/600);
% fprintf('M1 = %f,M2 = %f,M3 = %f\n',mean(data(1:100)),mean(data(101:400)),mean(data(401:600)));
% fprintf('S1 = %f,S2 = %f,S3 = %f\n',std(data(1:100)),std(data(101:400)),std(data(401:600)));

pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3
clc;
clear all;
close all;
data = load('1dgauss_au12.txt');
n = size(data,1);
index = [randi(900);randi(900);randi(900)];
m1 = data(index(1,1));
m2 = data(index(2,1));
m3 = data(index(3,1));
fprintf('Initialization:\n');
fprintf('M1 = %f,M2 = %f,M3 = %f\n\n',m1,m2,m3);
delta1 = 1;
delta2 = 1;
delta3 = 1;
itr=0;
while ((abs(delta1)~=0)||(abs(delta2)~=0)||(abs(delta3)~=0))
    itr = itr+1;
    t1 = ones(n,1)*m1;
    t2 = ones(n,1)*m2;
    t3 = ones(n,1)*m3;
    eDist(:,1) = sqrt((data-t1).^2);
    eDist(:,2) = sqrt((data-t2).^2);
    eDist(:,3) = sqrt((data-t3).^2);
    P(:,1) = eDist(:,1)./sum(eDist,2);
    P(:,2) = eDist(:,2)./sum(eDist,2);
    P(:,3) = eDist(:,3)./sum(eDist,2);
    gf = sum(P)./sum(sum(P));
    for i=1:n
        [~,ind] = min(eDist(i,:));
        Cluster(i,1) = ind;
    end
    s1=[];
    s2=[];
    s3=[];
    for i=1:n
        if (Cluster(i,1) == 1)
            s1 = [s1;data(i,1)];
        elseif (Cluster(i,1)== 2)
            s2 = [s2;data(i,1)];
        elseif (Cluster(i,1) == 3)
            s3 = [s3;data(i,1)];
        end
    end
    prob = sum(P);
    prob = prob./sum(prob);
    m1_new=mean(s1);
    m2_new=mean(s2);
    m3_new=mean(s3);
    delta1 = m1_new-m1;
    delta2 = m2_new-m2;
    delta3 = m3_new-m3;
    m1=m1_new;
    m2=m2_new;
    m3= m3_new;
end
fprintf('End means:\n');
fprintf('M1 = %f,M2 = %f,M3 = %f\n\n',m1,m2,m3);
fprintf('Count of points:\n');
fprintf('Count1 = %d,Count2 = %d,Count3 = %d\n\n',size(s1,1),size(s2,1),size(s3,1));
fprintf('Prior on each Gaussian:\n');
fprintf('P1 = %f,P2 = %f,P3 = %f\n\n',prob(1,1),prob(1,2),prob(1,3));
fprintf('Iterations:\n%d\n\n',itr);
fprintf('True means:\n');
fprintf('M1 = %f,M2 = %f,M3 = %f\n\n',mean(data(1:300)),mean(data(301:600)),mean(data(601:900)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%