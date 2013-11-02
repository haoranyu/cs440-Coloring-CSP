function yes = intersection(p1,p2,pCnt,pCoor)
yes = 0;
    for t = 1:size(pCnt,1)
        p3 = pCnt(t,1);
        p4 = pCnt(t,2);
        x1 = pCoor(p1,1);
        y1 = pCoor(p1,2);
        x2 = pCoor(p2,1);
        y2 = pCoor(p2,2);
        x3 = pCoor(p3,1);
        y3 = pCoor(p3,2);
        x4 = pCoor(p4,1);
        y4 = pCoor(p4,2);
        if (p1==p3) || (p1==p4) || (p2==p3) || (p2==p4)
            continue
        elseif (((y4-y3)~=0)&&((x4-x3)~=0)&&((y2-y1)~=0)&&((x2-x1)~=0))
            ua = ((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3))/((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
            %ub = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
            x = x1+ua*(x2-x1);
            y = y1+ua*(y2-y1);
            xRange1 = [x x1 x2];
            xRange2 = [x x3 x4];
            yRange1 = [y y1 y2];
            yRange2 = [y y3 y4];
            xRange1 = sort(xRange1);
            yRange1 = sort(yRange1);
            xRange2 = sort(xRange2);
            yRange2 = sort(yRange2);
            if (x==xRange1(2))&&(x==xRange2(2))&&(y==yRange1(2))&&(y==yRange2(2))
                yes =1;
                return;
            else
                yes =0;
            end
        end
    end
end

