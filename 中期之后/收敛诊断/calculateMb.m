function [Mb] = calculateMb(x,n)

Mb=0;

for i=1:1:n
    for j=1:1:n
        theta1=x(1,(i-1)*n+j);
        theta2=x(3,(i-1)*n+j);
        phi1=x(2,(i-1)*n+j);
        phi2=x(4,(i-1)*n+j);
        Mb=Mb+sin(theta1)*sin(phi1)+sin(theta2)*sin(phi2);
    end
end

Mb=Mb/(n*n*2);


end

