clear all
close all
clc


result=zeros(1,100);
for n=1:1:100
    sum1=zeros(1,63);
    parfor i=1:1:63
        for j=1:1:800
            randi=rand(9,1);
            temp=0;
            for k=1:1:9
                temp=temp-100*(randi(k)-0.5)^2;
            end
            sum1(i)=sum1(i)+exp(temp)/800;
        end
    end
    result(n)=sum(sum1)/63;
end


save myresult.mat