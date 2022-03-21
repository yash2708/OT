format short
clear all
clc

costs=[-3 -5 0 0 -10000 -10000 0];
A1=[1 3 -1 0 1 0 3; 1 1 0 -1 0 1 2];
BV=[5 6];
variables={'x1','x2','s1','s2','a1','a2','sol'};
oVariables={'x1','x2','s1','s2','sol'};

%cost of 1st phase
%%Phase 1 starts
costs_1=[0 0 0 0 -1 -1 0];
startBV= find(costs_1<0);
[BFS,A1]=simplex(A1,BV, costs_1,variables);
% Phase 2 starts
A1(:,startBV)=[];
costs(startBV)=[];
[optimalBFS, optimalA]=simplex(A1,BFS,costs,oVariables);
    
            
