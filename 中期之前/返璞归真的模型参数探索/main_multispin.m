clc;
clear all;
close all;


size=127; %并行核心数目
times=8000; %单个核心循环次数
n=4; %晶格菱形边长
Mb=zeros(10,10); %磁化强度记录空间
% Ma=zeros(3,3,10);

B=0;
D=0;
Kp=0;
G=0;
Gp=0;
Gs=0;
Gps=0;
J1=0;
J1p=0;
J2=0;
J2p=0;
J3=0; %参数

for varphi=0:pi/5:9*pi/5

    K=cos(varphi);
    field=sin(varphi);
K
field %不同参数下的数值模拟
    

for T=0.5:1:9.5 %不同温度下的数值模拟
    tic

    MMb=zeros(1,size); %每个并行核心数值模拟的磁化强度记录空间
    
    parfor l=1:size
        [lattice]=latticeGrt(n); %构建晶格
    for i=1:1:times
        MMb(l)=MMb(l)+calculateMb(lattice); %磁化强度开始记录
        for x=1:1:n
            for y=1:1:n %每个菱形格子的左自旋update
                randi=rand(2,1);
                latticenew=lattice;
                latticenew(x,y).left.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi);sin(randi(2)*pi)*sin(randi(1)*2*pi);cos(randi(2)*pi)];
                [deltaE]=calculateDeltaEb(latticenew,lattice,x,y,1,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field); %计算update的deltaE
                if deltaE<0
                    lattice=latticenew;
                else
                    prob=rand(1,1);
                    if prob<exp(-deltaE/(0.086*T))
                        lattice=latticenew; %判断是否接受
                    end
                end
            end
        end
        for x=1:1:n
            for y=1:1:n %每个菱形格子的右自旋update
                randi=rand(2,1);
                latticenew=lattice;
                latticenew(x,y).right.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi);sin(randi(2)*pi)*sin(randi(1)*2*pi);cos(randi(2)*pi)];
                [deltaE]=calculateDeltaEb(latticenew,lattice,x,y,0,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field);
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


%     parfor l=1:size
%         [lattice]=latticeGrt(n);
%     for i=1:1:times
%         MMa(l)=MMa(l)+calculateMa(lattice);
%         for x=1:1:n
%             for y=1:1:n
%                 randi=rand(2,1);
%                 latticenew=lattice;
%                 latticenew(x,y).left.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi);sin(randi(2)*pi)*sin(randi(1)*2*pi);cos(randi(2)*pi)];
%                 [deltaE]=calculateDeltaEa(latticenew,lattice,x,y,1,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field);
%                 if deltaE<0
%                     lattice=latticenew;
%                 else
%                     prob=rand(1,1);
%                     if prob<exp(-deltaE/(0.086*T))
%                         lattice=latticenew;
%                     end
%                 end
%             end
%         end
%         for x=1:1:n
%             for y=1:1:n
%                 randi=rand(2,1);
%                 latticenew=lattice;
%                 latticenew(x,y).right.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi);sin(randi(2)*pi)*sin(randi(1)*2*pi);cos(randi(2)*pi)];
%                 [deltaE]=calculateDeltaEa(latticenew,lattice,x,y,0,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field);
%                 if deltaE<0
%                     lattice=latticenew;
%                 else
%                     prob=rand(1,1);
%                     if prob<exp(-deltaE/(0.086*T))
%                         lattice=latticenew;
%                     end
%                 end
%             end
%         end
%     end
%     end

    toc
    Mb(int32((varphi*5/pi)+1),int32(T+0.5))=sum(MMb)/(size*times); %并行结果汇总
%     Ma(int32(J2*10+5),int32((J3)*5),int32(T+0.5))=sum(MMa)/(size*times);

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