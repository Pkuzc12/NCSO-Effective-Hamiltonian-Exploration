clc;
clear all;
close all;


size=127;
times=8000;
n=5;
Mb=zeros(3,3,3,10);
Ma=zeros(3,3,3,10);

for J1=-3.2:0.2:-2.8
    J1
for J2=-0.4:0.1:-0.2
    J2
for J3=0.4:0.3:1
    J3
for T=0.5:1:9.5
    tic
    T

    MMb=zeros(1,size);
    MMa=zeros(1,size);
    
    parfor l=1:size
        [lattice]=latticeGrt(n);
    for i=1:1:times
        MMb(l)=MMb(l)+calculateMb(lattice);
        for x=1:1:n
            for y=1:1:n
                randi=rand(2,1);
                latticenew=lattice;
                latticenew(x,y).left.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi),sin(randi(2)*pi)*sin(randi(1)*2*pi),cos(randi(2)*pi)];
                [deltaE]=calculateDeltaEb(latticenew,lattice,x,y,1,J1,-5.4-J1,J2,0.1-(J2+0.3)/2,J3);
                if deltaE<0
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*T))
                        lattice=latticenew;
                    end
                end
            end
        end
        for x=1:1:n
            for y=1:1:n
                randi=rand(2,1);
                latticenew=lattice;
                latticenew(x,y).right.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi),sin(randi(2)*pi)*sin(randi(1)*2*pi),cos(randi(2)*pi)];
                [deltaE]=calculateDeltaEb(latticenew,lattice,x,y,0,J1,-5.4-J1,J2,0.1-(J2+0.3)/2,J3);
                if deltaE<0
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*T))
                        lattice=latticenew;
                    end
                end
            end
        end
    end
    end


    parfor l=1:size
        [lattice]=latticeGrt(n);
    for i=1:1:times
        MMa(l)=MMa(l)+calculateMa(lattice);
        for x=1:1:n
            for y=1:1:n
                randi=rand(2,1);
                latticenew=lattice;
                latticenew(x,y).left.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi),sin(randi(2)*pi)*sin(randi(1)*2*pi),cos(randi(2)*pi)];
                [deltaE]=calculateDeltaEa(latticenew,lattice,x,y,1,J1,-5.4-J1,J2,0.1-(J2+0.3)/2,J3);
                if deltaE<0
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*T))
                        lattice=latticenew;
                    end
                end
            end
        end
        for x=1:1:n
            for y=1:1:n
                randi=rand(2,1);
                latticenew=lattice;
                latticenew(x,y).right.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi),sin(randi(2)*pi)*sin(randi(1)*2*pi),cos(randi(2)*pi)];
                [deltaE]=calculateDeltaEa(latticenew,lattice,x,y,0,J1,-5.4-J1,J2,0.1-(J2+0.3)/2,J3);
                if deltaE<0
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*T))
                        lattice=latticenew;
                    end
                end
            end
        end
    end
    end

    toc
    Mb(int32(J1*5+17),int32(J2*10+5),int32((J3-0.1)/3*10),int32(T+0.5))=sum(MMb)/(size*times);
    Ma(int32(J1*5+17),int32(J2*10+5),int32((J3-0.1)/3*10),int32(T+0.5))=sum(MMa)/(size*times);

end
end
end
end


save myresult.mat
% x=1:1:10;
% plot(x,ratio);
% grid on
% ax=gca;
% ax.Title.String='ratio versus T(n=10,第二近邻)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='T';
% ax.YLabel.String='ratio';
% ax.XLabel.FontSize=12;
% ax.YLabel.FontSize=12;