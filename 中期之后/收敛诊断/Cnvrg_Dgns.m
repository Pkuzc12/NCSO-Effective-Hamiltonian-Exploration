clc;
clear all;
close all;

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

T=0.01;

lattice=latticeGrt(n);

Mb=zeros(1,100);
IACF=zeros(1,100);

for i=1:1:100

    i
    tic

    MMb=zeros(1,10001);
    MMb(1)=calculateMa(lattice,n);

    for j=1:1:10000

        loc=randi([1,n],1,2);
        leftflag=randi([0,1],1);
        angle=rand(2,1);
        theta=acos(angle(1)*2-1);
        varphi=angle(2)*2*pi;
        latticenew=lattice;
        if leftflag
            latticenew(loc(1),loc(2)).left.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
            [deltaE]=calculateDeltaEb(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field);
            if deltaE<0
                MMb(j+1)=MMb(j)-lattice(loc(1),loc(2)).left.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(2)/(n*n*2);
                lattice=latticenew;
            else
                prob=rand(1,1);
                if prob<exp(-deltaE/(0.086*T))
                    MMb(j+1)=MMb(j)-lattice(loc(1),loc(2)).left.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(2)/(n*n*2);
                    lattice=latticenew;
                else
                    MMb(j+1)=MMb(j);
                end
            end
        else
            latticenew(loc(1),loc(2)).right.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
            [deltaE]=calculateDeltaEb(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field);
            if deltaE<0
                MMb(j+1)=MMb(j)-lattice(loc(1),loc(2)).right.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).right.orientation(2)/(n*n*2);
                lattice=latticenew;
            else
                prob=rand(1,1);
                if prob<exp(-deltaE/(0.086*T))
                    MMb(j+1)=MMb(j)-lattice(loc(1),loc(2)).right.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).right.orientation(2)/(n*n*2);
                    lattice=latticenew;
                else
                    MMb(j+1)=MMb(j);
                end
            end
        end
    end

    Mb(i)=sum(MMb)/10001;
    ACF=zeros(1,10000);

    for j=1:1:10000
        numerator=0;
        denominator=0;
        for k=1:1:(10001-j)
            numerator=numerator+(MMb(k)-Mb(i))*(MMb(k+j)-Mb(i));
            denominator=denominator+(MMb(k)-Mb(i))^2;
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

save Cnvrg.mat


% plot(10000:10000:1000000,Mb);
% grid on
% ax=gca;
% ax.Title.String='运行时对比检验';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='Mb';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;

% plot(10000:10000:1000000,IACF);
% grid on
% ax=gca;
% ax.Title.String='自相关时间';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='IACF';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;