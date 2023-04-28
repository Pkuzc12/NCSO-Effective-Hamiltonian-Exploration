function [Mb] = calculateMb(X,n)


Mb=0;

for x=1:1:n
    for y=1:1:n

        theta1=X(1,(x-1)*n+y);
        theta2=X(3,(x-1)*n+y);
        phi1=X(2,(x-1)*n+y);
        phi2=X(4,(x-1)*n+y);

      Mb=Mb+sin(theta1)*sin(phi1)+sin(theta2)*sin(phi2);
    end
end

Mb=Mb/(n*n*2);


end

