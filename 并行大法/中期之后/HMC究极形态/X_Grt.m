function [X] = X_Grt(n)

X=zeros(4*n*n,1);

for i=1:1:n
    for j=1:1:n
        randi=rand(1,4);
        X(((i-1)*n+j-1)*4+1)=randi(1)*pi;
        X(((i-1)*n+j-1)*4+2)=randi(2)*2*pi;
        X(((i-1)*n+j-1)*4+3)=randi(3)*pi;
        X(((i-1)*n+j-1)*4+4)=randi(4)*2*pi;
    end
end

end

