close all;
clear all;
clc;

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
field=0;
J1=0;
J1p=0;
J2=0;
J2p=0;
J3=0;
x=[];
y=[];
z=[];
parameter=[J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field];
E_S=grad_Eb_helper(chart,n,parameter);

X=X_Grt_for_HeisenbergCheck(n);

calculateEb(X,n,E_S,field)