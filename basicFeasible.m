A=[-1 1;1 1];
b=[1 ; 2];
C=[1 2];


m=size(A,1);
n=size(A,2);
if n>=m
    nv=nchoosek(n,m);
    t=nchoosek(1:n,m)
    sol=[];
    for i=1:nv
        y=zeros(n,1);
        x=A(:,t(i,:))\b;
        if all(x>=0 & x~=inf & x~=-inf)
            y(t(i,:))=x;
            sol=[sol y];
        end
    end
else 
    error('Equations are large than variables')
     
end

Z=C*sol;
[Zmax,Zind]=max(z);
BFS=sol(:,Zind);