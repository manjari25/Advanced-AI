clear all;
close all;
clc;
% Load data
data = load ('Q1/game_codedata_train.dat');
% Split into input parameters and output
x = data(:,1:8);
t = data(:,9);

% Find instances of each output
gSOC = find(t==0);
gF = find(t==1);
gATA = find(t==2);
gSc = find(t==3);

% Entropy after each split
a1=0;
b1=0;
c1=0;
a2=0;
b2=0;
c2=0;
a3=0;
b3=0;
c3=0;
a4=0;
b4=0;
c4=0;
t1=0;
t2=0;
t3=0;
t=0;
for i=1:size(gSOC,1)
   idx = gSOC(i,1);
   if(x(idx,8) ==0)
       a1  = a1+1;
   elseif(x(idx,8)==1)
       b1 = b1+1;
%    elseif(x(idx,4)==2)
%        c1 = c1+1;
   end
end

for i=1:size(gF,1)
   idx = gF(i,1);
   if(x(idx,8) ==0)
       a2  = a2+1;
   elseif(x(idx,8)==1)
       b2 = b2+1;
%    elseif(x(idx,4)==2)
%        c2 = c2+1;
   end
end

for i=1:size(gATA,1)
   idx = gATA(i,1);
   if(x(idx,8) ==0)
       a3  = a3+1;
   elseif(x(idx,8)==1)
       b3 = b3+1;
%    elseif(x(idx,4)==2)
%        c3 = c3+1;
   end
end

for i=1:size(gSc,1)
   idx = gSc(i,1);
   if(x(idx,8) ==0)
       a4  = a4+1;
   elseif(x(idx,8)==1)
       b4 = b4+1;
%    elseif(x(idx,4)==2)
%        c4 = c4+1;
   end
end

t1= a1+a2+a3+a4;
t2= b1+b2+b3+b4;
% t3= c1+c2+c3+c4;
t=t1+t2;


fprintf('\n%d,%d,%d - ',a1,b1,c1);
fprintf('\n%d,%d,%d - ',a2,b2,c2);
fprintf('\n%d,%d,%d - ',a3,b3,c3);
fprintf('\n%d,%d,%d - ',a4,b4,c4);
fprintf('\n%d,%d,%d - ',t1,t2,t3);
fprintf('\n%d - ',t);