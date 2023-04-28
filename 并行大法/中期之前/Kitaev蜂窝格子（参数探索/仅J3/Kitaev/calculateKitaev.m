function [E] = calculateKitaev(A,x,y,leftflag)


K=-0.117;
G=-0.161+0.277;
Gs=0.1895+0.237;
Gp=0.277;
Gps=0.237;
E=0;


U=[[1/sqrt(6),-1/(3*sqrt(2))-sqrt(2)/3,1/sqrt(3)];[1/sqrt(6),1/(3*sqrt(2))+sqrt(2)/3,1/sqrt(3)];[-sqrt(2/3),0,1/sqrt(3)]];
J=[[0,G,Gs];[G,0,Gs];[Gs,Gs,K]];
Jp=[[0,Gp,Gps];[Gp,0,Gps];[Gps,Gps,K]];
order=[[[0,1,0];[0,0,1];[1,0,0]];[[0,0,1];[1,0,0];[0,1,0]];[[1,0,0];[0,1,0];[0,0,1]]];


if leftflag


    orient1=A(x,y).left.orientation;

    x_nei=A(x,y).left.neighbor(1,1);
    y_nei=A(x,y).left.neighbor(1,2);
    orient2=A(x_nei,y_nei).right.orientation;
    orient1=order(1:3,:)*U*orient1;
    orient2=order(1:3,:)*U*orient2;
    E=E+dot(orient1,Jp*orient2);


    x_nei=A(x,y).left.neighbor(2,1);
    y_nei=A(x,y).left.neighbor(2,2);
    orient2=A(x_nei,y_nei).right.orientation;
    orient1=order(4:6,:)*U*orient1;
    orient2=order(4:6,:)*U*orient2;
    E=E+dot(orient1,Jp*orient2);


    x_nei=A(x,y).left.neighbor(3,1);
    y_nei=A(x,y).left.neighbor(3,2);
    orient2=A(x_nei,y_nei).right.orientation;
    orient1=order(7:9,:)*U*orient1;
    orient2=order(7:9,:)*U*orient2;
    E=E+dot(orient1,J*orient2);


else


    orient1=A(x,y).right.orientation;

    x_nei=A(x,y).right.neighbor(1,1);
    y_nei=A(x,y).right.neighbor(1,2);
    orient2=A(x_nei,y_nei).left.orientation;
    orient1=order(1:3,:)*U*orient1;
    orient2=order(1:3,:)*U*orient2;
    E=E+dot(orient1,Jp*orient2);


    x_nei=A(x,y).right.neighbor(2,1);
    y_nei=A(x,y).right.neighbor(2,2);
    orient2=A(x_nei,y_nei).left.orientation;
    orient1=order(4:6,:)*U*orient1;
    orient2=order(4:6,:)*U*orient2;
    E=E+dot(orient1,Jp*orient2);


    x_nei=A(x,y).right.neighbor(3,1);
    y_nei=A(x,y).right.neighbor(3,2);
    orient2=A(x_nei,y_nei).left.orientation;
    orient1=order(7:9,:)*U*orient1;
    orient2=order(7:9,:)*U*orient2;
    E=E+dot(orient1,J*orient2);


end

