clc;
clear all;
close all;

T=10;

mean=zeros(10,100);
variance=zeros(10,100);

for i=1:1:10

    for j=1:1:100

        tic
        j

        if j>1
            X_temp=X(10001);
            Y_temp=Y(10001);
        else
            X_temp=randi([-10,10],1,1);
            Y_temp=randi([-10,10],1,1);
        end

        X=zeros(1,10001);
        Y=zeros(1,10001);
        X(1)=X_temp;
        Y(1)=Y_temp;
        x=X(1);
        y=Y(1);

        for k=1:1:10000

            loc=randi([-10,10],1,2);
            [deltaE]=Calculate_DeltaE_Easy_Plane(x,y,loc(1),loc(2));
            if deltaE<0
                X(k+1)=loc(1);
                Y(k+1)=loc(2);
                x=loc(1);
                y=loc(2);
            else
                prob=rand(1,1);
                if prob<exp(-deltaE/(0.086*T))
                    X(k+1)=loc(1);
                    Y(k+1)=loc(2);
                    x=loc(1);
                    y=loc(2);
                else
                    X(k+1)=X(k);
                    Y(k+1)=Y(k);
                end
            end
        end

        mean(i,j)=sum(X)/10001;
        square=0;
        for k=1:1:10001
            square=square+(X(k)-mean(i,j))^2;
        end
        variance(i,j)=square/10001;

        toc

    end
end

W=zeros(1,100);
B=zeros(1,100);
R=zeros(1,100);

for i=1:1:100

    W(i)=sum(variance(:,i))/10;
    square=0;
    mean_B=sum(mean(:,i))/10;
    for j=1:1:10
        square=square+(mean_B-mean(j,i))^2;
    end
    B(i)=square/10*10000;
    R(i)=sqrt((9999/10000*W+1/10000*B)/W);
end


% plot(10000:10000:1000000,R);
% grid on
% ax=gca;
% ax.Title.String='R(EasyPlane,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='R';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;