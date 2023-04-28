clear all;
close all;
clc

rng(60,'twister');

T=2;

delta=0.8;
times_total=10000;
times_adapt=10000;

X=zeros(2,times_total);
epsilon=zeros(1,times_total);
epsilon_bar=zeros(1,times_total);
H_bar=zeros(1,times_adapt);

X(:,1)=randn(2,1);
epsilon(1)=FindReasonableEpsilon(X(:,1),T);
mu=log(10*epsilon(1));
epsilon_bar(1)=1;
H_bar(1)=0;
gamma=0.05;
t0=10;
kappa=0.75;

% f=waitbar(0,num2str(0)+"%");

for i=2:1:times_total

    percent=i/times_total;

%     f=waitbar(percent,f,num2str(percent*100)+"%");

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

    if i<=times_adapt

        H_bar(i)=(1-1/(i+t0))*H_bar(i-1)+1/(i+t0)*(delta-alpha/n_alpha);
        epsilon(i)=exp(mu-sqrt(i)/gamma*H_bar(i));
        epsilon_bar(i)=exp(i^(-kappa)*log(epsilon(i))+(1-i^(-kappa))*log(epsilon_bar(i-1)));

    else

        epsilon(i)=epsilon_bar(times_adapt);

    end



end

% close(f);

save Everything.mat