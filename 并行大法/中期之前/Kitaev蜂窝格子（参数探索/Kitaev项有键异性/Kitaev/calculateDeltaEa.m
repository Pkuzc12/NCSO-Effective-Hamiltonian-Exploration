function [deltaE] = calculateDeltaEa(latticenew,lattice,x,y,leftflag)

deltaE=0;
B=-1.1431;
D=0.296;


deltaE=deltaE+calculateHeisenberg(latticenew,x,y,leftflag)-calculateHeisenberg(lattice,x,y,leftflag);
deltaE=deltaE+calculateKitaev(latticenew,x,y,leftflag)-calculateKitaev(lattice,x,y,leftflag);


if leftflag


orient=lattice(x,y).left.orientation;
orientnew=latticenew(x,y).left.orientation;

deltaE=deltaE+(-0.375*0.1*orientnew(1)+B/4*orientnew(2)^2+D/4*orientnew(3)^2)-(-0.375*0.1*orient(1)+B/4*orient(2)^2+D/4*orient(3)^2);


else


orient=lattice(x,y).right.orientation;
orientnew=latticenew(x,y).right.orientation;

deltaE=deltaE+(-0.375*0.1*orientnew(1)+B/4*orientnew(2)^2+D/4*orientnew(3)^2)-(-0.375*0.1*orient(1)+B/4*orient(2)^2+D/4*orient(3)^2);


end


end

