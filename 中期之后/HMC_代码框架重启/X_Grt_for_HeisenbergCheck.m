function [X] = X_Grt_for_HeisenbergCheck(n)

X=zeros(n*n*4,1);

for i=1:1:n
    for j=1:1:n
        index=((i-1)*n+j-1)*4;
        randi=rand(4,1);
        randi(1)=0;
        randi(3)=0;
        X(index+1)=randi(1)*pi;
        X(index+2)=randi(2)*2*pi;
        X(index+3)=randi(3)*pi;
        X(index+4)=randi(4)*2*pi;
    end
end

end

