clc;
clear all;
close all;


T=10;
size=8;
times=1;
n=10;
Mb=zeros(1,60);
Ma=zeros(1,60);


for J=3.1:0.1:9
    tic
    J

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
                [deltaE]=calculateDeltaEb(latticenew,lattice,x,y,1,J);
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
                [deltaE]=calculateDeltaEb(latticenew,lattice,x,y,0,J);
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
                [deltaE]=calculateDeltaEa(latticenew,lattice,x,y,1,J);
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
                [deltaE]=calculateDeltaEa(latticenew,lattice,x,y,0,J);
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
    Mb(int32((J-3)/0.1))=sum(MMb)/(size*times);
    Ma(int32((J-3)/0.1))=sum(MMa)/(size*times);

end



save myresult.mat