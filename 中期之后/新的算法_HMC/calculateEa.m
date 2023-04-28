function [Ea] = calculateEa(lattice,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field)

Ea=0;

for i=1:1:n
    for j=1:1:n
        Ea=Ea+calculateHeisenberg(lattice,i,j,1,J1,J1p,J2,J2p,J3)+calculateHeisenberg(lattice,i,j,0,J1,J1p,J2,J2p,J3);
        Ea=Ea+calculateKitaev(lattice,i,j,1,K,G,Gs,Kp,Gp,Gps)+calculateKitaev(lattice,i,j,0,K,G,Gs,Kp,Gp,Gps);
    end
end

Ea=Ea/2;

for i=1:1:n
    for j=1:1:n
        orient=lattice(i,j).left.orientation;
        Ea=Ea+(field*orient(1)+B*orient(2)^2+D*orient(3)^2);
        orient=lattice(i,j).right.orientation;
        Ea=Ea+(field*orient(1)+B*orient(2)^2+D*orient(3)^2);
    end
end

end

