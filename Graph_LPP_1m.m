% maximise Z=3x1+5x2
%s.t. x1+2x2<=2000
%x1+x2<=1500
%x2<=600
%x1,x2>=0
format short 
clear all
clc

%Phase 1: Imput parameters
C=[3 5];
A=[1 3;1 1;3 5];
b=[3;2;6];

HG=[0;0]
for i=1:size(A,1)
    hg1=A(i,:)
    b1=b(i,:)
    for j = i+1:size(A,1)
        hg2=A(j,:)
        b2=b(j,:)
        Aa=[hg1;hg2]
        Bb=[b1;b2]
        Xx=Aa\Bb
        HG=[HG Xx]
    end
end
pt=HG'
% 
% %Phase 5: Write all corner points (phase 3,4
points=unique(pt,'rows')
% %Phase 6: Find feasible region
% 
% %Phase 7: Compute objective function
% %Phase 8: Find the optimal one