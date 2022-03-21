function [BFS, A1]=simplex(A1,BV, costs_1, variables)
    ZjCj=costs_1(BV)*A1-costs_1;
    iniTable=array2table([ZjCj;A1]);
    iniTable.Properties.VariableNames(1:size(A1,2))=variables;
    run=true;
    while run
        ZC=ZjCj(:,1:end-1);
        if any(ZC<0)
            [entcol, pvt_col]=min(ZC);
            sol=A1(:,end);
            col=A1(:,pvt_col);
            if col<0
                fprintf('Unbounded Solution\n')
                BFS=BV;
                break;
            else
                for i=1:size(A1,1)
                    if col(i)>0
                        ratio(i)=sol(i)./col(i);
                    else
                        ratio(i)=inf;
                    end
                end
                [minRatio, pvt_row]=min(ratio);
                BV(pvt_row)=pvt_col;
                pvt_key=A1(pvt_row,pvt_col);
                A1(pvt_row,:)=A1(pvt_row,:)./pvt_key;
                for i=1:size(A1,1)
                    if i~=pvt_row
                        A1(i,:)=A1(i,:)-A1(i,pvt_col).*A1(pvt_row,:);
                    end
                end
            end
            ZjCj=ZjCj-ZjCj(pvt_col).*A1(pvt_row,:);
        else
            run=false;
            BFS=BV;
            fprintf('Optimal solution reached\n');
        end
    end
end