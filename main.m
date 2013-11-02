clc
clear
close all

pNum = 50; %%%%%%
method = 0; % 1: forward checking; 0: no forward checking


%% Map Generation
% random coordinates for the points
pCoor = rand(pNum,2);
pCnt = zeros(0,0);
% compute the distance
idx = 1;
for i=1:pNum
    for j=(i+1):pNum 
        dis(idx,1) = i;
        dis(idx,2) = j;
        dis(idx,3) = (pCoor(i,1)-pCoor(j,1))^2+(pCoor(i,2)-pCoor(j,2))^2;
        idx = idx+1;
    end
end

% plot(pCoor(:,1),pCoor(:,2),'*'); %%%% visualization
% hold on
% title(['random generated points in unit square, point number:',num2str(pNum)]);

% sort distance
dis = sortrows(dis,3);
% pick two points with smallest distance
cntIdx = 1;
for i=1:size(dis,1)
    display('making connections');
    p1 = dis(i,1);
    p2 = dis(i,2);
    
    % check intersection 
    check = intersection(p1,p2,pCnt,pCoor);
    if (check== 0)
        % connect
        pCnt(cntIdx,1) = p1;
        pCnt(cntIdx,2) = p2;
        x1 = pCoor(p1,1);
        y1 = pCoor(p1,2);
        x2 = pCoor(p2,1);
        y2 = pCoor(p2,2);
%         plot([x1 x2],[y1 y2],'black');  %%%% visualization
        cntIdx = cntIdx+1;
    end
end

%% Assignment 
cAssign = zeros(pNum,1); % 1:red, 2:blue, 3:green, 4:yellow
cAvail = zeros(pNum,4);
cAvail(:,1) = 1;
cAvail(:,2) = 2;
cAvail(:,3) = 3;
cAvail(:,4) = 4;

% find constraint between points
pConstraint1 = zeros(pNum,pNum);
m = 1;
n = 0;
pCnt1 = sortrows(pCnt,1);
for i=1:size(pCnt,1)
    if pCnt1(i,1) == m
        n = n+1;
        pConstraint1(m,n) = pCnt1(i,2);
    else
        m = m+1;
        n = 1;
        pConstraint1(m,n) = pCnt1(i,2);
    end
end
m = 1;
n = 0;
pConstraint = zeros(pNum,pNum);
pCnt1 = sortrows(pCnt,2);
for i=1:size(pCnt,1)
    if pCnt1(i,2) == m
        n = n+1;
        pConstraint(m,n) = pCnt1(i,1);
    else
        m = m+1;
        if m==5
        end
        n = 1;
        pConstraint(m,n) = pCnt1(i,1);
    end
end  
pConstraint = cat(2,pConstraint,pConstraint1);
pConstraint = sort(pConstraint,2,'descend');
pCons = pConstraint(:,1:pNum);
        
if method == 0 % no forward checking
    [cAssign,attemptNum] = getAssign(1,pCoor,cAssign,cAvail,pCons,0);
else 
    [cAssign,attemptNum] = getAssignFast(1,pCoor,cAssign,cAvail,pCons,0);
end


for i=1:pNum %%%% visualization
    if (cAssign(i,1) == 1)
        plot(pCoor(i,1),pCoor(i,2),'o','MarkerFaceColor','r','MarkerSize',10);
    elseif (cAssign(i,1) == 2)
        plot(pCoor(i,1),pCoor(i,2),'o','MarkerFaceColor','g','MarkerSize',10);
    elseif (cAssign(i,1) == 3)
        plot(pCoor(i,1),pCoor(i,2),'o','MarkerFaceColor','b','MarkerSize',10);
    elseif (cAssign(i,1) == 4)
        plot(pCoor(i,1),pCoor(i,2),'o','MarkerFaceColor','y','MarkerSize',10);
    end
end


        