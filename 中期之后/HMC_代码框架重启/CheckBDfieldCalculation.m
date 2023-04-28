clear all
close all
clc

n=4;
chart=ChartGrt(n);
B=0;
D=0;
K=0;
Kp=0;
G=0;
Gp=0;
Gs=0;
Gps=0;
field=1;
J1=0;
J1p=0;
J2=0;
J2p=0;
J3=0;
parameter=[J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field];
E_S=grad_Eb_helper(chart,n,parameter);

x=[];
y=[];
z=[];

for i=1:1:n
    for j=1:1:n
        X=X_Grt_for_BDfieldCheck(n);
        theta=pi/2;
        phi=pi/2;
        index=((i-1)*n+j-1)*4;
        X(index+1:index+2)=[theta;phi];
        x=[x,sqrt(3)*i+sqrt(3)/2*j];
        y=[y,3/2*j];
        z=[z,calculateEb(X,n,E_S,field)];
    end
end
for i=1:1:n
    for j=1:1:n
        X=X_Grt_for_BDfieldCheck(n);
        theta=pi/2;
        phi=pi/2;
        index=((i-1)*n+j-1)*4;
        X(index+3:index+4)=[theta;phi];
        x=[x,sqrt(3)*i+sqrt(3)/2*j+sqrt(3)/2];
        y=[y,3/2*j+1/2];
        z=[z,calculateEb(X,n,E_S,field)];
    end
end
scatter3(x,y,z,50,z);
ax=gca;
ax.XLim=[1,12];
ax.YLim=[1,8];
colorbar;