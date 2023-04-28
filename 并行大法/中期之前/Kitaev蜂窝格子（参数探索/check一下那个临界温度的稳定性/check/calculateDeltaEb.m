function [deltaE] = calculateDeltaEb(latticenew,lattice,x,y,leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D)

deltaE=0;


deltaE=deltaE+calculateHeisenberg(latticenew,x,y,leftflag,J1,J1p,J2,J2p,J3)-calculateHeisenberg(lattice,x,y,leftflag,J1,J1p,J2,J2p,J3);
deltaE=deltaE+calculateKitaev(latticenew,x,y,leftflag,K,G,Gs,Kp,Gp,Gps)-calculateKitaev(lattice,x,y,leftflag,K,G,Gs,Kp,Gp,Gps);


if leftflag


orient=lattice(x,y).left.orientation;
orientnew=latticenew(x,y).left.orientation;

deltaE=deltaE+(-0.375*0.1*orientnew(2)+B/4*orientnew(2)^2+D/4*orientnew(3)^2)-(-0.375*0.1*orient(2)+B/4*orient(2)^2+D/4*orient(3)^2);


else


orient=lattice(x,y).right.orientation;
orientnew=latticenew(x,y).right.orientation;

deltaE=deltaE+(-0.375*0.1*orientnew(2)+B/4*orientnew(2)^2+D/4*orientnew(3)^2)-(-0.375*0.1*orient(2)+B/4*orient(2)^2+D/4*orient(3)^2);


end


end

