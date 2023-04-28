function [X] = X_fisrt_Grt(n)

X=zeros(4,n*n);
for i=1:1:n
    for j=1:1:n
        randi=rand(4,1);
        X(1,(i-1)*n+j)=randi(1)*pi;
        X(2,(i-1)*n+j)=randi(2)*2*pi;
        X(3,(i-1)*n+j)=randi(3)*pi;
        X(4,(i-1)*n+j)=randi(4)*2*pi;
    end
end

end

