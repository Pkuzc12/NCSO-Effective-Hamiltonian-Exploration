function [X] = X_Grt_for_BDfieldCheck(n)

X=zeros(4*n*n,1);

for i=1:1:n
    for j=1:1:n
        randi=[1/2,0,1/2,0];
        X(((i-1)*n+j-1)*4+1)=randi(1)*pi;
        X(((i-1)*n+j-1)*4+2)=randi(2)*2*pi;
        X(((i-1)*n+j-1)*4+3)=randi(3)*pi;
        X(((i-1)*n+j-1)*4+4)=randi(4)*2*pi;
    end
end

end

