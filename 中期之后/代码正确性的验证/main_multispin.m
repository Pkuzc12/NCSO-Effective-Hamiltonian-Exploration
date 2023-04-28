clc;
clear all;
close all;


times=100; %预热游走次数
n=4; %晶格菱形边长
numofT=8; %温度点个数

B=-1.158;
D=0.872;
K=-0.178;
Kp=0;
G=-0.025;
Gp=0;
Gs=0.3363;
Gps=0;
field=-1;
J1=-3.08;
J1p=-2.24;
J2=-0.4;
J2p=0.023;
J3=0.3; %参数

tic

parfor T=1:2*numofT %不同温度下的预热

    if T <= numofT

    temperature=T-0.5;
    
    lattice=latticeGrt(n);

    for i=1:1:times

        loc=randi([1,n],1,2);
        leftflag=randi([0,1],1);
        angle=rand(2,1);
        theta=acos(angle(1)*2-1);
        varphi=angle(2)*2*pi;
        latticenew=lattice;
        if leftflag
        latticenew(loc(1),loc(2)).left.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
        [deltaE]=calculateDeltaEb(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field); %计算update的deltaE
                if deltaE<0
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*temperature))
                        lattice=latticenew; %判断是否接受
                    end
                end
        else
            
            latticenew(loc(1),loc(2)).right.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
            [deltaE]=calculateDeltaEb(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field); %计算update的deltaE
                if deltaE<0
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*temperature))
                        lattice=latticenew; %判断是否接受
                    end
                end

        end
    end

    for x=1:1:n
        for y=1:1:n
            latticeT(T,x,y)=lattice(x,y);
        end
    end

    else

    temperature=T-numofT-0.5;
    
    lattice=latticeGrt(n);

    for i=1:1:times

        loc=randi([1,n],1,2);
        leftflag=randi([0,1],1);
        angle=rand(2,1);
        theta=acos(angle(1)*2-1);
        varphi=angle(2)*2*pi;
        latticenew=lattice;
        if leftflag
        latticenew(loc(1),loc(2)).left.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
        [deltaE]=calculateDeltaEa(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field); %计算update的deltaE
                if deltaE<0
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*temperature))
                        lattice=latticenew; %判断是否接受
                    end
                end
        else
            
            latticenew(loc(1),loc(2)).right.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
            [deltaE]=calculateDeltaEa(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field); %计算update的deltaE
                if deltaE<0
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*temperature))
                        lattice=latticenew; %判断是否接受
                    end
                end

        end
    end

    for x=1:1:n
        for y=1:1:n
            latticeT(T,x,y)=lattice(x,y);
        end
    end

    end

end

M=zeros(1,2*numofT);

parfor T=1:2*numofT %不同温度下的游走与统计

    MMb=zeros(1,1+times);
    MMa=zeros(1,1+times);

    if T <= numofT
        
    for x=1:1:n
for y=1:1:n

    lattice(x,y)=latticeT(T,x,y);
end
    end
    temperature=T-0.5;
    MMb(1)=calculateMb(lattice,n);

    for i=1:1:times

        loc=randi([1,n],1,2);
        leftflag=randi([0,1],1);
        angle=rand(2,1);
        theta=acos(angle(1)*2-1);
        varphi=angle(2)*2*pi;
        latticenew=lattice;
        if leftflag
        latticenew(loc(1),loc(2)).left.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
        [deltaE]=calculateDeltaEb(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field); %计算update的deltaE
                if deltaE<0
                    MMb(i+1)=MMb(i)-lattice(loc(1),loc(2)).left.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(2)/(n*n*2);
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*temperature))
                         MMb(i+1)=MMb(i)-lattice(loc(1),loc(2)).left.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(2)/(n*n*2);
                        lattice=latticenew; %判断是否接受
                    else
                        MMb(i+1)=MMb(i);
                    end
                end
        else
            
            latticenew(loc(1),loc(2)).right.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
            [deltaE]=calculateDeltaEb(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field); %计算update的deltaE
                if deltaE<0
                    MMb(i+1)=MMb(i)-lattice(loc(1),loc(2)).right.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).right.orientation(2)/(n*n*2);
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*temperature))
                         MMb(i+1)=MMb(i)-lattice(loc(1),loc(2)).right.orientation(2)/(n*n*2)+latticenew(loc(1),loc(2)).right.orientation(2)/(n*n*2);
                        lattice=latticenew; %判断是否接受
                    else
                        MMb(i+1)=MMb(i);
                    end
                end

        end


    end
    M(T)=sum(MMb)/(1+times);

    else

       

    temperature=T-numofT-0.5;
    for x=1:1:n
for y=1:1:n
    lattice(x,y)=latticeT(T,x,y);
end
    end
    MMa(1)=calculateMa(lattice,n);


    for i=1:1:times

        loc=randi([1,n],1,2);
        leftflag=randi([0,1],1);
        angle=rand(2,1);
        theta=acos(angle(1)*2-1);
        varphi=angle(2)*2*pi;
        latticenew=lattice;
        if leftflag
        latticenew(loc(1),loc(2)).left.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
        [deltaE]=calculateDeltaEa(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field); %计算update的deltaE
                if deltaE<0
                    MMa(i+1)=MMa(i)-lattice(loc(1),loc(2)).left.orientation(1)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(1)/(n*n*2);
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*temperature))
                        MMa(i+1)=MMa(i)-lattice(loc(1),loc(2)).left.orientation(1)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(1)/(n*n*2);
                        lattice=latticenew; %判断是否接受
                    else
                        MMa(i+1)=MMa(i);
                    end
                end
        else
            
            latticenew(loc(1),loc(2)).right.orientation=[sin(theta)*cos(varphi);sin(theta)*sin(varphi);cos(theta)];
            [deltaE]=calculateDeltaEa(latticenew,lattice,loc(1),loc(2),leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field); %计算update的deltaE
                if deltaE<0
                    MMa(i+1)=MMa(i)-lattice(loc(1),loc(2)).left.orientation(1)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(1)/(n*n*2);
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*temperature))
                        MMa(i+1)=MMa(i)-lattice(loc(1),loc(2)).left.orientation(1)/(n*n*2)+latticenew(loc(1),loc(2)).left.orientation(1)/(n*n*2);
                        lattice=latticenew; %判断是否接受
                    else
                        MMa(i+1)=MMa(i);
                    end
                end

        end
    end
    M(T)=sum(MMa)/(1+times);
    end
    
    

end


toc

save myresult.mat