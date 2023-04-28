function [flag] = NUTS_b(parameter,otherparameter,Delta_max)

rng(5,'twister');

[kT,size,times_each_stage,stage_each_chain,chain]=deal(otherparameter(1),otherparameter(2),otherparameter(3),otherparameter(4),otherparameter(5));

chart=ChartGrt(size);
ES=GradEbHelper(chart,size,parameter);

delta=0.8;
gamma=0.05;
t0=10;
kappa=0.75;

Mb=zeros(chain,stage_each_chain);
variance=zeros(chain,stage_each_chain);

f=waitbar(0,num2str(0)+"%,Delta max="+num2str(Delta_max,3));

for i=1:chain

    for j=1:1:stage_each_chain

        percent=((i-1)*stage_each_chain+j)/(chain*stage_each_chain)*100;
        f=waitbar(percent/100,f,num2str(percent,3)+"%,Delta max="+num2str(Delta_max,3));

        if j>1

            X_stage_temp=X(:,times_each_stage);
            epsilon_stage_temp=epsilon(times_each_stage);
            epsilon_bar_stage_temp=epsilon_bar(times_each_stage);
            H_bar_stage_temp=H_bar(times_each_stage);

        else

            X_stage_temp=FirstX(size);
            epsilon_stage_temp=FindReasonableEpsilon(X_stage_temp,kT,size,ES,parameter);
            epsilon_bar_stage_temp=1;
            H_bar_stage_temp=0;

        end

        X=zeros(size*size*4,times_each_stage);
        epsilon=zeros(1,times_each_stage);
        epsilon_bar=zeros(1,times_each_stage);
        H_bar=zeros(1,times_each_stage);

        X(:,1)=X_stage_temp;
        epsilon(1)=epsilon_stage_temp;
        epsilon_bar(1)=epsilon_bar_stage_temp;
        H_bar(1)=H_bar_stage_temp;

        mu=log(10*epsilon(1));

        stage_start=tic;

        for k=2:1:times_each_stage

            time_start=tic;

            p0=randn(size*size*4,1);
            u=rand(1)*Boltzmann(X(:,k-1),kT,size,ES,parameter);

            x_neg=X(:,k-1);
            x_pos=X(:,k-1);
            p_neg=p0;
            p_pos=p0;
            t=1;
            X(:,k)=X(:,k-1);
            n=1;
            s=1;
            v=zeros(1,10^6);

            while s==1

                v(t)=randi(2)*2-3;

                if v(t)==-1

                    [x_neg,p_neg,~,~,x_temp,n_temp,s_temp,alpha,n_alpha]=BuildTree(x_neg,p_neg,u,v(t),t,epsilon(k-1),X(:,k-1),p0,kT,size,ES,parameter,Delta_max);

                else

                    [~,~,x_pos,p_pos,x_temp,n_temp,s_temp,alpha,n_alpha]=BuildTree(x_pos,p_pos,u,v(t),t,epsilon(k-1),X(:,k-1),p0,kT,size,ES,parameter,Delta_max);

                end

                if s_temp==1

                    if rand(1)<(n_temp/n)

                        X(:,k)=x_temp;

                    end

                end

                n=n+n_temp;
                s=s_temp*(dot((x_pos-x_neg),p_neg)>=0)*(dot((x_pos-x_neg),p_pos)>=0);
                t=t+1;

            end

            H_bar(k)=(1-1/(k+t0))*H_bar(k-1)+1/(k+t0)*(delta-alpha/n_alpha);
            epsilon(k)=exp(mu-sqrt(k)/gamma*H_bar(k));
            epsilon_bar(k)=exp(k^(-kappa)*log(epsilon(k))+(1-k^(-kappa))*log(epsilon_bar(k-1)));

            time_cost=toc(time_start);

            if time_cost>30

                flag=0;
                close(f);
                return

            end

        end

        stage_cost=toc(stage_start);

        if stage_cost>30

            flag=0;
            close(f);
            return

        end

        Mb_temp=zeros(1,times_each_stage);

        for k=1:1:times_each_stage

            Mb_temp(k)=CalculateMb(X(:,k),size);

        end

        Mb(i,j)=sum(Mb_temp)/times_each_stage;

        square=0;

        for k=1:1:times_each_stage

            square=square+(Mb_temp(k)-Mb(i,j))^2;

        end

        variance(i,j)=square/times_each_stage;

    end

end

W=zeros(1,stage_each_chain);
B=zeros(1,stage_each_chain);
R=zeros(1,stage_each_chain);

for j=1:1:stage_each_chain

    W(j)=sum(variance(:,j))/chain;
    square=0;
    mean_B=sum(Mb(:,j))/chain;

    for i=1:1:chain

        square=square+(mean_B-Mb(i,j))^2;

    end

    B(j)=square/chain*times_each_stage;
    R(j)=sqrt(((times_each_stage-1)/times_each_stage*W+1/times_each_stage*B)/W);

end

close all;
close(f);

plot(times_each_stage:times_each_stage:times_each_stage*stage_each_chain,R);
ax=gca;
ax.Title.String="Delta max="+num2str(Delta_max);

[flag,R_smooth]=RTrendIdentify(R,stage_each_chain);

hold on
plot(times_each_stage:times_each_stage:times_each_stage*stage_each_chain,R_smooth);

end