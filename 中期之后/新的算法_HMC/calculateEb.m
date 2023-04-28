function [Eb] = calculateEb(neighbor,x,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field)

Eb=0;
lattice=x2lattice(n,x);

for i=1:1:n
    for j=1:1:n
        Eb=Eb+calculateHeisenberg(neighbor,lattice,i,j,1,J1,J1p,J2,J2p,J3)+calculateHeisenberg(neighbor,lattice,i,j,0,J1,J1p,J2,J2p,J3);
        Eb=Eb+calculateKitaev(neighbor,lattice,i,j,1,K,G,Gs,Kp,Gp,Gps)+calculateKitaev(neighbor,lattice,i,j,0,K,G,Gs,Kp,Gp,Gps);
    end
end

Eb=Eb/2;

for i=1:1:n
    for j=1:1:n
        orient=lattice(i,j).left.orientation;
        Eb=Eb+(field*orient(2)+B*orient(2)^2+D*orient(3)^2);
        orient=lattice(i,j).right.orientation;
        Eb=Eb+(field*orient(2)+B*orient(2)^2+D*orient(3)^2);
    end
end

end

