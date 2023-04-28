function [Ma] = calculateMa(lattice,n)


Ma=0;

for x=1:1:n
    for y=1:1:n

      Ma=Ma+lattice(x,y).left.orientation(1)+lattice(x,y).right.orientation(1);
    end
end

Ma=Ma/(n*n*2);


end

