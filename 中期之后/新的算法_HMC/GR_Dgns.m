clc;
clear all;
close all;

T=10;
epsilon=0.1;
L=10;
n=4;

neighbor=latticeGrt(n);

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

coef=S_Coef(neighbor,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D);

Mb=zeros(3,10);
variance=zeros(3,10);


for i=1:1:3


    for j=1:1:10

        
        i
        j


        if j>1
            X_temp=X(:,:,1001);
        else
            X_temp=X_first_Grt(n);
        end
        X=zeros(4,n*n,1001);
        MMb=zeros(1,1001);
        X(:,:,1)=X_temp;
        x=X(:,:,1);
        MMb(1)=calculateMb(x,n);

        for k=1:1:1000

tic
            p=randn(4,n*n,1);
            p=p-0.5*epsilon*grad_Eb_Num(neighbor,x,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field);
            for t=1:1:L
                x=x+epsilon*p;
                p=p-epsilon*grad_Eb_Num(neighbor,x,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field);
            end
            x=x+epsilon*p;
            p=p-0.5*epsilon*grad_Eb_Num(neighbor,x,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field);
            if rand(1,1)<exp(-(calculateEb(neighbor,x,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field)-calculateEb(neighbor,X(:,:,k),n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field)))
                X(:,:,k+1)=x;
                MMb(k+1)=calculateMb(x,n);
            else
                X(:,:,k+1)=X(:,:,k);
                MMb(k+1)=MMb(k);
            end
            toc


        end

        Mb(i,j)=sum(MMb)/1001;
        square=0;
        for k=1:1:1001
            square=square+(MMb(k)-Mb(i,j))^2;
        end
        variance(i,j)=square/1001;

        
    end
end

W=zeros(1,10);
B=zeros(1,10);
R=zeros(1,10);

for i=1:1:10

    W(i)=sum(variance(:,i))/3;
    square=0;
    mean_B=sum(Mb(:,i))/3;
    for j=1:1:3
        square=square+(mean_B-Mb(j,i))^2;
    end
    B(i)=square/3*1000;
    R(i)=sqrt((999/1000*W+1/1000*B)/W);
end

% plot(1000:1000:10000,R);
% grid on
% ax=gca;
% ax.Title.String='R(Mb,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='R';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;
% 