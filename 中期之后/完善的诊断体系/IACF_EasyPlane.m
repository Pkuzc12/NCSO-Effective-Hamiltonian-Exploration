clear all;
close all;
clc;

T=10;

X=zeros(1,100);
Y=zeros(1,100);
IACF=zeros(1,100);

for i=1:1:100

    i
    tic

    if i>1
        XX_temp=XX(10001);
        YY_temp=YY(10001);
    else
        XX_temp=0;
        YY_temp=0;
    end
    XX=zeros(1,10001);
    YY=zeros(1,10001);
    XX(1)=XX_temp;
    YY(1)=YY_temp;
    x=XX(1);
    y=YY(1);

    for j=1:1:10000
        
        loc=randi([-10,10],1,2);
        [deltaE]=Calculate_DeltaE_Easy_Plane(x,y,loc(1),loc(2));
        if deltaE<0
            XX(j+1)=loc(1);
            YY(j+1)=loc(2);
            x=loc(1);
            y=loc(2);
        else
            prob=rand(1,1);
            if prob<exp(-deltaE/(0.086*T))
                XX(j+1)=loc(1);
                YY(j+1)=loc(2);
                x=loc(1);
                y=loc(2);
            else
                XX(j+1)=XX(j);
                YY(j+1)=YY(j);
            end
        end
    end

    X(i)=sum(XX)/10001;
    Y(i)=sum(YY)/10001;
    ACF=zeros(1,10001);

    for j=1:1:10000
        numerator=0;
        denominator=0;
        for k=1:1:(10001-j)
            numerator=numerator+(XX(k)-XX(i))*(XX(k+j)-X(i));
            denominator=denominator+(XX(k)-X(i))^2;
        end
        ACF(j)=numerator/denominator;
    end

    IACF_temp=ACF(1);

    for j=2:1:10000
        if abs(ACF(j))<(abs(IACF_temp)*0.01)
            break;
        else
            IACF_temp=IACF_temp+ACF(j);
        end
    end
    IACF(i)=IACF_temp;

    toc
end

% plot(10000:10000:1000000,X);
% grid on
% ax=gca;
% ax.Title.String='运行时对比检验(EasyPlane,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='X';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;

% plot(10000:10000:1000000,IACF);
% grid on
% ax=gca;
% ax.Title.String='自相关时间(EasyPlane,T=10K)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='IACF';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;