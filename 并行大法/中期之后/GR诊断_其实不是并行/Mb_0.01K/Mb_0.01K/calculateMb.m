function [Mb] = calculateMb(lattice,n)

Mb=0;

for x=1:1:n
    for y=1:1:n

      Mb=Mb+lattice(x,y).left.orientation(2)+lattice(x,y).right.orientation(2);
    end
end

Mb=Mb/(n*n*2);


end

