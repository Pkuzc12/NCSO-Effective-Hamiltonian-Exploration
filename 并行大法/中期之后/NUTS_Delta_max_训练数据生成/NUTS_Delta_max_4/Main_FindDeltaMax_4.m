clear all
close all
clc

number=100;

size=4;

times_each_stage=1000;
stage_each_chain=100;
chain=8;

load("random8.mat")

field=-1;

Delta_max_list=zeros(1,number);

parfor i=1:number

B=B_list(i);
D=D_list(i);
J1=J1_list(i);
J2=J2_list(i);
J3=J3_list(i);
K=K_list(i);
G=G_list(i);
Gs=Gs_list(i);
kT=kT_list(i);

parameter=[J1,J1,J2,J2,J3,K,G,Gs,K,G,Gs,B,D,field]/4;
otherparameter=[kT,size,times_each_stage,stage_each_chain,chain];
Delta_max_list(i)=NUTS_FindDeltaMax(parameter,otherparameter);

end

save Delta_max_801-900.mat