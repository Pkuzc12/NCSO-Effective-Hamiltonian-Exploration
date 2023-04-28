function [A] = latticeGrt_for_KitaevCheck(n)


for x=1:1:n
    for y=1:1:n
        A(x,y).left.orientation=[-sqrt(2/3);0;sqrt(1/3)];
        A(x,y).right.orientation=[-sqrt(2/3);0;sqrt(1/3)];
    end
end


for x=1:1:n
    for y=1:1:n
        A(x,y).left.neighbor=[[indexnext(x,n,-1),y];[x,indexnext(y,n,-1)];[x,y]];
        A(x,y).right.neighbor=[[indexnext(x,n,1),y];[x,indexnext(y,n,1)];[x,y]];
    end
end


for x=1:1:n
    for y=1:1:n
        A(x,y).left.neighbor2=[[indexnext(x,n,-1),indexnext(y,n,1)];[indexnext(x,n,-1),y];[x,indexnext(y,n,-1)];[indexnext(x,n,1),indexnext(y,n,-1)];[indexnext(x,n,1),y];[x,indexnext(y,n,1)]];
        A(x,y).right.neighbor2=[[indexnext(x,n,-1),indexnext(y,n,1)];[x,indexnext(y,n,1)];[indexnext(x,n,1),y];[indexnext(x,n,1),indexnext(y,n,-1)];[x,indexnext(y,n,-1)];[indexnext(x,n,-1),y]];
    end
end


for x=1:1:n
    for y=1:1:n
        A(x,y).left.neighbor3=[[indexnext(x,n,-1),indexnext(y,n,-1)];[indexnext(x,n,1),indexnext(y,n,-1)];[indexnext(x,n,-1),indexnext(y,n,1)]];
        A(x,y).right.neighbor3=[[indexnext(x,n,1),indexnext(y,n,1)];[indexnext(x,n,1),indexnext(y,n,-1)];[indexnext(x,n,-1),indexnext(y,n,1)]];
    end
end

end
