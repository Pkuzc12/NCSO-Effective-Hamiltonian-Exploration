function [next] = indexnext(now,n,step)


if step>0
    if now+step>n %一些对周期边界坐标近邻的方便索引
        next=indexnext(now-n,n,step);
    else
        next=now+step;
    end
else
    if now+step<1
        next=indexnext(now+n,n,step);
    else
        next=now+step;
    end
end
end

