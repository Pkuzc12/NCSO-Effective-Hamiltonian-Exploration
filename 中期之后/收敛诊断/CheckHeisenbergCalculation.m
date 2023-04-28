B=0;
D=0;
K=0;
Kp=0;
G=0;
Gp=0;
Gs=0;
Gps=0;
field=0;
J1=0;
J1p=0;
J2=0;
J2p=0;
J3=1;
x=[];
y=[];
z=[];
for i=1:1:4
    for j=1:1:4
        lattice=latticeGrt_for_HeisenbergCheck(4);
        lattice(1,1).right.orientation=[0,0,1];
        lattice(i,j).left.orientation=[0,0,1];
        x=[x,sqrt(3)*i+sqrt(3)/2*j];
        y=[y,3/2*j];
        z=[z,calculateHeisenberg(lattice,1,1,0,J1,J1p,J2,J2p,J3)];
    end
end
for i=1:1:4
    for j=1:1:4
        lattice=latticeGrt_for_HeisenbergCheck(4);
        lattice(1,1).right.orientation=[0,0,1];
        lattice(i,j).right.orientation=[0,0,1];
        x=[x,sqrt(3)*i+sqrt(3)/2*j+sqrt(3)/2];
        y=[y,3/2*j+1/2];
        z=[z,calculateHeisenberg(lattice,1,1,0,J1,J1p,J2,J2p,J3)];
    end
end
scatter3(x,y,z,50,z);
ax=gca;
ax.XLim=[1,12];
ax.YLim=[1,8];
colorbar;