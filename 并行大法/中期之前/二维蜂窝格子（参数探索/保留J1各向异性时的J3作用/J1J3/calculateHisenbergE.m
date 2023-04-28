function [E] = calculateHisenbergE(A,x,y,leftflag,J3)


J1=-3.02;
J1p=-2.37;
J2=0;
J2p=0;
E=0;


if leftflag


orient1=A(x,y).left.orientation;


for i=2:1:3
    x_nei=A(x,y).left.neighbor(i,1);
    y_nei=A(x,y).left.neighbor(i,2);
    orient2=A(x_nei,y_nei).right.orientation;
    E=E+J1p/4*dot(orient1,orient2);
end


x_nei=A(x,y).left.neighbor(1,1);
y_nei=A(x,y).left.neighbor(1,2);
orient2=A(x_nei,y_nei).right.orientation;
E=E+J1/4*dot(orient1,orient2);


else


orient1=A(x,y).right.orientation;


for i=2:1:3
    x_nei=A(x,y).right.neighbor(i,1);
    y_nei=A(x,y).right.neighbor(i,2);
    orient2=A(x_nei,y_nei).left.orientation;
    E=E+J1p/4*dot(orient1,orient2);
end


x_nei=A(x,y).right.neighbor(1,1);
y_nei=A(x,y).right.neighbor(1,2);
orient2=A(x_nei,y_nei).left.orientation;
E=E+J1/4*dot(orient1,orient2);


end


if leftflag


    orient1=A(x,y).left.orientation;


    x_nei2=A(x,y).left.neighbor2(1,1);
    y_nei2=A(x,y).left.neighbor2(1,2);
    orient2=A(x_nei2,y_nei2).left.orientation;
    E=E+J2p/4*dot(orient1,orient2);


    x_nei2=A(x,y).left.neighbor2(4,1);
    y_nei2=A(x,y).left.neighbor2(4,2);
    orient2=A(x_nei2,y_nei2).left.orientation;
    E=E+J2p/4*dot(orient1,orient2);


    for i=2:1:3
        x_nei2=A(x,y).left.neighbor2(i,1);
        y_nei2=A(x,y).left.neighbor2(i,2);
        orient2=A(x_nei2,y_nei2).left.orientation;
        E=E+J2/4*dot(orient1,orient2);
    end


    for i=5:1:6
        x_nei2=A(x,y).left.neighbor2(i,1);
        y_nei2=A(x,y).left.neighbor2(i,2);
        orient2=A(x_nei2,y_nei2).left.orientation;
        E=E+J2/4*dot(orient1,orient2);
    end


else


    orient1=A(x,y).right.orientation;


    x_nei2=A(x,y).right.neighbor2(1,1);
    y_nei2=A(x,y).right.neighbor2(1,2);
    orient2=A(x_nei2,y_nei2).right.orientation;
    E=E+J2p/4*dot(orient1,orient2);


    x_nei2=A(x,y).right.neighbor2(4,1);
    y_nei2=A(x,y).right.neighbor2(4,2);
    orient2=A(x_nei2,y_nei2).right.orientation;
    E=E+J2p/4*dot(orient1,orient2);


    for i=2:1:3
        x_nei2=A(x,y).right.neighbor2(i,1);
        y_nei2=A(x,y).right.neighbor2(i,2);
        orient2=A(x_nei2,y_nei2).right.orientation;
        E=E+J2/4*dot(orient1,orient2);
    end


    for i=5:1:6
        x_nei2=A(x,y).right.neighbor2(i,1);
        y_nei2=A(x,y).right.neighbor2(i,2);
        orient2=A(x_nei2,y_nei2).right.orientation;
        E=E+J2/4*dot(orient1,orient2);
    end

    
end


if leftflag


    orient1=A(x,y).left.orientation;


    for i=1:1:3
        x_nei3=A(x,y).left.neighbor3(i,1);
        y_nei3=A(x,y).left.neighbor3(i,2);
        orient2=A(x_nei3,y_nei3).right.orientation;
        E=E+J3/4*dot(orient1,orient2);
    end
else


    orient1=A(x,y).right.orientation;


    for i=1:1:3
        x_nei3=A(x,y).right.neighbor3(i,1);
        y_nei3=A(x,y).right.neighbor3(i,2);
        orient2=A(x_nei3,y_nei3).left.orientation;
        E=E+J3/4*dot(orient1,orient2);
    end
end


end

