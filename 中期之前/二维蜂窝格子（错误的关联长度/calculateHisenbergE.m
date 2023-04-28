function [E] = calculateHisenbergE(A,x,y,leftflag,J)


if leftflag


E=0;
orient1=A(x,y).left.orientation;


for i=1:1:3
    x_nei=A(x,y).left.neighbor(i,1);
    y_nei=A(x,y).left.neighbor(i,2);
    orient2=A(x_nei,y_nei).right.orientation;
    E=E-J/4*dot(orient1,orient2);
end


else


E=0;
orient1=A(x,y).right.orientation;


for i=1:1:3
    x_nei=A(x,y).right.neighbor(i,1);
    y_nei=A(x,y).right.neighbor(i,2);
    orient2=A(x_nei,y_nei).left.orientation;
    E=E-J/4*dot(orient1,orient2);
end


end


end

