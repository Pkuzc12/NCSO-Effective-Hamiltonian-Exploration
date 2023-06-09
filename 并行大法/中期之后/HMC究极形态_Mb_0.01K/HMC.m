parpool('local',16);

clc;
clear all;
close all;

steps=10000; %采样数
num=1000;%段数
chain=10;%链数

T=0.01;
epsilon=0.1;
L=10;
n=4;

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

parameter=[J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field];

chart=ChartGrt(n);

E_S=grad_Eb_helper(chart,n,parameter);

Mb=zeros(chain,num);
variance=zeros(chain,num);
IACF=zeros(chain,num);

parfor i=1:1:chain

    X=zeros(n*n*4,steps+1);

    for j=1:1:num

        tic

        i
        j
        

        if j>1
            X_temp=X(:,steps+1);
        else
            X_temp=X_Grt(n);
        end

        X=zeros(n*n*4,steps+1);
        X(:,1)=X_temp;
        x=X(:,1);

        for k=1:1:steps


            p=randn(n*n*4,1);
            p=p-0.5*epsilon*grad_Eb(x,n,E_S,field);
            for t=1:1:L
                x=x+epsilon*p;
                p=p-epsilon*grad_Eb(x,n,E_S,field);
            end
            x=x+epsilon*p;

            if rand(1,1)<exp(-(calculateEb(x,n,E_S,field)-calculateEb(X(:,k),n,E_S,field))/(0.086*T))
                X(:,k+1)=x;
            else
                X(:,k+1)=X(:,k);
            end

        end

        Mb_temp=zeros(1,steps+1);

        for k=1:1:(steps+1)
            Mb_temp(k)=calculateMb(X(:,k),n);
        end

        Mb(i,j)=sum(Mb_temp)/(steps+1);
        square=0;
        for k=1:1:(steps+1)
            square=square+(Mb_temp(k)-Mb(i,j))^2;
        end
        variance(i,j)=square/(steps+1);

        ACF=zeros(1,steps+1);

        for s=1:1:steps
            numerator=0;
            denominator=0;
            for t=1:1:(steps+1-s)
                numerator=numerator+(Mb_temp(t)-Mb(i,j))*(Mb_temp(t+s)-Mb(i,j));
                denominator=denominator+(Mb_temp(t)-Mb(i,j))^2;
            end
            ACF(s)=numerator/denominator;
        end

        IACF_temp=ACF(1);

        for s=2:1:steps
            if abs(ACF(j))<(abs(IACF_temp)*0.01)
                break;
            else
                IACF_temp=IACF_temp+ACF(j);
            end
        end

        IACF(i,j)=IACF_temp;

        toc
        
    end
end

W=zeros(1,num);
B=zeros(1,num);
R=zeros(1,num);

for i=1:1:num

    W(i)=sum(variance(:,i))/chain;
    square=0;
    mean_B=sum(Mb(:,i))/chain;
    for j=1:1:chain
        square=square+(mean_B-Mb(j,i))^2;
    end
    B(i)=square/(chain)*steps;
    R(i)=sqrt(((steps-1)/steps*W+1/steps*B)/W);
end

mean_Mb=sum(Mb,1)/chain;

mean_IACF=sum(IACF,1)/chain;

save Everything.mat

% plot(steps:steps:steps*num,mean_IACF);
% grid on
% ax=gca;
% ax.Title.String='自相关时间(Mb,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='IACF';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;

% plot(steps:steps:steps*num,mean_Mb);
% grid on
% ax=gca;
% ax.Title.String='运行时对比检验(Mb,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='Mb';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;

% plot(steps:steps:steps*num,R);
% grid on
% ax=gca;
% ax.Title.String='R(Mb,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='R';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;