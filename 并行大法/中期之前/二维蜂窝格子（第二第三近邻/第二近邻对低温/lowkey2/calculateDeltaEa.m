function [deltaE] = calculateDeltaEa(latticenew,lattice,x,y,leftflag)

deltaE=0;
B=0.1;


deltaE=deltaE+calculateHisenbergE(latticenew,x,y,leftflag)-calculateHisenbergE(lattice,x,y,leftflag);


if leftflag


orient=lattice(x,y).left.orientation;
orientnew=latticenew(x,y).left.orientation;

deltaE=deltaE+(-0.375*B*orientnew(1)-1/4*orientnew(2)^2+1/4*orientnew(3)^2)-(-0.375*B*orient(1)-1/4*orient(2)^2+1/4*orient(3)^2);


else


orient=lattice(x,y).right.orientation;
orientnew=latticenew(x,y).right.orientation;

deltaE=deltaE+(-0.375*B*orientnew(1)-1/4*orientnew(2)^2+1/4*orientnew(3)^2)-(-0.375*B*orient(1)-1/4*orient(2)^2+1/4*orient(3)^2);


end


end

