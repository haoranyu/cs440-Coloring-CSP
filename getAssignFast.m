function [rAssign,attemptNum] = getAssignFast(ind,pCoor,cAssign,cAvail,pCons,attemptNum)
    attemptNum = attemptNum+1;
    display(attemptNum);
    rAssign = cAssign;
    % sorting to find least constraining values
    leastConsNum = zeros(4,1);
    for x = 1:size(cAvail,2)
        for y=size(pCons,2)
            if (pCons(ind,y)~=0) && (cAvail(pCons(ind,y),x)~=0)
                leastConsNum(x) = leastConsNum(x)+1;
            end
        end
    end
    [leastOrder,leastConsVal] = sort(leastConsNum,'ascend');
            
    for h=1:size(cAvail,2)
        i = leastConsVal(h);
        if cAvail(ind,i)==0 % current color is not available
            continue
        end
        
        cAvailPrev = cAvail;
        cAvail(ind,i) = 0;
        newAssign = cAssign;
        newAssign(ind,1) = i;
        % delete same values in cAvail for unassgied variables
        for j=1:size(pCons,2)
            if pCons(ind,j)~=0
                  cAvail(pCons(ind,j),i) = 0;
            end
        end
        %find most constrained variables
        mostConsNum = ~cAvail;
        mostConsNum = sum(mostConsNum,2);
        [mostOrder,mostConsVar] = sort(mostConsNum,'descend');
        temp=1;
        while (newAssign(mostConsVar(temp),1)~=0) %has been assigned
            temp=temp+1;
            if temp>size(cAssign,1) % assign finished
                rAssign = newAssign;
                return
            end
        end
        newInd = mostConsVar(temp);
        % recursion
        [rAssign,attemptNum] = getAssignFast(newInd,pCoor,newAssign,cAvail,pCons,attemptNum);
        if (min(rAssign,[],2)>0)
            return
        end
        % no assignment satisfiable
        if rAssign == newAssign
            cAvail = cAvailPrev;
            rAssign = cAssign;
        end
    end
end

