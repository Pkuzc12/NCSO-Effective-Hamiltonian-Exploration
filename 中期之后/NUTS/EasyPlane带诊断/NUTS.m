clear all;
close all;
clc

rng(60,'twister');

T=5;

delta=0.8;

times_each_stage=1000;
stage_each_chain=100;
chain=8;

gamma=0.05;
t0=10;
kappa=0.75;

mean=zeros(chain,stage_each_chain);
variance=zeros(chain,stage_each_chain);
IACF=zeros(chain,stage_each_chain);

f=waitbar(0,num2str(0)+"%");

for k=1:1:chain

for ash=1:1:stage_each_chain

    tic

    percent=((k-1)*stage_each_chain+ash)/(chain*stage_each_chain);
    f=waitbar(percent,f,num2str(percent*100,2)+"%");

    if ash>1

        X_stage_temp=X(:,times_each_stage);
        epsilon_stage_temp=epsilon(times_each_stage);
        epsilon_bar_stage_temp=epsilon_bar(times_each_stage);
        H_bar_stage_temp=H_bar(times_each_stage);

    else

        X_stage_temp=randn(2,1);
        epsilon_stage_temp=FindReasonableEpsilon(X_stage_temp,T);
        epsilon_bar_stage_temp=1;
        H_bar_stage_temp=0;

    end

    X=zeros(2,times_each_stage);
    epsilon=zeros(1,times_each_stage);
    epsilon_bar=zeros(1,times_each_stage);
    H_bar=zeros(1,times_each_stage);

    X(:,1)=X_stage_temp;
    epsilon(1)=epsilon_stage_temp;
    epsilon_bar(1)=epsilon_bar_stage_temp;
    H_bar(1)=H_bar_stage_temp;

    mu=log(10*epsilon(1));

for i=2:1:times_each_stage

    p0=randn(2,1);

    u=rand(1)*Boltzmann(X(:,i-1),T);

    x_neg=X(:,i-1);
    x_pos=X(:,i-1);
    p_neg=p0;
    p_pos=p0;
    j=1;
    X(:,i)=X(:,i-1);
    n=1;
    s=1;

    v=zeros(1,10^6);

    while s==1

        v(j)=randi(2)*2-3;

        if v(j)==-1

            [x_neg,p_neg,~,~,x_temp,n_temp,s_temp,alpha,n_alpha]=BuildTree(x_neg,p_neg,u,v(j),j,epsilon(i-1),X(:,i-1),p0,T);
        else
            [~,~,x_pos,p_pos,x_temp,n_temp,s_temp,alpha,n_alpha]=BuildTree(x_pos,p_pos,u,v(j),j,epsilon(i-1),X(:,i-1),p0,T);
        end

        if s_temp==1

            if rand(1)<(n_temp/n)

                X(:,i)=x_temp;

            end

        end

        n=n+n_temp;
        s=s_temp*(dot((x_pos-x_neg),p_neg)>=0)*(dot((x_pos-x_neg),p_pos)>=0);
        j=j+1;

    end

    H_bar(i)=(1-1/(i+t0))*H_bar(i-1)+1/(i+t0)*(delta-alpha/n_alpha);
    epsilon(i)=exp(mu-sqrt(i)/gamma*H_bar(i));
    epsilon_bar(i)=exp(i^(-kappa)*log(epsilon(i))+(1-i^(-kappa))*log(epsilon_bar(i-1)));

end

mean(k,ash)=sum(X(1,:))/times_each_stage;
square=0;

for i=1:1:times_each_stage

    square=square+(X(1,i)-mean(k,ash))^2;

end

variance(k,ash)=square/times_each_stage;

ACF=zeros(1,times_each_stage);

for i=1:1:times_each_stage

    numerator=0;

    for sb=1:1:(times_each_stage-i)

        numerator=numerator+(X(1,sb)-mean(k,ash))*(X(1,sb+i)-mean(k,ash));
    end

    ACF(i)=numerator/square;

end

IACF_temp=1+2*ACF(1);

for i=1:1:times_each_stage

    if abs(2*ACF(i))<(abs(IACF_temp)*0.01)
        
        break;

    else

        IACF_temp=IACF_temp+2*ACF(i);

    end

end

IACF(k,ash)=IACF_temp;

toc

end

end

W=zeros(1,stage_each_chain);
B=zeros(1,stage_each_chain);
R=zeros(1,stage_each_chain);

for i=1:1:stage_each_chain

    W(i)=sum(variance(:,i))/chain;
    square=0;
    mean_B=sum(mean(:,i))/chain;
    for j=1:1:chain
        square=square+(mean_B-mean(j,i))^2;
    end
    B(i)=square/chain*times_each_stage;
    R(i)=sqrt(((times_each_stage-1)/times_each_stage*W+1/times_each_stage*B)/W);
end

close(f);

mean_mean=sum(mean,1)/chain;
mean_IACF=sum(IACF,1)/chain;

save Everything.mat

% plot(times_each_stage:times_each_stage:times_each_stage*stage_each_chain,mean_IACF);
% grid on
% ax=gca;
% ax.Title.String='自相关时间(EasyPlane,kT=5)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='IACF';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;

% plot(times_each_stage:times_each_stage:times_each_stage*stage_each_chain,mean_mean);
% grid on
% ax=gca;
% ax.Title.String='运行时对比检验(EasyPlane,kT=5)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='x';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;

% plot(times_each_stage:times_each_stage:times_each_stage*stage_each_chain,R);
% grid on
% ax=gca;
% ax.Title.String='R(EasyPlane,kT=5)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='R';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;