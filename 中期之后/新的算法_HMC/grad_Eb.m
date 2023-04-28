function [gradEb] = grad_Eb(coef,x,n,field)

S=grad_Eb_helper(coef,x,n,field);
gradEb=zeros(4,n*n);


for i=1:1:n
    for j=1:1:n
        theta=x(1,n*(i-1)+j);
        phi=x(2,n*(i-1)+j);
        gradEb(1,(i-1)*n+j)=S(1,(i-1)*n+j)*cos(theta)*cos(phi)+S(2,(i-1)*n+j)*cos(theta)*sin(phi)-S(3,(i-1)*n+j)*sin(theta);
        gradEb(2,(i-1)*n+j)=-S(1,(i-1)*n+j)*sin(theta)*sin(phi)+S(2,(i-1)*n+j)*sin(theta)*cos(phi);
        theta=x(3,n*(i-1)+j);
        phi=x(4,n*(i-1)+j);
        gradEb(3,(i-1)*n+j)=S(4,(i-1)*n+j)*cos(theta)*cos(phi)+S(5,(i-1)*n+j)*cos(theta)*sin(phi)-S(6,(i-1)*n+j)*sin(theta);
        gradEb(4,(i-1)*n+j)=-S(4,(i-1)*n+j)*sin(theta)*sin(phi)+S(5,(i-1)*n+j)*sin(theta)*cos(phi);
    end
end

end

