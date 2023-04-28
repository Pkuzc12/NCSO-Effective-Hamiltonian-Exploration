function [CoAmp] = CA_beta(lattice,leng)


r=mod(leng,2);
s=idivide((leng-r),int16(2));


if r==0
    CoAmp=dot(lattice(1,1).left.orientation,lattice(1,1+s).left.orientation);
else
    CoAmp=dot(lattice(1,1).left.orientation,lattice(1,1+s).right.orientation);
end


end

