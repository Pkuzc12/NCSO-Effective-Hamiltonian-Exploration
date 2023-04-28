function [deltaE] = calculateDeltaE(latticenew,lattice,x,y,leftflag,J)

deltaE=0;
B=0.1;


deltaE=deltaE+calculateHisenbergE(latticenew,x,y,leftflag,J)-calculateHisenbergE(lattice,x,y,leftflag,J);


if leftflag


orient=lattice(x,y).left.orientation;
orientnew=latticenew(x,y).left.orientation;

deltaE=deltaE+(-1/4*orientnew(2)^2+1/4*orientnew(3)^2)-(-1/4*orient(2)^2+1/4*orient(3)^2);


else


orient=lattice(x,y).right.orientation;
orientnew=latticenew(x,y).right.orientation;

deltaE=deltaE+(-1/4*orientnew(2)^2+1/4*orientnew(3)^2)-(-1/4*orient(2)^2+1/4*orient(3)^2);


end


end

