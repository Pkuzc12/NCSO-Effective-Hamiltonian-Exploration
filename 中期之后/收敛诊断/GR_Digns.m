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

T=10;

Mb=zeros(10,100);
variance=zeros(10,100);

for i=1:1:10

    lattice=latticeGrt(n);

    for j=1:1:100

        tic
        j

        MMb=zeros(1,10001);
        MMb(1)=calculateMb(lattice,n);

        for k=1:1:10000

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
                    MMb(k+1)=MMb(k)-lattice(loc(1),loc(2)).left.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(2)/(n*n*2);
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*T))
                        MMb(k+1)=MMb(k)-lattice(loc(1),loc(2)).left.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(2)/(n*n*2);
                        lattice=latticenew;
                    else
                        MMb(k+1)=MMb(k);
                    end
                end
            else
                latticenew(loc(1),loc(2)).right.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
                [deltaE]=calculateDeltaEb(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field);
                if deltaE<0
                    MMb(k+1)=MMb(k)-lattice(loc(1),loc(2)).right.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).right.orientation(2)/(n*n*2);
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*T))
                        MMb(k+1)=MMb(k)-lattice(loc(1),loc(2)).right.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).right.orientation(2)/(n*n*2);
                        lattice=latticenew;
                    else
                        MMb(k+1)=MMb(k);
                    end
                end
            end
        end

        Mb(i,j)=sum(MMb)/10001;
        square=0;
        for k=1:1:10001
            square=square+(MMb(k)-Mb(i,j))^2;
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
    mean_B=sum(Mb(:,i))/10;
    for j=1:1:10
        square=square+(mean_B-Mb(j,i))^2;
    end
    B(i)=square/10*10000;
    R(i)=sqrt((9999/10000*W+1/10000*B)/W);
end

save GR_Digns.mat

% plot(10000:10000:1000000,R);
% grid on
% ax=gca;
% ax.Title.String='R';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='次数';
% ax.YLabel.String='R';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;