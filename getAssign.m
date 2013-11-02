function [rAssign,attemptNum] = getAssign(ind,pCoor,cAssign,cAvail,pCons,attemptNum)
    attemptNum = attemptNum+1;
    display(attemptNum);
    rAssign = cAssign;
    if (ind>size(pCoor,1))
        return
    end
    
    for i=1:size(cAvail,2)
        if cAvail(ind,i)==0 % current color is not available
            continue
        end
        
        cAvailPrev = cAvail;
        assign = cAvail(ind,i);
        cAvail(ind,i) = 0;
        newAssign = cAssign;
        newAssign(ind,1) = assign;
        % delete same values in cAvail for unassgied variables
        for j=1:size(pCons,2)
            if pCons(ind,j)~=0
                  cAvail(pCons(ind,j),assign) = 0;
            end
        end
        
        [rAssign,attemptNum] = getAssign(ind+1,pCoor,newAssign,cAvail,pCons,attemptNum);
        if (min(rAssign,[],2)>0)
            return
        end
        
        if rAssign == newAssign
            cAvail = cAvailPrev;
            rAssign = cAssign;
        end
    end
end

