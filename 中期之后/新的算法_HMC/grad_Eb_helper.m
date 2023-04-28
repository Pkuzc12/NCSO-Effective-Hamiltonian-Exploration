function [S] = grad_Eb_helper(coef,x,n,field)

S=zeros(6,n*n);

dir=zeros(6*n*n,1);
for i=1:1:n
    for j=1:1:n
        dir(((i-1)*n+j-1)*6+1)=cos(x(1,(i-1)*n+j))*cos(x(2,(i-1)*n+j));
        dir(((i-1)*n+j-1)*6+2)=cos(x(1,(i-1)*n+j))*sin(x(2,(i-1)*n+j));
        dir(((i-1)*n+j-1)*6+3)=sin(x(1,(i-1)*n+j));
        dir(((i-1)*n+j-1)*6+4)=cos(x(3,(i-1)*n+j))*cos(x(4,(i-1)*n+j));
        dir(((i-1)*n+j-1)*6+5)=cos(x(3,(i-1)*n+j))*sin(x(4,(i-1)*n+j));
        dir(((i-1)*n+j-1)*6+6)=sin(x(3,(i-1)*n+j));
    end
end

temp=2*coef*dir;

for i=1:1:n
    for j=1:1:n
        for k=1:1:6
            S(k,(i-1)*n+j)=temp(((i-1)*n+j-1)*6+k);
        end
        S(2,(i-1)*n+j)=S(2,(i-1)*n+j)+field;
        S(4,(i-1)*n+j)=S(4,(i-1)*n+j)+field;
    end
end

end

