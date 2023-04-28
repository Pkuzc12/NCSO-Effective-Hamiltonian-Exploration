clc;
clear all;
close all;



T=10;
size=128;
times=8000;
CorAmpb=zeros(10,10);
CorAmpa=zeros(10,10);
for n=10:1:10

for J=1:1:10
    J
    for leng=1:1:10
        tic
        leng
        CorrelationAmplitudeb=zeros(1,size);
        CorrelationAmplitudea=zeros(1,size);
    
    parfor l=1:size
        [lattice]=latticeGrt(n);
    for i=1:1:times
        CorrelationAmplitudeb(l)=CorrelationAmplitudeb(l)+CA(lattice,leng,1);
        CorrelationAmplitudea(l)=CorrelationAmplitudea(l)+CA(lattice,leng,0);
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
    CorAmpb(J,leng)=sum(CorrelationAmplitudeb)/(size*times);
    CorAmpa(J,leng)=sum(CorrelationAmplitudea)/(size*times);

    end
end

end


save myresult.mat