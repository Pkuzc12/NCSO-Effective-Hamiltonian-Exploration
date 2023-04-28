function [deltaE] = calculateDeltaEb(latticenew,lattice,x,y,leftflag,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field)

deltaE=0;


deltaE=deltaE+calculateHeisenberg(latticenew,x,y,leftflag,J1,J1p,J2,J2p,J3)-calculateHeisenberg(lattice,x,y,leftflag,J1,J1p,J2,J2p,J3);
deltaE=deltaE+calculateKitaev(latticenew,x,y,leftflag,K,G,Gs,Kp,Gp,Gps)-calculateKitaev(lattice,x,y,leftflag,K,G,Gs,Kp,Gp,Gps);
%只涉及一个自旋变动，计算这一个变动对能量差的贡献，由于每个菱形左右自旋的近邻索引不同，所以要用leftflag区分左右

if leftflag %由于每个菱形左右自旋的近邻索引不同，所以要用leftflag区分左右


orient=lattice(x,y).left.orientation;
orientnew=latticenew(x,y).left.orientation;

deltaE=deltaE+(field*orientnew(2)+B*orientnew(2)^2+D*orientnew(3)^2)-(field*orient(2)+B*orient(2)^2+D*orient(3)^2);


else


orient=lattice(x,y).right.orientation;
orientnew=latticenew(x,y).right.orientation;

deltaE=deltaE+(field*orientnew(2)+B*orientnew(2)^2+D*orientnew(3)^2)-(field*orient(2)+B*orient(2)^2+D*orient(3)^2);


end


end

