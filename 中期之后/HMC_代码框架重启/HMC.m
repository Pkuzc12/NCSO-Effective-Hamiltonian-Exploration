clc;
clear all;
close all;

T=10;
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

Mb=zeros(10,100);
variance=zeros(10,100);
IACF=zeros(10,100);

for i=1:1:10

    X=zeros(n*n*4,1001);

    for j=1:1:100

        tic

        i
        j
        

        if j>1
            X_temp=X(:,1001);
        else
            X_temp=X_Grt(n);
        end

        X=zeros(n*n*4,1001);
        X(:,1)=X_temp;
        x=X(:,1);

        for k=1:1:1000


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

        Mb_temp=zeros(1,1001);

        for k=1:1:1001
            Mb_temp(k)=calculateMb(X(:,k),n);
        end

        Mb(i,j)=sum(Mb_temp)/1001;;
        square=0;
        for k=1:1:1001
            square=square+(Mb_temp(k)-Mb(i,j))^2;
        end
        variance(i,j)=square/1001;

        ACF=zeros(1,1001);

        for s=1:1:1000
            numerator=0;
            denominator=0;
            for t=1:1:(1001-s)
                numerator=numerator+(Mb_temp(t)-Mb(i,j))*(Mb_temp(t+s)-Mb(i,j));
                denominator=denominator+(Mb_temp(t)-Mb(i,j))^2;
            end
            ACF(s)=numerator/denominator;
        end

        IACF_temp=ACF(1);

        for s=2:1:1000
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

W=zeros(1,100);
B=zeros(1,100);
R=zeros(1,100);

for i=1:1:100

    W(i)=sum(variance(:,i))/10;
    square=0;
    mean_B=sum(Mb(:,i))/10;
    for j=1:1:10
        square=square+(mean_B-Mb(j,i))^2;
    end
    B(i)=square/10*1000;
    R(i)=sqrt((999/1000*W+1/1000*B)/W);
end

mean_Mb=zeros(1,100);

for i=1:1:100
    mean_Mb(i)=sum(Mb,1)/10;
end

mean_IACF=zeros(1,100);

for i=1:1:100
    mean_IACF(i)=sum(IACF,1)/10;
end

save Everything.mat

% plot(1000:1000:100000,mean_IACF);
% grid on
% ax=gca;
% ax.Title.String='自相关时间(Mb,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='IACF';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;

% plot(1000:1000:100000,mean_Mb);
% grid on
% ax=gca;
% ax.Title.String='运行时对比检验(Mb,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='Mb';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;

% plot(1000:1000:100000,R);
% grid on
% ax=gca;
% ax.Title.String='R(Mb,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='R';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;