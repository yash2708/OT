%min Z = 3x_1 + 5x_2
%S.T
%x_1+3x_2>=3
%x_1+x_2>=2
%x1,x2>=0
format short
clear all
clc
costs=[-3 -5 0 0 -10000 -10000 0];
A=[1 3 -1 0 1 0 3; 1 1 0 -1 0 1 2];
BV=[5 6];
ZjCj= costs(BV)*A-costs;
zcj=[costs;ZjCj;A];
bigmtable=array2table(zcj);
bigmtable.Properties.VariableNames(1:size(zcj,2))={'x_1','x_2','s_1','s_2','a_1','a_2','sol'}


run = true;
while run 
    ZC=ZjCj(1:end-1)
    if any(ZC<0)
        fprintf('The current BFS is not optimal\n')
        [ent_col,pvt_col]=min(ZC)
        fprintf('Entering column in %d \n',pvt_col)
        sol=A(:,end);
        column=A(:,pvt_col)
        if column<=0
            error('LPP is unbounded')
        else
            for i = 1:size(A,1)
                if(column(i)>0)
                    ratio(i)=sol(i)./column(i);
                else
                    ratio(i)=inf;
                end
            end
            [min_ratio,pvt_row]=min(ratio)
            fprintf('Leaving Row = %d',pvt_row);
        end
        BV(pvt_row)=pvt_col;
        pvt_key=A(pvt_row,pvt_col);
        A(pvt_row,:)=A(pvt_row,:)./pvt_key;
        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
            end
        end
        ZjCj=ZjCj-ZjCj(pvt_col).*A(pvt_row,:);
        zcj=[ZjCj;A];
        Table=array2table(zcj);
        Table.Properties.VariableNames(1:size(zcj,2))={'x_1','x_2','s_1','s_2','a_1','a_2','sol'}
    else
        run=false;
        fprintf('BFS is optimal');
    end
end