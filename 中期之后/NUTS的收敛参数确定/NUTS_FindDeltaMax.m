clear all
close all
clc

kT=0.086*10;
size=4;

times_each_stage=1000;
stage_each_chain=100;
chain=8;

B=-1.158;
D=0.872;
K=-0.178;
Kp=-0.178;
G=-0.025;
Gp=-0.025;
Gs=0.3363;
Gps=0.3363;
field=-1;
J1=-3.08;
J1p=-2.24;
J2=-0.4;
J2p=0.023;
J3=0.3;

parameter=[J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field]/4;
otherparameter=[kT,size,times_each_stage,stage_each_chain,chain];

Delta_max_up=100;
Delta_max_down=-100;

while abs(Delta_max_up-Delta_max_down)>0.01

    Delta_max=1/2*(Delta_max_up+Delta_max_down);

    flag=NUTS_b(parameter,otherparameter,Delta_max);

    if flag

        Delta_max_down=Delta_max;

    else

        Delta_max_up=Delta_max;

    end

end

Delta_max_down