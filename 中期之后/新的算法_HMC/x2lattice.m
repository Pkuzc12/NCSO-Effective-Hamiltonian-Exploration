function [lattice] = x2lattice(n,x)


for i=1:1:n
    for j=1:1:n
        theta1=x(1,(i-1)*n+j);
        phi1=x(2,(i-1)*n+j);
        theta2=x(3,(i-1)*n+j);
        phi2=x(4,(i-1)*n+j);
        lattice(i,j).left.orientation=[sin(theta1)*cos(phi1);sin(theta1)*sin(phi1);cos(theta1)];
        lattice(i,j).right.orientation=[sin(theta2)*cos(phi2);sin(theta2)*sin(phi2);cos(theta2)];
    end
end

end

