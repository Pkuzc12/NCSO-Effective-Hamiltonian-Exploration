function [A] = latticeGrt(n)


for x=1:1:n
    for y=1:1:n
        randi=rand(4,1);
        A(x,y).left.orientation=[sin(randi(2)*pi)*cos(randi(1)*2*pi);sin(randi(2)*pi)*sin(randi(1)*2*pi);cos(randi(2)*pi)];
        A(x,y).right.orientation=[sin(randi(4)*pi)*cos(randi(3)*2*pi);sin(randi(4)*pi)*sin(randi(3)*2*pi);cos(randi(4)*pi)];
    end
end %自旋configuration初始化，随机


for x=1:1:n
    for y=1:1:n
        A(x,y).left.neighbor=[[indexnext(x,n,-1),y];[x,indexnext(y,n,-1)];[x,y]];
        A(x,y).right.neighbor=[[indexnext(x,n,1),y];[x,indexnext(y,n,1)];[x,y]];
    end
end %第一近邻


for x=1:1:n
    for y=1:1:n
        A(x,y).left.neighbor2=[[indexnext(x,n,-1),indexnext(y,n,1)];[indexnext(x,n,-1),y];[x,indexnext(y,n,-1)];[indexnext(x,n,1),indexnext(y,n,-1)];[indexnext(x,n,1),y];[x,indexnext(y,n,1)]];
        A(x,y).right.neighbor2=[[indexnext(x,n,-1),indexnext(y,n,1)];[x,indexnext(y,n,1)];[indexnext(x,n,1),y];[indexnext(x,n,1),indexnext(y,n,-1)];[x,indexnext(y,n,-1)];[indexnext(x,n,-1),y]];
    end
end %第二近邻


for x=1:1:n
    for y=1:1:n
        A(x,y).left.neighbor3=[[indexnext(x,n,-1),indexnext(y,n,-1)];[indexnext(x,n,1),indexnext(y,n,-1)];[indexnext(x,n,-1),indexnext(y,n,1)]];
        A(x,y).right.neighbor3=[[indexnext(x,n,1),indexnext(y,n,1)];[indexnext(x,n,1),indexnext(y,n,-1)];[indexnext(x,n,-1),indexnext(y,n,1)]];
    end
end %第三近邻


end

