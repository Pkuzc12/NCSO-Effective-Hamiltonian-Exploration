function [CoAmp] = CA(lattice,leng,b)


n=length(lattice);
CoAmp=0;

if b
for i=1:1:n
    next=indexCalculator(i,leng,n);
    CoAmp=CoAmp+1/2*dot(lattice(i,i).left.orientation,lattice(next,next).left.orientation)+1/2*dot(lattice(i,i).right.orientation,lattice(next,next).right.orientation);
end
else
    for i=1:1:n
        next=indexCalculator(i,leng,n);
        CoAmp=CoAmp+1/2*dot(lattice(i,n+1-i).left.orientation,lattice(next,n+1-next).left.orientation)+1/2*dot(lattice(i,n+1-i).right.orientation,lattice(next,n+1-next).right.orientation);
    end
end

CoAmp=CoAmp/n;

end

