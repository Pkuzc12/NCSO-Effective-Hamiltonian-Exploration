function [A] = latticeGrt(n)


for x=1:1:n
    for y=1:1:n
        randi=rand(4,1);
        A(x,y).left.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi),sin(randi(2)*pi)*sin(randi(1)*2*pi),cos(randi(2)*pi)];
        A(x,y).right.orientation=[sin(randi(4)*pi)*cos(randi(3)*2*pi),sin(randi(4)*pi)*sin(randi(3)*2*pi),cos(randi(4)*pi)];
    end
end


if n==1
    A(1,1).left.neighbor=[[1,1];[1,1];[1,1]];
    A(1,1).right.neighbor=[[1,1];[1,1];[1,1]];
else


for x=2:1:(n-1)
    for y=2:1:(n-1)
        A(x,y).left.neighbor=[[x,y];[x-1,y];[x,y-1]];
        A(x,y).right.neighbor=[[x,y];[x,y+1];[x+1,y]];
    end
end


for x=2:1:(n-1)
    A(x,1).left.neighbor=[[x,1];[x-1,1];[x,n]];
    A(x,1).right.neighbor=[[x,1];[x,2];[x+1,1]];
    A(x,n).left.neighbor=[[x,n];[x-1,n];[x,n-1]];
    A(x,n).right.neighbor=[[x,n];[x,1];[x+1,n]];
end


for y=2:1:(n-1)
    A(1,y).left.neighbor=[[1,y];[n,y];[1,y-1]];
    A(1,y).right.neighbor=[[1,y];[1,y+1];[2,y]];
    A(n,y).left.neighbor=[[n,y];[n-1,y];[n,y-1]];
    A(n,y).right.neighbor=[[n,y];[n,y+1];[1,y]];
end


A(1,1).left.neighbor=[[1,1];[n,1];[1,n]];
A(1,1).right.neighbor=[[1,1];[1,2];[2,1]];


A(n,1).left.neighbor=[[n,1];[n-1,1];[n,n]];
A(n,1).right.neighbor=[[n,1];[n,2];[1,1]];


A(1,n).left.neighbor=[[1,n];[n,n];[1,n-1]];
A(1,n).right.neighbor=[[1,n];[1,1];[2,n]];


A(n,n).left.neighbor=[[n,n];[n-1,n];[n,n-1]];
A(n,n).right.neighbor=[[n,n];[n,1];[1,n]];


end


end

