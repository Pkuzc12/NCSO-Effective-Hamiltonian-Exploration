clc;
clear all;
close all;


J=3;
size=255;
times=4000;
CorAmpB=zeros(10,20);
n=20;


for T=1:1:10
    T
    for leng=1:1:20
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