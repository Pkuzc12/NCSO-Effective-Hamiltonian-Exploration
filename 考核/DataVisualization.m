Data=readmatrix('Datafile.txt');%读入

Data_validity=isnan(Data);%找到nan的位置

j=1;

for i=1:size(Data,1)
    if (sum(Data_validity(i,:))==0)&&(abs(Data(i,3))<1.1)&&(Data(i,4)>0)&&(Data(i,4)<4)
        Data_valid(j,1)=Data(i,3);
        Data_valid(j,2)=Data(i,4);
        Data_valid(j,3)=Data(i,1);
        Data_valid(j,4)=Data(i,2);
        j=j+1;
    end
end%找到不含nan的,在坐标显示区域的数据们,将前四列分别存入Data_valid

sortrows(Data_valid);%排序

for i=1:88%用scatter发现数据分布很有规则,K宽88个,DeltaEnergy长80个的矩阵
    for j=1:80
        X(i)=Data_valid(80*i,1);
        Y(j)=Data_valid(80*i-80+j,2);
        Z(j,i)=Data_valid(80*i-80+j,3);
    end
end%获得点位值与点的坐标

Z_interp=interp2(Z,5);%色图插值

for i=1:size(Data_valid,1)
    if abs(Data_valid(i,1)-0.0125)<0.001
        break;
    end
end
loc_exm=i;%找到K=0.0125附近的一列

len_exm=0;
for i=1:size(Data_valid,1)
    if abs(Data_valid(i,1)-0.0125)<0.001
        len_exm=len_exm+1;
    end
end%获得这列的长度,其实已知80

for i=loc_exm:(loc_exm+len_exm-1)
    Y_example(i-loc_exm+1)=Data_valid(i,2);
    Z_example(i-loc_exm+1)=Data_valid(i,3);
    error(i-loc_exm+1)=Data_valid(i,4);
end%获得这一列的intensity和error以及Delta Energy

%---------------------------------------------------图一

subplot(1,2,1);
imagesc(X,Y,Z_interp);

ax1=gca;

ax1.FontSize=15;

ax1.XTick=[-1,-0.5,0,0.5,1];
ax1.YTick=[0:0.5:4];%刻度

ax1.XLim=[-1.1,1.1];
ax1.YLim=[0,4];
ax1.YDir='normal';%标尺

grid on;
ax1.Layer='top';
ax1.GridAlpha=0.5;%网格线

ax1.Title.String='Intensity map';
ax1.Title.FontSize=21;
ax1.Title.FontWeight='Bold';
ax1.XLabel.String='K(r,l,u)';
ax1.YLabel.String='Delta Energy(meV)';
ax1.XLabel.FontSize=17;
ax1.YLabel.FontSize=17;%标签

pbaspect([6.25 10 1]);%刻度尺量的

caxis([0,0.005]);
colormap(turbo);
colorbar;%色图设置

%------------------------------------------------------图二

subplot(1,2,2);
errorbar(Y_example,Z_example,error,'-ko','MarkerFaceColor','k','LineWidth',0.3);

ax2=gca;

ax2.FontSize=15;

ax2.XTick=[0:1:4];
ax2.YTick=[-0.001:0.001:0.007];%刻度

ax2.XLim=[0,4];
ax2.YLim=[-0.001,0.007];
ax2.YDir='normal';%标尺

grid on;%网格线

ax2.Title.String='Cut at K=0.0125';
ax2.Title.FontSize=21;
ax2.Title.FontWeight='Bold';
ax2.XLabel.String='Delta Energy(meV)';
ax2.YLabel.String='Intensity(arbitrary units)';
ax2.XLabel.FontSize=17;
ax2.YLabel.FontSize=17;%标签

pbaspect([7.3 10 1]);%刻度尺量的

%手动保存图片