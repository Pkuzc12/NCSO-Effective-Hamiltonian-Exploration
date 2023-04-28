function [Mb] = calculateMb(lattice)


Mb=lattice(1,1).left.orientation(2);


end

%抽取单个自旋作为样本(?