function [y] = indexCalculator(x,leng,n)


if (x+leng)>n
    y=indexCalculator(x-n,leng,n);
else
    y=x+leng;
end

end