clc;
clear all;
close all;


J=3;
size=8;
times=100;
CorAmpB=zeros(1,10);
n=10;


for T=100:1:100
    T
    for leng=1:1:10
        tic
        leng
        CorrelationAmplitudeBeta=zeros(1,size);
    
    parfor l=1:size
        [lattice]=latticeGrt(n);
    for i=1:1:times
        CorrelationAmplitudeBeta(l)=CorrelationAmplitudeBeta(l)+CA_beta(lattice,leng);
        for x=1:1:n
            for y=1:1:n
                randi=rand(2,1);
                latticenew=lattice;
                latticenew(x,y).left.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi),sin(randi(2)*pi)*sin(randi(1)*2*pi),cos(randi(2)*pi)];
                [deltaE]=calculateDeltaE(latticenew,lattice,x,y,1,J);
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
                [deltaE]=calculateDeltaE(latticenew,lattice,x,y,0,J);
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
    CorAmpB(T,leng)=sum(CorrelationAmplitudeBeta)/(size*times);

    end
end



save myresult.mat

% [x,y]=meshgrid(1:1:15,1:1:10);
% [xq,yq]=meshgrid(1:0.1:15,1:0.1:10);
% Cluster_interp=interp2(x,y,Cluster,xq,yq,'cubic');
% s=surf(xq,yq,Cluster_interp)
% contour(xq,yq,Cluster_interp,[1/exp(1),1/exp(1)])
% ax=gca;
% ax.Title.String='CorrelationAmplitude vs J&length (when n=30)';
% ax.Title.FontSize=15;
% ax.Title.FontWeight='Bold';
% ax.XLabel.String='length';
% ax.YLabel.String='J';
% ax.ZLabel.String='CorrelationAmplitude(unit=hbar^2/4)';
% ax.XLabel.FontSize=11;
% ax.YLabel.FontSize=11;
% ax.ZLabel.FontSize=11;
% ax.ZLim=[0,1];
% ax.XTick=[0:1:15];
% s.EdgeColor='None';
% colorbar