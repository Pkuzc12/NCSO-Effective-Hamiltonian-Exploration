clear all
close all
clc

number=100;

rng(16,'twister');

B_list=zeros(1,number);
D_list=zeros(1,number);
J1_list=zeros(1,number);
J2_list=zeros(1,number);
J3_list=zeros(1,number);
K_list=zeros(1,number);
G_list=zeros(1,number);
Gs_list=zeros(1,number);
kT_list=zeros(1,number);

for i=1:number

    B=rand-1.5;
    D=rand+0.5;
    J1=rand*2-4;
    J2=rand*2-1;
    J3=rand;
    K=rand-0.5;
    G=rand*0.2-0.1;
    Gs=rand-0.5;
    kT=(rand*9+1)*0.086;

    B_list(i)=B;
    D_list(i)=D;
    J1_list(i)=J1;
    J2_list(i)=J2;
    J3_list(i)=J3;
    K_list(i)=K;
    G_list(i)=G;
    Gs_list(i)=Gs;
    kT_list(i)=kT;

end

save random7.mat